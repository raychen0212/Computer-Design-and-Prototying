// mapped needs this
`include "hazard_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  import cpu_types_pkg::*;  
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif ();
  // test program
  test PROG (CLK, huif);
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`endif

endmodule

program test(input logic CLK, hazard_unit_if.tb testing);
  initial begin
    testing.idex_wsel = 2'b11;
    testing.ifid_rs = 2'b11;
    testing.ifid_rt = 2'b10;
    testing.idex_dREN = '0;
    @(negedge CLK)
    if(testing.ifid_en == 0 && testing.idex_flush == 1)begin
      $display("Pass 1");
    end
    else begin
      $display("Fail 1");
    end
    @(negedge CLK)
    testing.exmem_wsel = 2'b11;
    testing.ifid_rs = 2'b01;
    testing.ifid_rt = 2'b11;
    testing.idex_dREN = '0;
    @(negedge CLK)
    if(testing.ifid_en == 0 && testing.idex_flush == 1)begin
      $display("Pass 2");
    end
    else begin
      $display("Fail 2");
    end
    @(negedge CLK)
    testing.memwb_wsel = 2'b11;
    testing.ifid_rs = 2'b01;
    testing.ifid_rt = 2'b11;
    testing.idex_dREN = '0;
    @(negedge CLK)
    if(testing.ifid_en == 0 && testing.idex_flush == 1)begin
      $display("Pass 3");
    end
    else begin
      $display("Fail 3");
    end

    @(negedge CLK)
    testing.exmem_PCSrc = 2'b01;
    testing.exmem_ZeroFlag = 1'b1;
    @(negedge CLK)
    if(testing.ifid_flush == 1 && testing.idex_flush == 1 && testing.exmem_flush == 1)begin
      $display("Pass 4");
    end
    else begin
      $display("Fail 4");
    end

  end
endprogram
