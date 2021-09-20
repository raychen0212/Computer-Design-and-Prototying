org 0x0000
ori $1, $0, 2
ori $2, $0, 3
ori $3, $0, 5
j calculate

calculate:
    sw $1, 0xf0f0($0)
    add $1, $1, $2
    jal addfunction
    sw $1, 0xf0f8($0)
    add $1, $1, $1
    j done

addfunction:
    sw $1, 0xf0f4($0)
    add $1, $1, $3
    jr $31
done:
    sw $1, 0xf0fc($0)
    halt
