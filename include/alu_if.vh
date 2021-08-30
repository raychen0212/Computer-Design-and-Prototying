`ifndef ALU_IF_VH
`define ALU_IF_VH

`include "cpu_types_pkg.vh"

interface alu_if;
	import cpu_types_pkg::*;

  logic     NegFlag, Overflow, ZeroFlag;
  word_t PortA, PortB, OutputPort;
  aluop_t    ALUOP;

	modport alu(
		input PortA, PortB, ALUOP,
		output  NegFlag, Overflow, ZeroFlag, OutputPort
	);

	modport tb(
		input PortA, PortB, ALUOP,
		output  NegFlag, Overflow, ZeroFlag, OutputPort
	);

endinterface
`endif
