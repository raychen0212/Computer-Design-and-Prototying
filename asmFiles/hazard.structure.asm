org 0x0000
ori $1, $0, 0x0FF0
ori $2, $0, 0xF000
ori $4, $0, 100
ori $29, $0, 0xFFFC

lw  $3, 0($1)//load hazard
add $4, $3, $4
sw $5, 4($4)

HALT
