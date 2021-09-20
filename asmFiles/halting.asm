org 0x0000
ori $1, $0, 5
ori $2, $0, 6
add $1, $1, $2
halt
sw $1, 0xf0f0($0)
add $1, $1, $2
