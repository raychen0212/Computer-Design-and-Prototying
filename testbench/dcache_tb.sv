`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
`include "system_if.vh"
import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  
  // DUT
datapath_cache_if dpif0();
caches_if cif0();
datapath_cache_if dpif1();
caches_if cif1();
cpu_ram_if crif();

test PROG (CLK, nRST, dpif0, cif0, dpif1, cif1);
dcache DUT0(CLK, nRST, dpif0, cif0);
dcache DUT1(CLK, nRST, dpif1, cif1);
cache_control_if #(.CPUS(2)) ccif(cif0, cif1);
ram DUTRAM(CLK, nRST, crif);
memory_control MC(CLK, nRST, ccif);

assign crif.ramWEN = ccif.ramWEN;
assign crif.ramREN = ccif.ramREN;
assign crif.ramstore = ccif.ramstore;
assign crif.ramaddr = ccif.ramaddr;
assign ccif.ramload = crif.ramload;
assign ccif.ramstate = crif.ramstate;
assign crif.memaddr = ccif.ramaddr;
assign crif.memstore = ccif.ramstore;
assign crif.memREN = ccif.ramREN;
assign crif.memWEN = ccif.ramWEN;

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if.dcache dpif0, caches_if.dcache cif0, datapath_cache_if.dcache dpif1, caches_if.dcache cif1);
parameter PERIOD = 10;
initial begin
  nRST = 0;
  @(posedge CLK);
  nRST = 1;
  dpif0.halt = 0;
  dpif1.halt = 0;
  @(posedge CLK);

  
  //"Cache 0 I->S Cache 1 I->S ";
  dpif0.dmemREN = 1;
  dpif0.dmemWEN = 0;
  dpif1.dmemREN = 1;
  dpif1.dmemWEN = 0;
  dpif0.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  dpif1.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  // cif0.dwait = 0;
  // cif0.dload = 32'h12341234;
  // cif0.ccwait = 0;
  // cif0.ccinv = cif1.ccwrite;
  // cif1.ccsnoopaddr = cif0.daddr;
  // @(posedge CLK)
  // @(posedge CLK)
  // cif1.dwait = 0;
  // cif1.dload = 32'h12341234;
  // cif1.ccwait = 0;
  // cif1.ccinv = cif0.ccwrite;
  // cif0.ccsnoopaddr = cif1.daddr;

  @(posedge CLK);
  @(posedge CLK);

  //"Cache 0 S->M Cache 1 S->I"  
  dpif0.dmemREN = 0;
  dpif0.dmemWEN = 1;
  dpif1.dmemREN = 0;
  dpif1.dmemWEN = 0;
  dpif0.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  dpif1.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  dpif0.dmemstore = 32'hDEADBEEF;
  dpif1.dmemstore = 32'hDEADBEEF;
  // cif0.dwait = 0;
  // cif0.dload = 32'h12341234;
  // cif0.ccwait = 0;
  // cif0.ccinv = cif1.ccwrite;
  // cif1.ccsnoopaddr = cif0.daddr;
  
  // @(posedge CLK)
  // @(posedge CLK)
  // cif1.dwait = 0;
  // cif1.dload = '0;
  // cif1.ccwait = 1;
  // cif1.ccinv = cif0.ccwrite;
  // cif0.ccsnoopaddr = cif1.daddr;

  //"Cache 0 M->S Cache 1 I->S" 
  @(posedge CLK)
  @(posedge CLK)

  dpif0.dmemREN = 0;
  dpif0.dmemWEN = 0;
  dpif1.dmemREN = 1;
  dpif1.dmemWEN = 0;
  dpif0.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  dpif1.dmemaddr = {26'haaaaaa, 3'b01, 3'b000};
  dpif0.dmemstore = '0;
  dpif1.dmemstore = '0;
  @(posedge CLK)
  @(posedge CLK)
  // cif1.dwait = 0;
  // cif1.dload = cif0.dstore;
  // cif1.ccwait = 0;
  // cif1.ccinv = cif0.ccwrite;
  // cif0.ccsnoopaddr = cif1.daddr;
  
  // @(posedge CLK)
  // @(posedge CLK)
  // cif0.dwait = 0;
  // cif0.dload = '0;
  // cif0.ccwait = 0;
  // cif0.ccinv = cif1.ccwrite;
  // cif1.ccsnoopaddr = cif0.daddr;

$finish;
 
end
endprogram
