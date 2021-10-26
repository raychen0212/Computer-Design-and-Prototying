`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

`include "cpu_types_pkg.vh"

interface mem_wb_if;
	import cpu_types_pkg::*;

	word_t imm_i,  pc4_i,  OutputPort_i, dmemload_i,branchaddr_i,instr_i, pc_i, next_pc_i,lui_imm_i,rdat2_i,wdat_i,
		   imm_o,  pc4_o,  OutputPort_o, dmemload_o, branchaddr_o,instr_o, pc_o, next_pc_o, lui_imm_o, rdat2_o,wdat_o;

	regbits_t wsel_i, rt_i,rs_i,rd_i,
			  wsel_o ,rt_o, rs_o, rd_o;

	logic RegWr_i, halt_i,  stopread_i,dREN_i,
		  RegWr_o, halt_o, stopread_o, dREN_o;

	logic [1:0]  MemToReg_i,  
				 MemToReg_o;

	logic flush, en;

	funct_t funct_i, 
		   funct_o;

	opcode_t opcode_i,
			 opcode_o;

	modport memwb(
	input imm_i,  pc4_i,  OutputPort_i, dmemload_i,wsel_i,RegWr_i, halt_i,MemToReg_i, flush, en,stopread_i,
	branchaddr_i,instr_i, pc_i, next_pc_i,lui_imm_i,rdat2_i,rt_i,rs_i,funct_i,opcode_i,wdat_i,rd_i,dREN_i,
	output imm_o,  pc4_o,  OutputPort_o, dmemload_o,wsel_o, RegWr_o, halt_o, MemToReg_o, stopread_o,
	branchaddr_o,instr_o, pc_o, next_pc_o, lui_imm_o, rdat2_o,rt_o, rs_o,funct_o,opcode_o,wdat_o,rd_o, dREN_o
	);

endinterface
`endif
