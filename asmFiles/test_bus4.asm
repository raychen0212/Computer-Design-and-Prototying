#core1
org 0x0000
    ori $1, $zero, 10
    ori $2, $zero, data1
    sw $1, 0($2)
    halt
#core2
org 0x0200
    ori $1, $zero, 20
    ori $2, $zero, data2
    nop
    sw $1, 0($2)
    halt

org 0x0400
data1:
  cfw 0xBAD0BAD0
org 0x4080
data2:
  cfw 0xBAD0BAD0
