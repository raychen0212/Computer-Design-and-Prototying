org 0x0000
ori $1, $0, 30 
ori $2, $0, 30
ori $3, $0, 5
ori $29, $0, 0xFFFC

beq $1, $2, pass_beq
add $4, $1, $2
sub $4, $2, $3
HALT

pass_beq:
add $4, $1, $2
and $5, $3, $2
or  $6, $1, $3
j jumping //jump hazard
add $4, $2, $2
and $4, $1, $2

jumping:
add $6, $1, $2
sw $4, 8($6)

HALT
