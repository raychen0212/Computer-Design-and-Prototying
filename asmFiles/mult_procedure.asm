org 0x0000
ori $29, $0, 0xFFFC #intialize stack pointer at 0xfffc
ori $1, $0, 2 #initialize the first number
ori $2, $0, 4 #initialize the second number
ori $3, $0, 6 #initialize the third number
ori $4, $0, 8 #initialize the fourth number
ori $5, $0, 0 #initialize register 5 to 0 to compare with multiplier 
ori $6, $0, 0 #the final result
ori $7, $0, 4 #there are 4 numbers to subtract
ori $8, $0, 4
push $1 #push the first number to the stack (bottom)
push $2 #push the second number to the stack (2nd bottom)
push $3 #push the thrid number to the stack (3rd bottom)
push $4 #push the fourth number to the stack (top)
ori $3, $0, 1 #initialize 1 as the subtractor

multiply:
    pop $1 #pop the top number
    pop $2 #pop the second number
    bne $8, $7, subtraction
    j the_loop
subtraction:
    sub $2, $2, $3
    j the_loop
nxt_multiply:
    push $6
    sub $7, $7, $3
    beq $7, $3, done
    j multiply

the_loop:
    beq $2, $5, nxt_multiply
    add $6, $6, $1
    sub $2, $2, $3 #decrease 1 all the time
    j the_loop

done:
    sw $6, 0xf0f0($0)
    push $6
    halt
