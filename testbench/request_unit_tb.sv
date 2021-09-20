// mapped needs this
`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if request ();
  // test program
  test PROG (CLK, nRST, request);
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST,request);

`endif

endmodule

program test(input logic CLK, output logic nRST, request_unit_if.tb testing);
initial begin
    nRST = 0;
    @(negedge CLK);
    nRST = 1;
    testing.ihit = 0;
    testing.dhit = 1;
    testing.memWr = 0;
    testing.memRead = 1;
    @(negedge CLK);
    if(testing.imemREN == 1 && testing.dmemWEN == 0 && testing.dmemREN == 0)begin
        $display("ihit deasserted correct");
    end
    else begin
        $display("ihit failed");
    end
    
    nRST = 0;
    @(negedge CLK);
    nRST = 1;
    testing.ihit = 1;
    testing.dhit = 1;
    testing.memWr = 1;
    testing.memRead = 1;
    @(negedge CLK);
    if(testing.imemREN == 1 && testing.dmemWEN == 0 && testing.dmemREN == 0)begin
        $display("ihit, dhit asserted correct");
    end
    else begin
        $display("ihit failed");
    end


    nRST = 0;
    @(negedge CLK);
    nRST = 1;
    testing.ihit = 1;
    testing.dhit = 0;
    testing.memWr = 1;
    testing.memRead = 1;
    @(negedge CLK);
    if(testing.imemREN == 1 && testing.dmemWEN == 1 && testing.dmemREN == 1)begin
        $display("ihit asserted correct");
    end
    else begin
        $display("ihit failed");
    end
    end
endprogram
