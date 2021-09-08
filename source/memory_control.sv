/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;

  //TO RAM
  assign ccif.ramstore = ccif.dstore;
  assign ccif.ramWEN = ccif.dWEN;
  assign ccif.ramREN = ((ccif.dREN || ccif.iREN) && (!ccif.dWEN)) ? 1 : 0;
  assign ccif.ramaddr = (ccif.dWEN || ccif.dREN) ? ccif.daddr : ccif.iaddr;

  //TO CACHE
  assign ccif.dwait = ((ccif.ramstate == ACCESS) && (ccif.dREN || ccif.dWEN)) ? 0 : 1; 
  assign ccif.dload = ccif.ramload;
  assign ccif.iwait = ((ccif.ramstate == ACCESS) && (!(ccif.dREN || ccif.dWEN)) && ccif.iREN) ? 0 : 1;
  assign ccif.iload = (ccif.iREN) ? ccif.ramload : 0;

endmodule
