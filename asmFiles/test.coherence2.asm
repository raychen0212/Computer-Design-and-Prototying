# Multicore coherence test
# stores 0xDEADBEEF to value

#core 1
org 0x0000
  ori $t0, $0, word1   #t0 = 40c
  lw  $t1, 0($t0)       #t1 = 0000dead
  ori $t2, $0, 16     #t2 = 16
  sllv $t1, $t2, $t1    #t1 = dead0000
  ori $t4, $0, value  #t4 = 408
  ori $t2, $0, flag     #t2 = 400

# wait for core 2 to finish
wait1:
  lw  $t3, 0($t2)  #400=0,  400=1
  beq $t3, $0, wait1

# complete store
  lw  $t0, 0($t4)    #t0 = 0000beef
  or  $t0, $t0, $t1  #t0 = deadbeef
  sw  $t0, 0($t4)     #408 = deadbeef

  halt

# core 2
org 0x0200
  ori $t0, $0, word2   #t0 = 410
  lw  $t1, 0($t0)     #t1 = 0000beef
  ori $t2, $0, value   #t2 = 408
  sw  $t1, 0($t2)       #408 = 0000beef

# set flag
  ori $t1, $0, flag    #t1 = 400
  ori $t2, $0, 1        #t2 = 1

  sw  $t2, 0($t1)     #400 = 1
  halt

org 0x0400
flag:
  cfw 0

org 0x0408
value:
  cfw 0

word1:
  cfw 0x0000DEAD
  cfw 0
word2:
  cfw 0x0000BEEF

