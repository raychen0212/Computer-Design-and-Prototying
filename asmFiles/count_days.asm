ori $1, $0, 22 			#current day
ori $2, $0, 8  			#current month
ori $3, $0, 2021  	#current year
ori $4, $0, 30 			#days per month
ori $5, $0, 365 		#days per year
ori $6, $0, 2000		#year of 2000
ori $7, $0, 1				#for substraction
ori $10, $0, 0			#total days

count_days:
	add $10, $10, $1	#days +current days
	sub $2, $2, $7		#current month - 1
	push $4
	push $2
	jal mult
	add $10, $10, $7  #days + 30 * (current month - 1)
	sub $3, $3, $6   	#current year - 2000
	push $5
	push $3
	jal mult
	add $10, $10, $7	#days + 365 * (current year - 2000)
	halt

mult:
	ori $7, $0, 0 		#results in $7
	ori $8, $0, 1 		#for substraction
	pop $2						#$2 = counter
  pop $1						#$1 = adder
loop:
	beq $2, $0, mul_finish 
	add $7, $7, $1
	sub $2, $2, $8
	j loop
mul_finish:
	push $7
	jr $31

