`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

`include "cpu_types_pkg.vh"

interface if_id_if;
	import cpu_types_pkg::*;

	word_t instr_i, instr_o, pc4_i, pc4_o, pc_i, pc_o, next_pc_i, next_pc_o;
	logic flush, en;

	modport ifid(
	input instr_i, pc4_i, pc_i,next_pc_i,flush, en,
	output instr_o, pc4_o,pc_o,next_pc_o
	);

endinterface
`endif
