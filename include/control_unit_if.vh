`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  regbits_t   rs;
  regbits_t   rt;
  regbits_t   rd;
  aluop_t     alu_op;
  word_t      instr;
  logic       jump, branch, memRead, memWr, regWr, halt, aluSrc;
  logic[1:0]  regDst, pcSrc, extop, memtoreg;
  logic[15:0] imm16;
  logic [5:0] shamt;
  logic [25:0] addr;
  logic [5:0] funct;
  logic [5:0] opcode;
  logic       special;
  logic       zero;
  // For pcSrc, if it is equals to 
  // 2'b01 it means to jump return (JR)
  // 2'b10 means to jump or jal
  // 2'b11 means to give it a branch
  // For aluSrc, just 1 bit, one is for bus b and the other is extended value
  // For regDst, if equals to 2'b00, it means to return back to rd
  // 2'b01, go to rt
  // 2'b11, go to register 31
  // memtoReg only happend when loading
  // For extop, if it do not need extend, set to 2'b00;
  // 2'b01 means zero extend;
  // 2'b10 means sign extend;
  // 2'b11 means shift extend
   

  modport control(
    input instr, zero,
    output rs, rt, rd, alu_op, memRead, memtoreg, memWr, regWr, halt, extop, 
    regDst, pcSrc, aluSrc, imm16, shamt, addr, funct, opcode, special
  );

  modport tb(
    input rs, rt, rd, alu_op, memRead, memtoreg, memWr, regWr, halt, extop, 
    regDst, pcSrc, aluSrc, imm16, shamt, addr, funct, opcode, special,
    output instr, zero
);

endinterface

`endif //CONTROL_UNIT_IF