org 0x0000
ori $1, $0, 30 
ori $2, $0, 10
ori $3, $0, 5
ori $7, $0, 12
ori $9, $0, 6
ori $11, $0, 18
ori $29, $0, 0xFFFC

add $1, $1, $2
sub $4, $1, $3
or  $6, $1, $7
and $8, $1, $9
xor $10, $1, $11

sw $10, 0xf0f0($0)


HALT