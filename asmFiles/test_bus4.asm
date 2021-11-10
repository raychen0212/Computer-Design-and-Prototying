#core1
org 0x0000
    ori $1, $zero, 10
    sw $1, 0($1)
    halt
#core2
org 0x0200
    ori $1, $zero, 20
    nop
    sw $1, 0($1)
    halt
