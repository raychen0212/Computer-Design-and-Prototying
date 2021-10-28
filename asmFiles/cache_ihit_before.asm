org 0x0000

ori $8, $0, 0x0f0
ori $1, $0, 1
ori $2, $0, 2
ori $5, $0, 3

loop:
    lw $3, 0($8) 
    add $4, $1, $2
    sub $5, $5, $1
    sw $5, 0($8)
    addi $8, $8, 0x4
    bne $5, $0, loop
end:
    sw $4, 0($8)
    halt

org 0x0f0
cfw 0xdead
org 0x0f4
cfw 0xBEEF
org 0x0f8
cfw 0x1234


