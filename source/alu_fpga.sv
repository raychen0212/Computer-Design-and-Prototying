`include "alu_if.vh"
`include "cpu_types_pkg.vh"
	import cpu_types_pkg::*;
module alu_fpga (
  input logic CLOCK_50,
  input logic [3:0] KEY,
  input logic [17:0] SW,
  output logic [17:0] LEDR,
  output logic [7:0] LEDG
);

  word_t regB = 32'h0;
  logic [17:0] ledDisp;

  always_latch begin : setPortB
    if (SW[17] == 1'b1) begin
      regB = {16'h0, SW[16:0]};
    end else begin
      regB = regB;
    end
  end

  // interface
  alu_if alu_if();

  // rf
  alu alu_unit(alu_if);

  assign alu_if.PortA = {15'h0, SW[16:0]};
  assign alu_if.PortB = {15'h0, regB[16:0]};
  assign alu_if.ALUOP = aluop_t'(KEY[3:0]);

  assign LEDR[17:0] = alu_if.OutputPort;

  assign LEDG[0] = alu_if.ZeroFlag;
  assign LEDG[1] = alu_if.NegFlag;
  assign LEDG[2] = alu_if.Overflow;

  assign LEDG[7:4] = alu_if.ALUOP;

endmodule
