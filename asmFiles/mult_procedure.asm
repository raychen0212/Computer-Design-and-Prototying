org 0x0000
ori $29, $0, 0xFFFC
ori $28, $0, 0xFFF8


	ori $1, $0, 3 #1st oprand
	ori $2, $0, 4 #2nd operand
	ori $3, $0, 5 #3rd oprand
	ori $4, $0, 6 #4th operand

	push $1 			#push into stack
	push $2 			#push into stack
	push $3 			#push into stack
	push $4 			#push into stack
main:
	beq $29, $28, all_finish
	jal mult
	j main 
mult:
	ori $5, $0, 0 #results in $5
	ori $6, $0, 1 #for substraction
	pop $2				#$2 = counter
  pop $1				#$1 = adder
loop:
	beq $2, $0, mul_finish 
	add $5, $5, $1
	sub $2, $2, $6
	j loop
mul_finish:
	push $5
	jr $31
all_finish:
	pop $1			#pop result into $1
	halt				#end
