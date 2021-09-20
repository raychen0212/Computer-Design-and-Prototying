org 0x0000
ori $6, $0, 0 #the final result
ori $5, $0, 0 #initialize register 5 to 0 to compare with multiplier (3)
ori $1, $0, 12 #initialize the first number
ori $2, $0, 11 #initialize the second number
ori $3, $0, 1
ori $29, $0, 0xFFFC #intialize stack pointer at 0xfffc


push $1 #push 8 into stack
push $2 #push 3 into stack
#the first number in stack is 8 and the second number is 3.

multiply:
    ori $3, $0, 1 #initialize 1 as the subtractor
    pop $8 #set register 8 to number 3
    pop $9 #set register 9 to number 8

the_loop:
    beq $8, $5, done
    add $6, $6, $9
    sub $8, $8, $3 #decrease 3 by 1 all the time
    j the_loop
done:
    sw $6, 0($8)
    push $6
    
    halt
    
