`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

import cpu_types_pkg::*;

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;
  
  // interface
  control_unit_if cuif();

  // test program
  test #(.PERIOD (PERIOD)) PROG (CLK, nRST, cuif);

  // DUT
`ifndef MAPPED
  control_unit DUT(.cuif);
`else
  // implement
`endif

endmodule

program test (
  input logic CLK, 
  output logic nRST, 
  control_unit_if.cu tbif
);
  parameter PERIOD = 10;

  initial begin

    opcode_t [15-1:0] opcodes;
    funct_t [13-1:0] functs;
    opcode_t opcode;
    funct_t funct; 

    opcodes = {J, JAL, ADDI, ADDIU, ANDI, BEQ, BNE, LUI, LW, ORI, SLTI, SLTIU, SW, XORI, HALT};
    functs = {ADD, ADDU, AND, JR, OR, NOR, SLT, SLTU, SLLV, SRLV, SUBU, SUB, XOR};

    #(PERIOD)

    for (int j =12; j >= 0; j--)begin
      funct = functs[j];
      tbif.instr = {RTYPE, 20'h000000, funct};
      #(PERIOD/10);
    end

    for (int i = 14; i >= 0; i--)begin
      opcode = opcodes[i];
      for (int equal = 0; equal <= 1; equal++)begin
        #(PERIOD/10);
        // SET
        tbif.instr = {opcode, 20'h000000, 2'b10101};
        tbif.equal = equal;
        #(PERIOD/10);
      end
    end
	end
endprogram
