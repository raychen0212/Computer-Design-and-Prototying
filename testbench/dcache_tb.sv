`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dpif();
  caches_if cif();
  // test program
  test PROG (CLK, nRST, dpif, cif);
  // DUT
`ifndef MAPPED
  dcache DUT(CLK, nRST, dpif, cif);
`endif

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if dpif, caches_if cif);

parameter PERIOD = 10;
integer test_num;
initial begin
  
  nRST = 0;
  @(posedge CLK);
  nRST = 1;
  dpif.halt = 0;
  @(posedge CLK);

  test_num = 0;
  //"read miss ";
  dpif.dmemREN = 1;
  dpif.dmemWEN = 0;
  dpif.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  cif.dwait = 0;
  cif.dload = 32'h12341234;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
	#(PERIOD)

  
  //"read miss, load in same frame different block";
  @(posedge CLK);
  test_num = 1;
  dpif.dmemREN = 1;
  dpif.dmemWEN = 0;
  dpif.dmemaddr = {26'hbbbbbb, 3'b01, 3'b000};
  cif.dwait = 0;
  cif.dload = 32'h12341234;
  

  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
	#(PERIOD)


  //testcase 2
  //"read hit";
  @(posedge CLK);
  test_num = 2;
  dpif.dmemREN = 1;
  dpif.dmemWEN = 0;
  dpif.dmemaddr = {26'hbbbbbb, 3'b01, 3'b000};
  cif.dwait = 0;
  cif.dload = 32'h43214321;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
	#(PERIOD)


  @(posedge CLK);
  //"write miss";
  test_num = 3;
  dpif.dmemREN = 0;
  dpif.dmemWEN = 1;
  dpif.dmemaddr = {26'hcccccc, 3'b11, 3'b000};
  dpif.dmemstore = 32'h11111111;
  cif.dwait = 0;
  cif.dload = 32'h43214321;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
  #(PERIOD)

 //"write miss, same index different tag";
  test_num = 4;
  dpif.dmemREN = 0;
  dpif.dmemWEN = 1;
  dpif.dmemaddr = {26'hddddddd, 3'b11, 3'b000};
  dpif.dmemstore = 32'h22222222;
  cif.dwait = 0;
  cif.dload = 32'h43214321;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
  #(PERIOD)

  @(posedge CLK);
 //"write hit";
  test_num = 5;
  dpif.dmemREN = 0;
  dpif.dmemWEN = 1;
  dpif.dmemaddr = {26'hddddddd, 3'b11, 3'b000};
  dpif.dmemstore = 32'h33333333;
  cif.dwait = 0;
  cif.dload = 32'h55555555;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
	#(PERIOD)

    @(posedge CLK);
 //"write hit 2";
  test_num = 6;
  dpif.dmemREN = 0;
  dpif.dmemWEN = 1;
  dpif.dmemaddr = {26'hccccccc, 3'b11, 3'b000};
  dpif.dmemstore = 32'h33333333;
  cif.dwait = 0;
  cif.dload = 32'h66666666;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
	#(PERIOD)

    @(posedge CLK);
 //"read miss write back";
  test_num = 7;
  dpif.dmemREN = 1;
  dpif.dmemWEN = 0;
  dpif.dmemaddr = {26'heeeeeee, 3'b11, 3'b000};
  dpif.dmemstore = 32'h33333333;
  cif.dwait = 0;
  cif.dload = 32'h43214321;
  
  @(posedge CLK);
  @(posedge CLK);
  #(PERIOD)
	#(PERIOD)

      @(posedge CLK);
 //"flush";
  dpif.halt = 1;
  test_num = 8;
  dpif.dmemREN = 0;
  dpif.dmemWEN = 0;
  dpif.dmemaddr = {26'heeeeeee, 3'b11, 3'b000};
  dpif.dmemstore = 32'h33333333;
  cif.dwait = 0;
  cif.dload = 32'h43214321;
  
  @(posedge CLK);
  #(PERIOD*20)



$finish;
end
endprogram
