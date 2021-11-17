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
datapath_cache_if dcif0();
caches_if cif0();
datapath_cache_if dcif1();
caches_if cif1();
cpu_ram_if crif();

test PROG (CLK, nRST, dcif0, cif0, dcif1, cif1);
dcache DUT0(CLK, nRST, dcif0, cif0);
dcache DUT1(CLK, nRST, dcif1, cif1);
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

program test(input logic CLK, output logic nRST, datapath_cache_if dcif0, caches_if cif0, datapath_cache_if dcif1, caches_if cif1);
initial begin
  
 
end
endprogram
