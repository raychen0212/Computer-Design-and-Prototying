org 0x0000

ori $8, $0, 0xf0
ori $1, $0, 1
ori $2, $0, 2

ori $5, $0, 3
ori $6, $0, 0

loop:
    lw $3, 0($8) 
    add $4, $1, $2
    addi $1, $1, 1
    sub $6, $5, $2//dhit & ihit
    bne $1, $5, loop
end:
    sw $4, 0($8)
halt

org 0xf0
cfw 0xdead





