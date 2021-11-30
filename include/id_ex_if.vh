`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

`include "cpu_types_pkg.vh"

interface id_ex_if;
	import cpu_types_pkg::*;

	word_t rdat1_i, rdat2_i, imm_i,  pc4_i, jaddr_i, instr_i, pc_i, next_pc_i,lui_imm_i, wdat_i,
		   rdat1_o, rdat2_o, imm_o,  pc4_o, jaddr_o, instr_o, pc_o, next_pc_o, lui_imm_o, wdat_o;

	regbits_t rt_i, rd_i, rs_i,
			  rd_o, rt_o, rs_o;

	logic RegWr_i, halt_i, ALUsrc_i, dREN_i, dWEN_i, stopread_i,datomic_i,
		  RegWr_o, halt_o, ALUsrc_o, dREN_o, dWEN_o ,stopread_o,datomic_o ;

	logic [2:0] RegDst_i,  MemToReg_i, PCsrc_i, ExtOp_i, 
				RegDst_o,  MemToReg_o, PCsrc_o, ExtOp_o;

	aluop_t ALUOp_i, ALUOp_o;

	funct_t funct_i, 
		   funct_o;

	opcode_t opcode_i,
			 opcode_o;

	logic flush, en;

	modport idex(
	input rdat1_i, rdat2_i, imm_i,  pc4_i, jaddr_i, rt_i, rd_i, RegWr_i, halt_i, ALUsrc_i, dREN_i, dWEN_i, RegDst_i,  MemToReg_i, PCsrc_i, 
	ExtOp_i, ALUOp_i, flush, en,stopread_i,instr_i, pc_i, next_pc_i,lui_imm_i,rs_i,funct_i,opcode_i,wdat_i,datomic_i,
	output rdat1_o, rdat2_o, imm_o,  pc4_o, jaddr_o,rd_o, rt_o,RegWr_o, halt_o, ALUsrc_o, dREN_o, dWEN_o, RegDst_o,  MemToReg_o, PCsrc_o ,
	ExtOp_o,ALUOp_o,stopread_o, instr_o, pc_o, next_pc_o, lui_imm_o,rs_o,funct_o,opcode_o,wdat_o,datomic_o
	);

endinterface
`endif
