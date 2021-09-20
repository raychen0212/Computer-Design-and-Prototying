// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if alureg ();
  // test program
  test PROG (CLK, alureg);
  // DUT
`ifndef MAPPED
  alu DUT(alureg);
`else
  alu DUT(
    .\alureg.alu_op (alureg.alu_op),
    .\alureg.port_A (alureg.port_A),
    .\alureg.port_B (alureg.port_B),
    .\alureg.outport (alureg.outport),
    .\alureg.zero (alureg.zero),
    .\alureg.neg (alureg.neg),
    .\alureg.overflow (alureg.overflow),
    
  );
`endif

endmodule

program test(input logic CLK, alu_if.tb testing);
  initial begin
    import cpu_types_pkg::*;
    testing.alu_op = ALU_SLL;
    testing.port_A = 32'd12;
    testing.port_B = 32'd2;
    @(negedge CLK);
    if (testing.outport == (testing.port_B << testing.port_A))begin
        $display("Test Shift Left Passed");
      end
    else begin
        $display ("Test Shift Left Failed");
    end

    testing.alu_op = ALU_SRL;
    testing.port_A = 32'd12;
    testing.port_B = 32'd2;
    @(negedge CLK);
    if (testing.outport == (testing.port_B >> testing.port_A))begin
        $display("Test Shift Right Passed");
      end
    else begin
        $display ("Test Shift Right Failed");
    end

    testing.alu_op = ALU_ADD;
    testing.port_A = 32'd12;
    testing.port_B = 32'd2;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) + $signed(testing.port_B)))begin
        $display("Test Normal Add Passed");
      end
    else begin
        $display ("Test Normal Add Failed");
    end

    testing.alu_op = ALU_ADD;
    testing.port_A = 32'h72ce2443;
    testing.port_B = 32'h43456fa8;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) + $signed(testing.port_B)) && testing.overflow == 1)begin
        $display("Test Both will overflow Add Passed");
      end
    else begin
        $display ("Test BOth will overflow Add Failed");
    end    
  

    testing.alu_op = ALU_ADD;
    testing.port_A = 32'h0;
    testing.port_B = 32'h0;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) + $signed(testing.port_B)) && testing.zero == 1)begin
        $display("Test add 0 and zero flag Passed");
      end
    else begin
        $display ("Test add 0 and zero flag Failed");
    end 

      testing.alu_op = ALU_SUB;
    testing.port_A = 32'd12;
    testing.port_B = 32'd2;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) - $signed(testing.port_B)))begin
        $display("Test Normal Minus Passed");
      end
    else begin
        $display ("Test Normal Minus Failed");
    end

    testing.alu_op = ALU_SUB;
    testing.port_A = 32'd12;
    testing.port_B = 32'd2;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) - $signed(testing.port_B)))begin
        $display("Test Normal Minus Passed");
    end
    else begin
        $display("Test Normal Minus Failed");
    end 

    testing.alu_op = ALU_SUB;
    testing.port_A = 32'h71532624;
    testing.port_B = 32'hf0123456;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) - $signed(testing.port_B))&& testing.overflow == 1)begin
        $display("Test Overflow Minus Passed");
    end
    else begin
        $display ("Test Overflow Minus Failed");
    end 

    testing.alu_op = ALU_SUB;
    testing.port_A = 32'hf0000123;
    testing.port_B = 32'h00000001;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) - $signed(testing.port_B))&& testing.neg == 1)begin
        $display("Test negative Minus Passed");
    end
    else begin
        $display ("Test negative Minus Failed");
    end

    testing.alu_op = ALU_SUB;
    testing.port_A = 32'h00001234;
    testing.port_B = 32'h00001234;
    @(negedge CLK);
    if (testing.outport == ($signed(testing.port_A) - $signed(testing.port_B))&& testing.zero == 1)begin
        $display("Test zero Minus Passed");
    end
    else begin
        $display ("Test zero Minus Failed");
    end

    testing.alu_op = ALU_AND;
    testing.port_A = 32'h00001234;
    testing.port_B = 32'h00001234;
    @(negedge CLK);
    if (testing.outport == 32'h00001234)begin
        $display("Test AND SAME Passed");
    end
    else begin
        $display ("Test AND SAME Failed");
    end

    testing.alu_op = ALU_AND;
    testing.port_A = 32'h00301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == (testing.port_A & testing.port_B))begin
        $display("Test AND diff Passed");
    end
    else begin
        $display ("Test AND diff Failed");
    end

    testing.alu_op = ALU_OR;
    testing.port_A = 32'h00301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == (testing.port_A | testing.port_B))begin
        $display("Test OR diff Passed");
    end
    else begin
        $display ("Test OR diff Failed");
    end

    testing.alu_op = ALU_OR;
    testing.port_A = 32'h00001234;
    testing.port_B = 32'h00001234;
    @(negedge CLK);
    if (testing.outport == (testing.port_A | testing.port_B))begin
        $display("Test OR SAME Passed");
    end
    else begin
        $display ("Test OR SAME Failed");
    end

    testing.alu_op = ALU_XOR;
    testing.port_A = 32'h00301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == (testing.port_A ^ testing.port_B))begin
        $display("Test XOR diff Passed");
    end
    else begin
        $display("Test XOR diff Failed");
    end

    testing.alu_op = ALU_NOR;
    testing.port_A = 32'h00301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == (~(testing.port_A | testing.port_B)))begin
        $display("Test NOR diff Passed");
    end
    else begin
        $display ("Test NOR diff Failed");
    end

    testing.alu_op = ALU_SLT;
    testing.port_A = 32'hff301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == 1)begin
        $display("Test signed smaller than Passed");
    end
    else begin
        $display ("Test signed smaller than Failed or a be larger than b");
    end


    testing.alu_op = ALU_SLTU;
    testing.port_A = 32'hff301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == 1)begin
        $display("Test unsigned smaller than Passed");
    end
    else begin
        $display ("Test unsigned smaller than Failed or a be larger than b");
    end

    testing.alu_op = ALU_SLTU;
    testing.port_A = 32'h00301a5c;
    testing.port_B = 32'h0fe1234c;
    @(negedge CLK);
    if (testing.outport == 1)begin
        $display("Test unsigned smaller than Passed");
    end
    else begin
        $display ("Test unsigned smaller than Failed or a be larger than b");
    end
  end  


endprogram
