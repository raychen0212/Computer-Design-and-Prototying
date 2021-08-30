
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
	import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif();
  // test program
  test PROG (aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.PortA (aluif.PortA),
		.\aluif.PortB (aluif.PortB),
		.\aluif.OutputPort (aluif.OutputPort),
		.\aluif.ALUOP (aluif.ALUOP),
		.\aluif.NegFlag (aluif.NegFlag),
		.\aluif.Overflow (aluif.Overflow),
		.\aluif.ZeroFlag (aluif.ZeroFlag)
  );
`endif

endmodule

program test(
	alu_if.tb tbif
);

parameter PERIOD = 10;
initial begin
//SLL
	tbif.ALUOP = ALU_SLL;
	tbif.PortA = 32'h10000001;
	tbif.PortB = 32'd2;
	#(PERIOD)
//SRL
	tbif.ALUOP = ALU_SRL;
	#(PERIOD)
//ADD
	tbif.ALUOP = ALU_ADD;
	tbif.PortA = 32'h1;
	tbif.PortB = 32'h2;
	#(PERIOD)
//ADD overflow
	tbif.PortA = 32'h70000000;
	tbif.PortB = 32'h70000000;
	#(PERIOD)
//ADD ZERO
	tbif.PortA = 32'h0;
	tbif.PortB = 32'h0;
	#(PERIOD)
//SUB
	tbif.ALUOP = ALU_SUB;
	tbif.PortA = 32'hffffffff;
	tbif.PortB = 32'hfffffff0;
	#(PERIOD)
//SUB zero
	tbif.PortA = 32'hffffffff;
	tbif.PortB = 32'hffffffff;
	#(PERIOD)
//SUB overflow
	tbif.PortA = 32'h70000000;
	tbif.PortB = 32'hf0000000;
	#(PERIOD)
//AND
	tbif.ALUOP = ALU_AND;
	tbif.PortA = 32'h11111111;
	tbif.PortB = 32'h33333333;
	#(PERIOD)
//OR
	tbif.ALUOP = ALU_OR;
	tbif.PortA = 32'h11111111;
	tbif.PortB = 32'h22222222;
	#(PERIOD)
//XOR
	tbif.ALUOP = ALU_XOR;
	tbif.PortA = 32'h11111111;
	tbif.PortB = 32'h22222222;
	#(PERIOD)
//NOR
	tbif.ALUOP = ALU_NOR;
	tbif.PortA = 32'h11111111;
	tbif.PortB = 32'h22222222;
	#(PERIOD)
//SLT
	tbif.ALUOP = ALU_SLT;
	tbif.PortA = 32'h7;
	tbif.PortB = 32'h8;
	#(PERIOD)	
//SLT NEG
	tbif.ALUOP = ALU_SLT;
	tbif.PortA = 32'h80000008;
	tbif.PortB = 32'h7;
	#(PERIOD)	
//SLTU
	tbif.ALUOP = ALU_SLTU;
	tbif.PortA = 32'h00000009;
	tbif.PortB = 32'h80000009;
	#(PERIOD)	
$finish;
end
endprogram







