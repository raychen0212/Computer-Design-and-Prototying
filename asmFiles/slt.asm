main:
	org   0x0000
	ori $1, $0, 0xFFFFFFFF
	ori $2, $0, -4
	ori $3, $0, 4
	ori $4, $0, -5
	ori $5, $0, 3
	ori $sp, $0, slt_data
	
	slt $6, $2, $3
	slt $7, $3, $2
	slt $8, $2, $4
	slt $9, $4, $2
	slt $10, $3, $5
	slt $11, $5, $3

	sw $6, 0($sp)
	sw $7, 4($sp)
	sw $8, 8($sp)
	sw $9, 12($sp)
	sw $10, 16($sp)
	sw $11, 20($sp)
	sw $1, 24($sp)

	ori $sp, $0, sltU_data
	sltu $6, $2, $3
	sltu $7, $3, $2
	sltu $8, $2, $4
	sltu $9, $4, $2
	sltu $10, $3, $5
	sltu $11, $5, $3

	sw $6, 0($sp)
	sw $7, 4($sp)
	sw $8, 8($sp)
	sw $9, 12($sp)
	sw $10, 16($sp)
	sw $11, 20($sp)
	sw $1, 24($sp)
	
	ori $sp, $0, slti_data
	slti $6, $2, 4
	slti $7, $3, -4
	slti $8, $2, -5
	slti $9, $4, -4
	slti $10, $3, 5
	slti $11, $5, 4

	sw $6, 0($sp)
	sw $7, 4($sp)
	sw $8, 8($sp)
	sw $9, 12($sp)
	sw $10, 16($sp)
	sw $11, 20($sp)
	sw $1, 24($sp)

	ori $sp, $0, sltiu_data
	sltiu $6, $2, 4
	sltiu $7, $3, -4
	sltiu $8, $2, -5
	sltiu $9, $4, -4
	sltiu $10, $3, 5
	sltiu $11, $5, 4

	sw $6, 0($sp)
	sw $7, 4($sp)
	sw $8, 8($sp)
	sw $9, 12($sp)
	sw $10, 16($sp)
	sw $11, 20($sp)
	sw $1, 24($sp)

	halt
slt_data:
	org   0x0800

sltU_data:
	org   0x0900
slti_data:
	org   0x0A00
sltiu_data:
	org   0x0B00
