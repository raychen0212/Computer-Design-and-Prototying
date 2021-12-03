#First Processor#
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  jal   mainp0              # go to program
  halt

#first main
mainp0:
  push $ra
  ori $t6, $zero, 256
  ori $t7, $zero, 0xabcd
  ori $t8, $zero, 1
getRandom:
  ori $a0, $t7, 0
  jal crc32
  ori $t9, $v0, 0 #t9 is holding the result from crc32
  ori $a0, $zero, l1      # move lock to arguement register
  jal lock                # try to aquire the lock

#push_func:
  ori $t0, $zero, stackpointer
  lw $t1, 0($t0)
  ori $t0, $zero, stackbase
  lw $t2, 0($t0)
  sub $t3, $t2, $t1
  sw $t9, 0($t3)
  ori $t3, $zero, 4
  add $t1, $t1, $t3
  ori $t0, $zero, stackpointer
  sw $t1, 0($t0)
  
lockrealease:
  ori $a0, $zero, l1      #next random generator argumnet
  jal unlock
  addi $t8, $t8, 1
  beq $t8, $t6, exit_p1
  j getRandom
exit_p1:  
  pop $ra
  jr $ra
l1:
  cfw 0x0000



#Second Processor#
  
  org   0x200             # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  jal   mainp1              # go to program
  halt


mainp1:
  push $ra
  ori $t8, $zero, 256 #the max value
  ori $t9, $zero, 0 #counter
  ori $s1, $zero, 0xFFFFFFFF #MIN VALUE
  ori $s2, $zero, 0x00000000 #MAX VALUE
  or $s0, $zero, $zero #s0 is the sum
check:
  ori $t0, $zero, stackpointer
  lw $t1, 0($t0)
  bne $t1, $zero, pop_func
  j check
pop_func:
  ori $a0, $zero, l1
  jal lock
  ori $t0, $zero, stackpointer
  lw $t0, 0($t0)
  ori $t1, $zero, stackbase
  lw $t1, 0($t1)
  ori $t2, $zero, 4
  sub $t0, $t0, $t2 #need to decrement by 4 to get the offset
  sub $t3, $t1, $t0
  lw $v0, 0($t3) #pop value
  sw $zero, 0($t3)
  ori $t0, $zero, stackpointer
  sw $t1, 0($t0)
  
  ori $a0, $zero, l1
  jal unlock

  #need lower 16 bits
  ori $t0, $zero, 0xFFFF
  and $a0, $t0, $s1
  and $a1, $v0, $t0
  #ori $t5, $a1, 0 #t5 = a1 value to be use in sum
  #ori $t4, $a1, 0 #move v0 (pop value) to t4
  jal min
  ori $s3, $v0, 0 #value of min
  and $a0, $s2, $t0
  jal max
  ori $s4, $v0, 0 #value of max
  #compute sum
  add $s5, $s4, $s3 #s4 is sum of max and min
  
  addi $t9, $t9, 1
  beq $t9, $t8, getaverage
  j check

getaverage:
  ori $a0, $s5, 0
  ori $a1, $zero, 256
  jal divide
  ori $s6, $v0, 0 #s6 is the average
  ori $s7, $v1, 0 #s7 is the remainder
  ori $t0, $zero, min_addr
  ori $t1, $zero, max_addr
  ori $t2, $zero, sum_addr
  ori $t3, $zero, average_addr
  ori $t4, $zero, remainder_addr
  sw $s3, 0($t0)
  sw $s4, 0($t1)
  sw $s5, 0($t2)
  sw $s6, 0($t3)
  sw $s7, 0($t4)
  j exit_p2
exit_p2:
  pop $ra
  jr $ra

stackpointer:
  cfw 0x5000
stackbase:
  cfw 0x5000
org 0xB000
min_addr:
  cfw 0xDEAD1111
max_addr:
  cfw 0xDEAD2222
sum_addr:
  cfw 0xDEAD3333
average_addr:
  cfw 0xDEAD4444
remainder_addr:
  cfw 0xDEAD5555


#LOCK#
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

#UNLOCK#
# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra



#push function#

  #jr $ra


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

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

crc1:
  slt $t4, $t2, $t3
  beq $t4, $zero, crc2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, crc3
  xor $a0, $a0, $t1
crc3:
  addiu $t2, $t2, 1
  j crc1
crc2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------
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
