`ifndef ALU_IF_VH
`define ALU_IF_VH

`include "cpu_types_pkg.vh"

interface ALU_if;
	import cpu_types_pkg::*;

  logic     NegFlag, Overflow, ZeroFlag;
  word_t PortA, PortB, OutputPort;
  regbits_t    ALUOP;

	modport alu(
		input PortA, PortB, ALUOP,
		output  NegFlag, Overflow, ZeroFlag, OutputPort
	);

	modport tb(
		input PortA, PortB, ALUOP,
		output  NegFlag, Overflow, ZeroFlag, OutputPort
	);

endinterface
endif
