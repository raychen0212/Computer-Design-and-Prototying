`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic     neg, overflow, zero;
  aluop_t   alu_op;
  word_t    port_A, port_B, outport;

  // alu ports
  modport aluport (
    input   alu_op, port_A, port_B,
    output  neg, overflow, zero, outport
  );
  // alu tb
  modport tb (
    input   neg, overflow, zero, outport, 
    output  alu_op, port_A, port_B
  );
endinterface

`endif //ALU_IF_VH