/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test
(
	input logic CLK, 
	output logic nRST,
	register_file_if.tb tbif
);
parameter PERIOD = 10;
initial begin
	nRST = 0;
	#(PERIOD)
//WRITE TO REG 0
	nRST = 1;
	tbif.wdat = 32'b10101010;
	tbif.WEN = 1;
	tbif.wsel = 0;
	tbif.rsel1 = 0;
	tbif.rsel2 = 0;
	@(posedge CLK);
	#(PERIOD)
//Write to reg1 and read for 1
	tbif.wsel = 1;
	@(posedge CLK);
	tbif.rsel1 = 1;
	tbif.rsel2 = 0;
	@(posedge CLK);
	#(PERIOD)
//Write to reg30 and read for 2
	tbif.wsel = 30;
	tbif.rsel1 = 0;
	tbif.rsel2 = 1;
	@(posedge CLK);
	#(PERIOD)
//Reset
	nRST = 0;
	@(posedge CLK);
	#(PERIOD)
//WEN test
	nRST = 1;
	tbif.wdat = 32'b01010101;
	tbif.WEN = 0;
	tbif.wsel = 3;
	tbif.rsel1 = 3;
	tbif.rsel2 = 3;
	@(posedge CLK);
	#(PERIOD)
	tbif.WEN = 1;
	tbif.wsel = 4;
	tbif.rsel1 = 4;
	tbif.rsel2 = 4;
	@(posedge CLK);
	#(PERIOD)
$finish;
end
endprogram
