org 0x0000
ori $1, $0, 5
ori $2, $0, 8
ori $3, $0, 5
ori $29, $0, 0xfffc

non_taken:
    beq $1, $2, taken
    sw $1, 0xf0f0($0)
    beq $1, $3, taken
taken:
    sw $2, 0xf0f4($0)
    bne $1, $2, failed
    
done:
    sw $1, 0xf0fc($0)
    halt
failed:
    sw $3, 0xf0f8($0)
    bne $1, $3, failed
    j done
