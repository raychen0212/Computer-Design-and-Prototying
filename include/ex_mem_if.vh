`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

`include "cpu_types_pkg.vh"

interface ex_mem_if;
	import cpu_types_pkg::*;

	word_t rdat2_i, imm_i,  pc4_i, jaddr_i, branchaddr_i, OutputPort_i,instr_i, pc_i, next_pc_i,lui_imm_i,wdat_i,
		   rdat2_o, imm_o,  pc4_o, jaddr_o, branchaddr_o, OutputPort_o,instr_o, pc_o, next_pc_o, lui_imm_o, wdat_o;

	regbits_t wsel_i, rt_i,rs_i,
			  wsel_o ,rt_o, rs_o;

	logic RegWr_i, halt_i, dREN_i, dWEN_i, ZeroFlag_i,stopread_i, 
		  RegWr_o, halt_o, dREN_o, dWEN_o, ZeroFlag_o,stopread_o;

	logic [1:0]  MemToReg_i, PCsrc_i, 
				 MemToReg_o, PCsrc_o;

	logic flush, en;

	funct_t funct_i, 
		   funct_o;

	opcode_t opcode_i,
			 opcode_o;
	
	modport exmem(
	input rdat2_i, imm_i,  pc4_i, jaddr_i, branchaddr_i, OutputPort_i,wsel_i,RegWr_i, halt_i, dREN_i, dWEN_i,
	 ZeroFlag_i, MemToReg_i, PCsrc_i, flush, en,stopread_i,instr_i, pc_i, next_pc_i,lui_imm_i,rt_i,rs_i,funct_i,opcode_i,wdat_i,
	output rdat2_o, imm_o,  pc4_o, jaddr_o, branchaddr_o, OutputPort_o, wsel_o, RegWr_o, halt_o, dREN_o, dWEN_o,
	 ZeroFlag_o, MemToReg_o, PCsrc_o,stopread_o,instr_o, pc_o, next_pc_o, lui_imm_o,rt_o, rs_o, funct_o,opcode_o, wdat_o
	);

endinterface
`endif
