#core1
org 0x0000
    ori $1, $zero, 0x400
    sw $1, 0($1)
    halt
#core2
org 0x0200
    ori $1, $zero, 0x400
    nop
    nop
    lw $1, 0($1)
    halt
