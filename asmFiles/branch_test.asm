ori $1, $0, 0 				#reg1 = 0
ori $2, $0, 1					#reg2 = 1

test:
	beq $1, $2, taken   #not taken
	beq $1, $0, taken		#taken
	halt
taken:
	add $1, $1, $2      #reg1 = 1
	bne $1, $2, taken   #not taken
	bne $1, $0, end			#taken
  j test
end:
	halt
