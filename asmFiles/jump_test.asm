ori $1, $0, 1
ori $2, $0, 2
jal adding
j finish

ori $3, $0, 1

finish:
	sub $2, $2, $1
	halt

adding:
	add $2, $2, $1
	jr $31
