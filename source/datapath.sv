/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"

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

//interface initial
	control_unit_if  cuif();
	request_unit_if  ruif();
	alu_if			aluif();
	register_file_if rfif();
	if_id_if		ifidif();
	id_ex_if		idexif();
	ex_mem_if		exmemif();
	mem_wb_if		memwbif();

//modules initial
	control_unit  cu(cuif);
	request_unit  ru(CLK, nRST, ruif);
	alu					  alu(aluif);
	register_file rf(CLK, nRST, rfif);
	if_id 		  ii(CLK, nRST, ifidif);
	id_ex 		  ie(CLK, nRST, idexif);
	ex_mem 		  em(CLK, nRST, exmemif);
	mem_wb 		  mw(CLK, nRST, memwbif);

//Global varibles initial
	word_t imm, wdat;

/////////////////////////PC BLOCK//////////////////////////
word_t pc, next_pc, pc4, jumpaddr;
logic pcen;
//logic [2:0] PCSrc;
assign pcen = (dpif.ihit & !dpif.dhit)? 1:0;


always_ff@(posedge CLK, negedge nRST)begin
	if(!nRST)
		pc = 0;
	else if (pcen)
		pc = next_pc;
end

assign pc4 = pc + 4;
//assign branchaddr = pc4 + (imm << 2);
assign jumpaddr = {pc4[31:28], exmemif.jaddr_o, 2'b00};
//assign cuif.equal = aluif.ZeroFlag ;//&& (cuif.ALUOp == ALU_SUB); //equal flag for branch determination

always_comb begin

	if (exmemif.PCsrc_o == 2'b0)
		next_pc = pc4;
	else if (exmemif.PCsrc_o == 2'b1)
		next_pc = jumpaddr;
	else if (exmemif.PCsrc_o == 2'b10 && exmemif.ZeroFlag_o)
		next_pc = exmemif.branchaddr_o;
	else if (exmemif.PCsrc_o == 2'b11)
		next_pc = idexif.rdat1_o;
	else 
		next_pc = pc;
end

	//PC addr to mem
assign dpif.imemaddr = pc;


///////////////////////////////////////////////////////////

/////////////////////////Sign/Zero extend BLOCK////////////
always_comb begin
	imm =0;
  if (idexif.ExtOp_o == 2'b0)
		imm = {16'h0000, idexif.imm_o}; //zero extend
	else if(idexif.ExtOp_o == 2'b1)
    imm = 32'($signed(idexif.imm_o)); //sign extend
	else if(idexif.ExtOp_o == 2'b10)	
    imm = {idexif.imm_o, 16'h0000};		//LUI
end
///////////////////////////////////////////////////////////

/////////////////////////ALU logic////////////////////
assign aluif.PortA = idexif.rdat1_o;
assign aluif.ALUOP = idexif.ALUOp_o;
assign dpif.dmemaddr = exmemif.OutputPort_o;

always_comb begin
	aluif.PortB = 0;
	if(idexif.ALUsrc_o == 0)
		aluif.PortB = idexif.rdat2_o;
	else if (idexif.ALUsrc_o == 1)
		aluif.PortB = idexif.imm_o;
end
////////////////////////////////////////////////////////////

//////////////////////Register File logic///////////////////
assign dpif.dmemstore = exmemif.rdat2_o;
//assign cuif.instr =  ifidif.instr_o;
assign cuif.instr =  memwbif.stopread_o? 0: ifidif.instr_o;
//assign rfif.WEN = (dpif.ihit || dpif.dhit)? (memwbif.RegWr_o? 1 : 0): 0;
assign rfif.WEN = memwbif.RegWr_o;
assign rfif.rsel1 = cuif.rs;
assign rfif.rsel2 = cuif.rt;
assign rfif.wdat = wdat;
assign rfif.wsel = memwbif.wsel_o;

always_comb begin
	exmemif.wsel_i = 0;
	if (idexif.RegDst_o == 2'b0)
		exmemif.wsel_i = idexif.rd_o;
	else if (idexif.RegDst_o == 2'b1)
		exmemif.wsel_i = idexif.rt_o;
	else if (idexif.RegDst_o == 2'b10)
		exmemif.wsel_i = 31;								//JAL
end 
////////////////////////////////////////////////////////////

/////////////////////MemToReg Mux///////////////////////////
always_comb begin
	wdat = 0;
  if (memwbif.MemToReg_o == 2'b0)
  	wdat = memwbif.OutputPort_o;
  else if (memwbif.MemToReg_o == 2'b1)
    wdat = memwbif.dmemload_o;							//lw
  else if (memwbif.MemToReg_o == 2'b10)
    wdat = memwbif.pc4_o;												//JAL
  else if (memwbif.MemToReg_o == 2'b11)
    wdat = memwbif.imm_o;//lui
end

////////////////////////////////////////////////////////////

/////////////////////Request Unit Block//////////////////////
assign ruif.ihit    = dpif.ihit;
assign ruif.dhit    = dpif.dhit;
assign ruif.dREN    = idexif.dREN_o;
assign ruif.dWEN    = idexif.dWEN_o;
assign dpif.dmemREN  = exmemif.dREN_o;
assign dpif.dmemWEN  = exmemif.dWEN_o;
assign dpif.imemREN  = dpif.halt? 0: 1;
////////////////////////////////////////////////////////////

//halt
always_ff @(posedge CLK, negedge nRST) begin
  if(!nRST)
    dpif.halt <= 0;
  else 
    dpif.halt <= memwbif.halt_o;
end
////////////////////////////////////////////////////////////////

////////////////////IF-ID//////////////////////////////////////
always_comb begin : IF_ID_CONNECTION
	ifidif.instr_i = dpif.imemload;
	ifidif.pc4_i   = pc4;
	ifidif.flush = 0;
	ifidif.en = 1;
end
///////////////////////////////////////////////////////////////

///////////////////ID-EX/////////////////////////////////////
always_comb begin : ID_EX_CONNECTION
	idexif.flush = 0;
	idexif.en    = 1;
	idexif.rdat1_i = rfif.rdat1;
	idexif.rdat2_i = rfif.rdat2;
	idexif.imm_i   = cuif.imm;
	idexif.pc4_i   = ifidif.pc4_o;
	idexif.jaddr_i = cuif.addr;
	idexif.rt_i    = cuif.rt;
	idexif.rd_i    = cuif.rd;
	idexif.RegWr_i = cuif.RegWr;
	idexif.halt_i  = cuif.halt;
	idexif.ALUsrc_i= cuif.ALUsrc;
	idexif.dREN_i  = cuif.dREN;
	idexif.dWEN_i  = cuif.dWEN;
	idexif.RegDst_i= cuif.RegDst;
	idexif.MemToReg_i = cuif.MemToReg;
	idexif.PCsrc_i = cuif.PCsrc;
	idexif.ExtOp_i = cuif.ExtOp;
	idexif.ALUOp_i = cuif.ALUOp;
	idexif.stopread_i = cuif.stopread;
end
//////////////////////////////////////////////////////////////

////////////////EX-MEM///////////////////////////////////////
always_comb begin : EX_MEM_CONNECTION
	exmemif.flush = 0;
	exmemif.en    = 1;
	exmemif.rdat2_i = idexif.rdat2_o;
	exmemif.imm_i	= imm;
	exmemif.pc4_i	= idexif.pc4_o;
	exmemif.jaddr_i = idexif.jaddr_o;
	exmemif.branchaddr_i = idexif.pc4_o + (idexif.imm_o << 2);
	exmemif.OutputPort_i = aluif.OutputPort;
	//exmemif.wsel in regfile block
	exmemif.RegWr_i = idexif.RegWr_o;
	exmemif.halt_i  = idexif.halt_o;
	exmemif.dREN_i  = idexif.dREN_o;
	exmemif.dWEN_i	= idexif.dWEN_o;
	exmemif.ZeroFlag_i = aluif.ZeroFlag;
	exmemif.MemToReg_i = idexif.MemToReg_o;
	exmemif.PCsrc_i	= idexif.PCsrc_o;
	exmemif.stopread_i = idexif.stopread_o;
end 
////////////////////////////////////////////////////////////////

//////////////////MEM-WB///////////////////////////////////////
always_comb begin: MEM_WB_CONNECTION
	memwbif.flush = 0;
	memwbif.en    = 1;
	memwbif.imm_i	= exmemif.imm_o;
	memwbif.pc4_i	= exmemif.pc4_o;
	memwbif.OutputPort_i = exmemif.OutputPort_o;
	memwbif.dmemload_i = dpif.dmemload;
	memwbif.wsel_i	= exmemif.wsel_o;
	memwbif.RegWr_i = exmemif.RegWr_o;
	memwbif.halt_i  = exmemif.halt_o;
	memwbif.MemToReg_i = exmemif.MemToReg_o;
	memwbif.stopread_i = exmemif.stopread_o;
end
/////////////////////////////////////////////////////////////


endmodule