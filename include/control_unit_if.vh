`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface control_unit_if;
	import cpu_types_pkg::*;

//Intructions
	word_t instr;
	opcode_t opcode;
	regbits_t rs, rt, rd;
	funct_t funct;
	word_t shamt;
	
	logic [15:0] imm;
	logic [25:0] addr;

//Controls
	logic RegWr, halt, ALUsrc, iREN, dREN, dWEN, branch, jump, stopread, datomic;
	logic [2:0] RegDst, PCsrc, ExtOp, MemToReg;
	aluop_t ALUOp;
	
	modport tb(
	input opcode, rs, rt, rd, funct, shamt, imm, addr, RegWr, halt, ALUsrc, iREN, dREN, dWEN, RegDst, PCsrc, ExtOp, MemToReg, ALUOp, stopread, datomic,
	output instr, branch, jump
	);

	modport cu(
	input instr, branch, jump,
	output  opcode, rs, rt, rd, funct, shamt, imm, addr, RegWr, halt, ALUsrc, iREN, dREN, dWEN, RegDst, PCsrc, ExtOp, MemToReg, ALUOp, stopread, datomic
	);
endinterface
`endif

