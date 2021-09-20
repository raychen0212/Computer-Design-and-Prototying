/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //all declaration goes here
  logic [31:0] pc, nxt_pc, imm_shamt_out, imm;
  opcode_t op;
  funct_t func;
  logic        pc0_en;

  //interface
  control_unit_if conif();
  alu_if aluif();
  register_file_if regif();
  request_unit_if request();
  
  //Pass in data
  control_unit con_func(conif);
  alu alu_func(aluif);
  register_file reg_func(CLK, nRST, regif);
  request_unit request_func(CLK, nRST, request);

  //Point Counter
  word_t  pc_plus;
  always_ff @( posedge CLK, negedge nRST ) begin : PROGRAM_REGISTER
    if(!nRST)begin
      pc <= PC_INIT;
    end
    else if(pc0_en == 1)begin
      pc <= nxt_pc;
    end
    
  end
  always_comb begin : PROGRAM_LOGIC
    nxt_pc = pc;
    pc_plus = pc + 4;
    case(conif.pcSrc)
      2'b00: nxt_pc = pc + 4;
      2'b01: nxt_pc = regif.rdat1;
      2'b10: nxt_pc = {pc_plus[31:28], conif.addr, 2'b00};
      2'b11: nxt_pc = (32'(signed'(conif.imm16))<<2) + pc + 4;
    endcase
  end
  
  ///////////END PROGRAM COUNTER///////////

  //////////////////DATAPATH //////////////////////////
  always_comb begin : Datapath
    conif.instr = dpif.imemload;
    request.ihit = dpif.ihit;
    request.dhit = dpif.dhit;
    dpif.dmemREN = request.dmemREN;
    dpif.imemREN = 1;
    dpif.dmemWEN = request.dmemWEN;
    dpif.imemaddr = pc;
    dpif.dmemaddr = aluif.outport;
    dpif.dmemstore = regif.rdat2;
    conif.zero = aluif.zero;
    func = funct_t'(conif.instr[5:0]);
    op = opcode_t'(conif.instr[31:26]);
    request.memWr = conif.memWr;
    request.memRead = conif.memRead;
    if(dpif.ihit == 1 && dpif.dhit == 0)begin
      pc0_en = 1;
    end
    else begin
      pc0_en = 0;
    end
  end

  //////////////////END DATAPATH////////////////

  ///////////ALU ENTER //////////////////
  always_comb begin : ALU_IMPLEMENTATION
    aluif.port_A = regif.rdat1;
    aluif.port_B = regif.rdat2;
    aluif.alu_op = conif.alu_op;
    if(conif.aluSrc == 1)begin
      case(conif.extop)
        2'b01: aluif.port_B = {16'h0000, conif.imm16};
        2'b10: aluif.port_B = 32'(signed'(conif.imm16));
      endcase

      if (conif.special == 1'b1)begin
        aluif.port_B = {conif.instr[15:0], 16'h0000};//LUI
      end
    end
    else if (conif.aluSrc == 0)begin
      aluif.port_B = regif.rdat2;
    end
  end
  /////////////////END ALU/////////////////
  
  ////////////////Register FIle///////////
  always_comb begin : REGISTER_LOGIC
    regif.WEN = 0;
    regif.wsel = '0;
    regif.rsel1 = conif.rs;
    regif.rsel2 = conif.rt;
    regif.wdat = '0;
    if(conif.regWr == 1 && (dpif.dhit == 1 | dpif.ihit == 1))
      regif.WEN = conif.regWr;
    else
      regif.WEN = 0;
    case(conif.regDst)
      2'b00: regif.wsel = conif.rd;
      2'b01: regif.wsel = conif.rt;
      2'b11: regif.wsel = 31;
    endcase

    case(conif.memtoreg)
      2'b00: regif.wdat = aluif.outport;
      2'b01: regif.wdat = dpif.dmemload;
      2'b10: regif.wdat = pc_plus;
  endcase

  end
  ///////////////////REGISTER FILE END/////////////////

  ///////////////////Halt//////////////////////////
  
  always_ff @( posedge CLK, negedge nRST ) begin : Halting
    if(nRST == 0)
      dpif.halt = 0;
    else
      dpif.halt <= conif.halt;
  end

  


endmodule
