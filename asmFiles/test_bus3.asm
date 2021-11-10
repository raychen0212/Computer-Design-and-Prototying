#core 1
org 0x0000
    ori $1, $zero, 5
    ori $2, $zero, 4
    lw $3, 0($1) #in shared state 
    lw $4, 0($2) #stay in shared state
    add $3, $3, $1
    add $4, $4, $2
    sw $3, 0($1) # go to modified state
    sw $4, 0($2) 
    addi $3, $3, 1 
    lw $3, 0($1)
    halt
#core 2
org 0x0200
    ori $1, $zero, 5 
    ori $2, $zero, 6
    lw $3, 4($1)
    lw $4, 4($2) 
    sub $3, $3, $1
    add $4, $$4, $2
    sw $3, 4($1)
    sw $4, 4($2)
    sub $4, $3, $1
    lw $4, 4($1)
    halt

org 0x0400
    cfw 0xDEAD
    cfw 0xBEEF
    cfw 0x1234
    cfw 0x5678
    
