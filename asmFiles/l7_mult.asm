org 0x0000
ori $29, $0, 0xFFFC

ori $1, $0, 3 #1st oprand
ori $2, $0, 4 #2nd operand
push $1 			#push into stack
push $2 			#push into stack

mult:
	ori $3, $0, 0 #results in $3
	ori $4, $0, 1 #for substraction
	pop $2				#$2 = counter
  pop $1				#$1 = adder
loop:
	beq $2, $0, finish 
	add $3, $3, $1
	sub $2, $2, $4
	j loop
finish:
	push $3 		#push result into stack
	pop $1			#pop result into $1
	halt				#end
