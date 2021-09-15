`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;
	import cpu_types_pkg::*;
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;
  
  // interface
  request_unit_if ruif();

  // test program
  test PROG (CLK, nRST, ruif);

  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.dREN (ruif.dREN),
    .\ruif.dWEN (ruif.dWEN),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.dmemWEN (ruif.dmemWEN),
  );
`endif

endmodule

program test (
  input logic CLK, 
  output logic nRST, 
  request_unit_if.tb ruif
);
  parameter PERIOD = 10;
  initial begin
    nRST = 0;
    #(PERIOD)
    nRST = 1;
    #(PERIOD)

    for (int i = 0; i < 64; i++) begin
      ruif.ihit = i[3];
      ruif.dhit = i[2];
      ruif.dREN = i[1];
      ruif.dWEN = i[0];
      #(PERIOD);
    end
  end


endprogram
