`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

`include "cpu_types_pkg.vh"

interface id_ex_if;
	import cpu_types_pkg::*;

	word_t rdat1_i, rdat2_i, imm_i,  pc4_i, jaddr_i,
		   rdat1_o, rdat2_o, imm_o,  pc4_o, jaddr_o;

	regbits_t rt_i, rd_i, 
			  rd_o, rt_o;

	logic RegWr_i, halt_i, ALUsrc_i, dREN_i, dWEN_i, stopread_i,
		  RegWr_o, halt_o, ALUsrc_o, dREN_o, dWEN_o ,stopread_o;

	logic [1:0] RegDst_i,  MemToReg_i, PCsrc_i, ExtOp_i, 
				RegDst_o,  MemToReg_o, PCsrc_o, ExtOp_o;

	aluop_t ALUOp_i, ALUOp_o;

	logic flush, en;

	modport idex(
	input rdat1_i, rdat2_i, imm_i,  pc4_i, jaddr_i, rt_i, rd_i, RegWr_i, halt_i, ALUsrc_i, dREN_i, dWEN_i, RegDst_i,  MemToReg_i, PCsrc_i, ExtOp_i, ALUOp_i, flush, en,stopread_i,
	output rdat1_o, rdat2_o, imm_o,  pc4_o, jaddr_o,rd_o, rt_o,RegWr_o, halt_o, ALUsrc_o, dREN_o, dWEN_o, RegDst_o,  MemToReg_o, PCsrc_o ,ExtOp_o,ALUOp_o,stopread_o
	);

endinterface
`endif
