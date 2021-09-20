/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(input logic CLK, output logic nRST, register_file_if.tb testing);
  initial begin
    nRST = 0;
    
    @(negedge CLK);
    nRST = 1;
    testing.rsel1 = 5'd10;
    testing.rsel2 = 5'd10;
    @(negedge CLK);
    if (testing.rdat1 == '0 && testing.rdat2 == '0)begin
        $display("Test Case reset Passed");
      end
    else begin
        $error ("Test Case reset Failed");
    end
    nRST = 1;
    testing.WEN = 1;
    testing.wdat = 32'd30;
    for (int i = 0; i < 32; i++) begin
      testing.wsel = i;
      testing.rsel1 = i;
      testing.rsel2 = 0;
      @(negedge CLK);
      
      if (testing.wdat == testing.rdat1 && testing.rdat2 == '0)begin
        $display("Test Case %d Passed", i);
      end
      else begin
        $error ("Test Case %d Failed", i);
      end
      testing.wdat += 1;
    end
    testing.WEN = 0;
    nRST = 0;
    @(negedge CLK);
    nRST = 1;
    testing.wdat = 32'd30;
    testing.WEN = 1;
    for (int i = 0; i < 32; i++) begin
      testing.wsel = i;
      testing.rsel2 = i;
      testing.rsel1 = 0;
      @(negedge CLK);
      if (testing.wdat == testing.rdat2 && testing.rdat1 == '0)begin
        $display("Test Case %d Passed", i);
      end
      else begin
        $error ("Test Case %d Failed", i);
      end
      testing.wdat += 1;
    end
    testing.WEN = 0;
    nRST = 0;
    @(negedge CLK);
    nRST = 1;
    testing.wsel = '0;
    testing.rsel1 = '0;
    testing.rsel2 = '0;
    testing.wdat = 32'd200;
    @(negedge CLK);
    if(testing.rdat1 == '0 && testing.rdat2 == '0)begin
      $display("Test Case write to register 0 Passed");
    end
    else begin
      $error ("Test Case write to register 0 Failed");
    end
  end
endprogram
