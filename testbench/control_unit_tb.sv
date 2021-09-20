// mapped needs this
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
//`include "cpu_tpyes_pkg.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface 
  control_unit_if tbcuif();

  // test program
  test PROG (CLK, tbcuif);
  // DUT
`ifndef MAPPED
  control_unit DUT(tbcuif);
`endif



endmodule

program test(input logic CLK, control_unit_if.tb tbif);
  initial begin
      

      tbif.instr = 32'b00000000111000110001010111000100; // SLLV TEST
      @(negedge CLK);
      $display("test SLLV");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != tbif.instr[15:11])begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLL)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b11)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("SLLV Test pass");
      end

      //SRLV test
      $display("SRLV test");
      tbif.instr = 32'b00000000111000110001010111000110; // SRLV TEST
      @(negedge CLK);
      $display("test SRLV");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != tbif.instr[15:11])begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SRL)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b11)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("SRLV Test pass");
      end
      
      //SRLV test
      $display("JR");
      tbif.instr = 32'b00000000111000110001010111001000; // JR TEST
      @(negedge CLK);
      $display("test JR");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != tbif.instr[15:11])begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLL)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 0)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b01)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("JR Test pass");
      end
    
      //SRLV test
      $display("ADD test");
      tbif.instr = 32'b00000000111000110001010111100000; // SRLV TEST
      @(negedge CLK);
      $display("test ADD");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != tbif.instr[15:11])begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_ADD)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("ADD Test pass");
      end

      //sub
      $display("SUB test");
      tbif.instr = 32'b00000000111000110001010111100010; // SRLV TEST
      @(negedge CLK);
      $display("test SUB");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != tbif.instr[15:11])begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SUB)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("ADD Test pass");
      end
      /////////////END RTYPE/////////////

      /////////////Start J and JAL///////
      //Jump test
      $display("Jump");
      tbif.instr = 32'b00001000111000110001010111000110; // J TEST
      @(negedge CLK);
      $display("test Jump");
      if (tbif.rs != '0)begin
          $display ("rs loading error");
      end
      else if (tbif.rt != '0)begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLL)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 0)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b10)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("jUMP Test pass");
      end

      //Jump test
      $display("JAL");
      tbif.instr = 32'b00001100111000110001010111000110; // J TEST
      @(negedge CLK);
      $display("test JAL");
      if (tbif.rs != '0)begin
          $display ("rs loading error");
      end
      else if (tbif.rt != '0)begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLL)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b11)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b10)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != '0)begin
          $display("imm16 fail");
      end
      else begin
          $display ("JAL Test pass");
      end
      ///////////Start I type///////////
      //Jump test
      $display("BEQ");
      tbif.instr = 32'b00010000111000110001010111000110; // J TEST
      @(negedge CLK);
      $display("BEQ SRLV");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SUB)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 0)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b11)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("BEQ Test pass");
      end

      $display("BNE");
      tbif.instr = 32'b00010100111000110001010111000110; // J TEST
      @(negedge CLK);
      $display("test BNE");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SUB)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 0)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 0)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != '0)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b11)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("BNE Test pass");
      end

      $display("ADDI");
      tbif.instr = 32'b00100000111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test ADDI");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_ADD)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b10)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("ADDI Test pass");
      end

      $display("ANDI");
      tbif.instr = 32'b00110000111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test ANDI");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_AND)begin
          $display ("ALU SLL Test failed");
      end
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b01)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("ANDI Test pass");
      end

      $display("LUI");
      tbif.instr = 32'b00111100111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test ADDI");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLL)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b00)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if (tbif.special != 1'b1)begin
          $display("LUI detect fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("ADDI Test pass");
      end

      $display("LW");
      tbif.instr = 32'b10001100111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test LW");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_ADD)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 1)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 1)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b10)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("LW Test pass");
      end

      $display("ORI");
      tbif.instr = 32'b00110100111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test LW");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_OR)begin
          $display ("ALU SLL Test failed");
      end
     
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b01)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("ORI Test pass");
      end

      $display("SW");
      tbif.instr = 32'b10101100111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test LW");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_ADD)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 1)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 0)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b00)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b10)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("SW Test pass");
      end

      $display("XORI");
      tbif.instr = 32'b00111000111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test XORI");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_XOR)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b01)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("XORI Test pass");
      end

      $display("SLTI");
      tbif.instr = 32'b00101000111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test SLTI");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLT)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b10)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("SLTI Test pass");
      end

      $display("SLTIU");
      tbif.instr = 32'b00101100111000110001010111000110; // ADDI TEST
      @(negedge CLK);
      $display("test SLTIU");
      if (tbif.rs != tbif.instr[25:21])begin
          $display ("rs loading error");
      end
      else if (tbif.rt != tbif.instr[20:16])begin
          $display("rt loading error");
      end
      else if (tbif.rd != '0)begin
          $display ("rd loading error");
      end
      else if(tbif.alu_op != ALU_SLTU)begin
          $display ("ALU SLL Test failed");
      end
      
      else if (tbif.memRead != 0)begin
          $display("memRead error");
      end
      else if (tbif.memtoreg != 0)begin
          $display ("memtoreg error");
      end
      else if (tbif.memWr != 0)begin
          $display ("memWr error");
      end
      else if(tbif.halt != 0)begin
          $display ("halting error");
      end
      else if(tbif.aluSrc != 1)begin
          $display("aluSrc fail");
      end
      else if(tbif.regWr != 1)begin
          $display("regWr fail");
      end
      else if (tbif.regDst != 2'b01)begin
          $display ("regDst fail");
      end
      else if(tbif.extop != 2'b10)begin
          $display ("extop fail");
      end
      else if (tbif.pcSrc != 2'b00)begin
          $display("pcSrc fail");
      end
      else if(tbif.imm16 != tbif.instr[15:0])begin
          $display("imm16 fail");
      end
      else begin
          $display ("SLTUI Test pass");
      end
  end
    
endprogram
