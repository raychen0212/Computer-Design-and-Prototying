`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;

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
  icache DUT(CLK, nRST, dpif, cif);
`endif

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if dpif, caches_if cif);

parameter PERIOD = 10;
integer test_num;
//String test_case;
// 26 bit for tag, 4 bits 
initial begin
  
  nRST = 0;
  @(posedge CLK);
  nRST = 1;
  @(posedge CLK);

  test_num = 0;
  //"Not valid read";
  dpif.imemREN = 1;
  dpif.imemaddr = {26'h0, 4'b0000, 2'b10};
  cif.iwait = 0;
  cif.iload = 32'h12341234;
  
  @(posedge CLK);
  if(dpif.ihit == 1)begin
    $display("ihit not correctly assert in test case %d", test_num);
  end
  else if (dpif.imemload != cif.iload)begin
    $display("imemload incorrect output in test case %d", test_num);
  end
  else if (cif.iREN != 1)begin
    $display("iREN not correctly assert in test case %d", test_num);
  end
  else if(cif.iaddr != dpif.imemaddr) begin
    $display ("iaddr is not correct %d", test_num);
  end
  else begin
    $display ("Test case %d Pass", test_num);
  end
  
  //"load new instruction 1";
  @(posedge CLK);
  test_num = 1;
  dpif.imemREN = 1;
  dpif.imemaddr = {26'h0b1516c, 4'b0011, 2'b10};
  cif.iwait = 0;
  cif.iload = 32'h12341234;
  

  @(posedge CLK);
  if(dpif.ihit != 1)begin
    $display("ihit not correctly assert in test case %d", test_num);
  end
  else if (dpif.imemload != cif.iload)begin
    $display("imemload incorrect output in test case %d", test_num);
  end
  else if (cif.iREN != 1)begin
    $display("iREN not correctly assert in test case %d", test_num);
  end
  else if(cif.iaddr != dpif.imemaddr) begin
    $display ("iaddr is not correct %d", test_num);
  end
  else begin
    $display ("Test case %d Pass", test_num);
  end

  //testcase 2
  //"load new instruction 2";
  @(posedge CLK);
  test_num = 2;
  dpif.imemREN = 1;
  dpif.imemaddr = {26'hFEDFADBB, 4'b0000, 2'b10};
  cif.iwait = 0;
  cif.iload = 32'h43214321;
  
  @(posedge CLK);
  if(dpif.ihit != 1)begin
    $display("ihit not correctly assert in test case %d", test_num);
  end
  else if (dpif.imemload != cif.iload)begin
    $display("imemload incorrect output in test case %d", test_num);
  end
  else if (cif.iREN != 1)begin
    $display("iREN not correctly assert in test case %d", test_num);
  end
  else if(cif.iaddr != dpif.imemaddr) begin
    $display ("iaddr is not correct %d", test_num);
  end
  else begin
    $display ("Test case %d Pass", test_num);
  end

  @(posedge CLK);
  //"need to hit instruction 2";
  test_num = 3;
  dpif.imemREN = 1;
  dpif.imemaddr = {26'hFEDFADBB, 4'b0000, 2'b10};
  cif.iwait = 0;
  cif.iload = 32'h43214321;
  
  @(posedge CLK);
  if(dpif.ihit != 1)begin
    $display("ihit not correctly assert in test case %d", test_num);
  end
  else if (dpif.imemload != cif.iload)begin
    $display("imemload incorrect output in test case %d", test_num);
  end
  else if (cif.iREN != 1)begin
    $display("iREN not correctly assert in test case %d", test_num);
  end
  else if(cif.iaddr != dpif.imemaddr) begin
    $display ("iaddr is not correct %d", test_num);
  end
  else begin
    $display ("Test case %d Pass", test_num);
  end
  //"need to hit instruction 1";
  test_num = 4;
  dpif.imemREN = 1;
  dpif.imemaddr = {26'h0b1516c, 4'b0011, 2'b10};
  cif.iwait = 0;
  cif.iload = 32'h12341234;
  
  @(posedge CLK);
  if(dpif.ihit != 1)begin
    $display("ihit not correctly assert in test case %d", test_num);
  end
  else if (dpif.imemload != cif.iload)begin
    $display("imemload incorrect output in test case %d", test_num);
  end
  else if (cif.iREN != 1)begin
    $display("iREN not correctly assert in test case %d", test_num);
  end
  else if(cif.iaddr != dpif.imemaddr) begin
    $display ("iaddr is not correct %d", test_num);
  end
  else begin
    $display ("Test case %d Pass", test_num);
  end

  @(posedge CLK);
//"load a new instruction 3";
  test_num = 5;
  dpif.imemREN = 1;
  dpif.imemaddr = {26'hFEEDBEEF, 4'b0101, 2'b10};
  cif.iwait = 0;
  cif.iload = 32'h54321012;
  
  
  @(posedge CLK);
  if(dpif.ihit != 1)begin
    $display("ihit not correctly assert in test case %d", test_num);
  end
  else if (dpif.imemload != cif.iload)begin
    $display("imemload incorrect output in test case %d", test_num);
  end
  else if (cif.iREN != 1)begin
    $display("iREN not correctly assert in test case %d", test_num);
  end
  else if(cif.iaddr != dpif.imemaddr) begin
    $display ("iaddr is not correct %d", test_num);
  end
  else begin
    $display ("Test case %d Pass", test_num);
  end
$finish;
end
endprogram







