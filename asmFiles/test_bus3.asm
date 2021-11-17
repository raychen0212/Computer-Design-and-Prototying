#core 1
org 0x0000
    ori $1, $zero, 0x400
    ori $2, $zero, 0x404
    lw $3, 0($1) #in shared state $3=dead
    lw $4, 0($2) #stay in shared state $4=beef
    addi $3, $3, 1
    addi $4, $4, 4
    sw $3, 0($1) # go to modified state
    sw $4, 0($2) 
    halt
#core 2
org 0x0200
    ori $1, $zero, 0x404
    ori $2, $zero, 0x408
    lw $3, 4($1)
    lw $4, 4($2) 
    addi $3, $3, -8
    addi $4, $4, 5
    sw $3, 4($1)
    sw $4, 4($2)
    halt

org 0x0400
    cfw 0xDEAD
    cfw 0xBEEF
    cfw 0x1234
    cfw 0x5678
    
