`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

`include "cpu_types_pkg.vh"

interface mem_wb_if;
	import cpu_types_pkg::*;

	word_t imm_i,  pc4_i,  OutputPort_i, dmemload_i,
		   imm_o,  pc4_o,  OutputPort_o, dmemload_o;

	regbits_t wsel_i, 
			  wsel_o ;

	logic RegWr_i, halt_i,  stopread_i,
		  RegWr_o, halt_o, stopread_o;

	logic [1:0]  MemToReg_i,  
				 MemToReg_o;

	logic flush, en;

	modport memwb(
	input imm_i,  pc4_i,  OutputPort_i, dmemload_i,wsel_i,RegWr_i, halt_i,MemToReg_i, flush, en,stopread_i,
	output imm_o,  pc4_o,  OutputPort_o, dmemload_o,wsel_o, RegWr_o, halt_o, MemToReg_o, stopread_o
	);

endinterface
`endif
