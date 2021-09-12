ori $1, $0, 1
ori $2, $0, 2
jal adding
j finish

ori $3, $0, 1

finish:
	sub $2, $2, $1
	sw $2 0x4($0)
	halt

adding:
	add $2, $2, $1
	sw $2 0x8($0)
	jr $31
