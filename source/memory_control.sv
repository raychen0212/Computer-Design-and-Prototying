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

  always_comb begin : loading
    ccif.dload = '0;
    if(ccif.ramstate == ACCESS)begin
      ccif.dload = ccif.ramload;
    end
    ccif.iload = ccif.ramload;
    

  end
  always_comb begin : MEMORY

    ccif.ramWEN = '0;
    ccif.ramREN = '0;
    ccif.ramaddr = '0;
    ccif.ramstore = '0;


  ////////////////////////////
  //Deal with ram wen, ram ren
    if(ccif.dWEN == 1'b1)begin
      ccif.ramWEN = 1;
      ccif.ramREN = 0;
    end
    else if(ccif.dREN == 1'b1) begin
      ccif.ramWEN = 0;
      ccif.ramREN = 1;
    end
    else if(ccif.iREN == 1'b1) begin
      ccif.ramWEN = 0;
      ccif.ramREN = 1;
    end
    else begin
      ccif.ramWEN = '0;
      ccif.ramREN = '0;
    end
    ////////////////////////////

    ////////////////////////////
    //Deal with address and store data
    if(ccif.dWEN == 1'b1)begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramstore = ccif.dstore;
    end
    else if(ccif.dREN == 1'b1) begin
      ccif.ramaddr = ccif.daddr;
      ccif.ramstore = '0;
    end
    else if(ccif.iREN == 1'b1) begin
      ccif.ramaddr = ccif.iaddr;
      ccif.ramstore = '0;
    end
    else begin
      ccif.ramaddr = '0;
      ccif.ramstore = '0;
    end
    //////////////////////////////////

    ////////////////////////////
    //Deal with iwait and dwait

    //////////////////////////////////
  end
  assign ccif.dwait = (ccif.ramstate == ACCESS && ccif.dWEN == 1 || ccif.dREN == 1) ? 0 : 1;
  assign ccif.iwait = (ccif.ramstate == ACCESS && ccif.dWEN == 0 && ccif.dREN == 0 && ccif.iREN == 1)?0:1;
endmodule
