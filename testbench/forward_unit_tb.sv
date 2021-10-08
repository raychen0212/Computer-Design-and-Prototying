// mapped needs this
`include "forward_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forward_unit_tb;

  import cpu_types_pkg::*;  
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  forward_unit_if fuif ();
  // test program
  test PROG (CLK, fuif);
  // DUT
`ifndef MAPPED
  forward_unit DUT(fuif);
`endif

endmodule

program test(input logic CLK, forward_unit_if.tb testing);
  initial begin
    testing.memwb_RegWr = 1;
    testing.memwb_wsel = 2'b11;
    testing.idex_rs = 2'b11;
    testing.idex_rt = 2'b10;
    testing.exmem_RegWr = 1;
    testing.exmem_wsel = 2'b11;
    
    
    @(negedge CLK)
    if(testing.forward_1 == 2 && testing.forward_2 == 0)begin
      $display("Pass setting forward 1 to fetch exmem output port data and forward 2 get the normal data.");
    end
    else begin
      $display("Fail setting forward 1 to fetch exmem output port data and forward 2 get the normal data.");
    end
    @(negedge CLK)
    testing.memwb_RegWr = 1;
    testing.memwb_wsel = 2'b10;
    testing.idex_rs = 2'b11;
    testing.idex_rt = 2'b10;
    testing.exmem_RegWr = 1;
    testing.exmem_wsel = 2'b11;
    
    
    @(negedge CLK)
    if(testing.forward_2 == 1 && testing.forward_1 == 2)begin
      $display("Pass setting forward 1 to fetch exmem output port data and forward 2 fetch memwb output data.");
    end
    else begin
      $display("Fail setting forward 1 to fetch exmem output port data and forward 2 fetch memwb output data.");
    end
    @(negedge CLK)
    testing.memwb_RegWr = 1;
    testing.memwb_wsel = 2'b10;
    testing.idex_rs = 2'b11;
    testing.idex_rt = 2'b10;
    testing.exmem_RegWr = 1;
    testing.exmem_wsel = 2'b10;
    
    
    @(negedge CLK)
    if(testing.forward_1 == 0 && testing.forward_2 == 2)begin
      $display("Pass setting forward 1 to fetch normal data and forward 2 fetch exmem output data.");
    end
    else begin
      $display("Fail setting forward 1 to fetch normal data and forward 2 fetch exmem output data.");
    end

    @(negedge CLK)
    testing.memwb_RegWr = 1;
    testing.memwb_wsel = 2'b11;
    testing.idex_rs = 2'b11;
    testing.idex_rt = 2'b10;
    testing.exmem_RegWr = 1;
    testing.exmem_wsel = 2'b10;
    
    
    @(negedge CLK)
    if(testing.forward_1 == 1 && testing.forward_2 == 2)begin
      $display("Pass setting forward 1 to fetch memwb output data and forward 2 fetch exmem output data.");
    end
    else begin
      $display("Fail setting forward 1 to fetch memwb output data and forward 2 fetch exmem output data.");
    end
  end
endprogram
