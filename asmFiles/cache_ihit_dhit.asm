org 0x0000

ori $8, $0, 0x0fff
ori $1, $0, 1
ori $2, $0, 2
ori $3, $0, 0
ori $4, $0, 0
ori $5, $0, 3

loop:
    lw $3, 0($8) 
    add $4, $1, $2
    addi $1, $1, 1
    sub $4, $1, $2//dhit & ihit
    bne $1, $5, loop
end:
    sw $4, 0($8)
    halt

org 0x0fff
cfw 0xBEEF