#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

#####################################
# Processor 1
#####################################
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  jal   mainp0              # go to program
  halt

mainp0:
    push $ra
    ori $t7, $zero, 256     #number of random numbers to generate
    ori $t8, $zero, 0x3    #Initial seed value
    ori $t9, $zero, 1       

generate:
    or $a0, $zero, $t8     #or the seed value into the function parameter
    jal crc32
    or $t6, $zero, $v0

    #push result to stack w/ lock
    ori   $a0, $zero, l1      # move lock to arguement register
    jal   lock                # try to aquire the lock
    or $a0, $zero, $t6
    jal pushStack
    ori   $a0, $zero, l1      # move lock to arguement register
    jal   unlock              # release the lock

    or $t8, $zero, $t6      #set new seed as crc result
    sub $t7, $t7, $t9       #subtract 256 by 1
    bne $t7, $zero, generate
    pop $ra
    jr $ra

l1:
  cfw 0x0

#####################################
# Processor 2
#####################################
  org   0x1000               # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  jal   mainp1              # go to program
  halt

mainp1:
  push $ra
  ori $t6 , $zero, 256    #256 values to go through
  ori $t7, $zero, 0       #number values popped from stack
  ori $s1, $zero, 0xFFFFFFFF  #min value
  ori $s2, $zero, 0x00000000  #max value
  ori $s3, $zero, 0  #running sum of values

popValue: 
  jal empty   #Check if the stack is empty

continue:
  #push result to stack w/ lock
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   lock                # try to aquire the lock
  jal popStack
  or $t8, $zero, $v0       #put return value into temp register
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   unlock              # release the lock

  #min calculation
  andi $a0, $t8, 0x0000FFFF
  andi $a1, $s1, 0x0000FFFF
  jal min
  or $s1, $zero, $v0 #min value

  #max calculation
  andi $a0, $t8, 0x0000FFFF
  andi $a1, $s2, 0x0000FFFF
  jal max
  or $s2, $zero, $v0 #max value

  #update sum and number random values popped
  addi $t7, $t7, 1          #add 1 to number of values popped from stack
  andi $t8, $t8, 0x0000FFFF
  add $s3, $s3, $t8       #add to running sum of random values
  bne $t7, $t6, popValue    #check if the number of values popped equals number of values meant to be on stack - 256

average:
  or $a0, $zero, $s3
  or $a1, $zero, $t7
  jal divide
  or $s3, $zero, $v0  #quotient
  or $s4, $zero, $v1  #remainder

  #store values to memory
  ori $t0, $zero, avg
  sw $s3, 0($t0)
  ori $t0, $zero, final_max
  sw $s2, 0($t0)
  ori $t0, $zero, final_min
  sw $s1, 0($t0)
  pop $ra
  jr $ra

res:
  cfw 0x0 

#----------Stack Subroutines-----------
empty:
    ori $t0, $zero, stackptr
    lw $t1, 0($t0)              #load the current value of the stackptr offset (used to index)
    beq $t1, $zero, empty        #if stackptr is zero loop until it is not then return
    jr $ra

true:
    ori $v0, $zero, 1
    jr $ra

pushStack:
    ori $t0, $zero, stackptr
    lw $t2, 0($t0)              #load the current value of the stackptr offset (used to index)
    ori $t1, $zero, stackhead 
    lw $t3, 0($t1)              #load value of the head of the stack (where values reside)
    sub $t3, $t3, $t2           #get the current index of where the value is we want to push to
    sw $a0, 0($t3)              #store value
    addi $t2, $t2, 4            #decrement stack ptr, increment offset
    sw $t2, 0($t0)              #store stackptr back
    jr $ra

popStack:
    ori $t0, $zero, stackptr
    lw $t2, 0($t0)              #load the current value of the stackptr offset (used to index)
    ori $t1, $zero, stackhead 
    lw $t3, 0($t1)              #load value of the head of the stack (where values reside)
    addi $t2, $t2, -4           #get offset value
    sub $t3, $t3, $t2           #get the current index of where the value is we want to pop from
    lw $v0, 0($t3)              #load value from memory
    sw $zero, 0($t3)            #zero out the topmost stack location
    sw $t2, 0($t0)              #store stackptr back
    jr $ra


# -------------LOCK and UNLOCK---------------
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra


# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra

# -------------CRC Subroutine---------------
# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

c1:
  slt $t4, $t2, $t3
  beq $t4, $zero, c2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, c3
  xor $a0, $a0, $t1
c3:
  addiu $t2, $t2, 1
  j c1
c2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------


# -----------Division Subroutine--------------
# registers a0-1,v0-1,t0
# a0 = Numerator
# a1 = Denominator
# v0 = Quotient
# v1 = Remainder

#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#-divide--------------------------------------------

# ------------MIN/MAX Subroutine---------------
# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result

#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------


stackptr:
    cfw 0x0000

stackhead:
    cfw 0x9000

org 0xC000
avg:
  cfw 0xBAD1BAD1
final_max:
  cfw 0xBAD1BAD1
final_min:
  cfw 0xBAD1BAD1
