ori $1, $0, 0 				#reg1 = 0
ori $2, $0, 5					#reg2 = 5
ori $3, $0, 5					#reg3 = 5
ori $4, $0, 6
test:
	beq $1, $2, taken   #not taken
	sw $2, 0x4($0)
	beq $1, $0, taken		#taken
	halt
taken:

	bne $3, $2, taken   #not taken
	sw  $4, 0x8($0)
	bne $1, $2, end			#taken
  j test
end:
	halt
