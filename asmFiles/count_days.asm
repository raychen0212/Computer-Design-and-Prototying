org 0x0000
ori $1, $0, 30 #to calculate the month
ori $2, $0, 365 #to calculate the year 365*
ori $3, $0, 2000 #to calculate the year 2000
ori $4, $0, 1 # to subtract
ori $5, $0, 31 #day
ori $6, $0, 8 #month
ori $7, $0, 2021 #year
ori $8, $0, 0
ori $12, $0, 0 #result 1
ori $13, $0, 0 #result 2
ori $29, $0, 0xFFFC

sub $6, $6, $4 #r6 = 7
sub $7, $7, $3 #r7 = 21

push $6
push $7

multiply:
    ori $9, $0, 1 #initialize 1 as the subtractor
    pop $7
    pop $6 
    j the_loop

the_loop:
    beq $8, $6, done1
    add $12, $12, $1
    sub $6, $6, $9 #decrease 3 by 1 all the time
    j the_loop

done1:
    ori $9, $0, 1 #initialize 1 as the subtractor
    
    j the_loop1

the_loop1:
    beq $8, $7, finish
    add $13, $13, $2
    sub $7, $7, $9 #decrease 3 by 1 all the time
    j the_loop1
finish:
    add $13, $13, $12
    add $13, $13, $5
    sw $13, 0xf0f0($0)
    push $13
    HALT
