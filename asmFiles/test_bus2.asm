#core 1
org 0x0000
    ori $1, $zero, 5
    ori $2, $zero, 6
    add $2, $2, $1
    sw $2, 0($1)
    halt
    
#core 2
org 0x0200
    ori $1, $zero, 5 
    ori $2, $zero, 2
    sub $2, $2, $1
    sw $2, 4($1)
    halt

    
