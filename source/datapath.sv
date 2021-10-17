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
	alu_if					 aluif();
	register_file_if rfif();

//modules initial
	control_unit  cu(cuif);
	request_unit  ru(CLK, nRST, ruif);
	alu					  alu(aluif);
	register_file rf(CLK, nRST, rfif);

//Global varibles initial
	word_t imm, wdat;

/////////////////////////PC BLOCK//////////////////////////
word_t pc, next_pc, pc4, branchaddr, jumpaddr;
logic pcen;
assign pcen = (dpif.ihit & !dpif.dhit)? 1:0;
always_ff@(posedge CLK, negedge nRST)begin
	if(!nRST)
		pc = 0;
	else if (pcen)
		pc = next_pc;
end

assign pc4 = pc + 4;
assign branchaddr = pc4 + (imm << 2);
assign jumpaddr = {pc4[31:28], cuif.addr, 2'b00};
assign cuif.equal = aluif.ZeroFlag ;//&& (cuif.ALUOp == ALU_SUB); //equal flag for branch determination

always_comb begin

	if (cuif.PCsrc == 2'b0)
		next_pc = pc4;
	else if (cuif.PCsrc == 2'b1)
		next_pc = jumpaddr;
	else if (cuif.PCsrc == 2'b10)
		next_pc = branchaddr;
	else if (cuif.PCsrc == 2'b11)
		next_pc = rfif.rdat1;
	else 
		next_pc = pc4;
end

	//PC addr to mem
assign dpif.imemaddr = pc;


///////////////////////////////////////////////////////////

/////////////////////////Sign/Zero extend BLOCK////////////
always_comb begin
	imm =0;
  if (cuif.ExtOp == 2'b0)
		imm = {16'h0000, cuif.imm}; //zero extend
	else if(cuif.ExtOp == 2'b1)begin
		if(cuif.imm[15] == 1'b1)begin
			imm = {16'hffff, cuif.imm[15:0]};
		end
		else if(cuif.imm[15] == 1'b0)begin
			imm = {16'h0000, cuif.imm[15:0]};
		end
	end
    //imm = 32'($signed(cuif.imm)); //sign extend
	else if(cuif.ExtOp == 2'b10)	
    imm = {cuif.imm, 16'h0000};		//LUI
end

///////////////////////////////////////////////////////////

/////////////////////////ALU logic////////////////////
assign aluif.PortA = rfif.rdat1;
assign aluif.ALUOP = cuif.ALUOp;
assign dpif.dmemaddr = aluif.OutputPort;

always_comb begin
	aluif.PortB = 0;
	if(cuif.ALUsrc == 0)
		aluif.PortB = rfif.rdat2;
	else if (cuif.ALUsrc == 1)
		aluif.PortB = imm;
end
////////////////////////////////////////////////////////////

//////////////////////Register File logic///////////////////
assign dpif.dmemstore = rfif.rdat2;
assign cuif.instr = dpif.imemload;
assign rfif.WEN = (dpif.ihit || dpif.dhit)? (cuif.RegWr? 1 : 0): 0;
assign rfif.rsel1 = cuif.rs;
assign rfif.rsel2 = cuif.rt;
assign rfif.wdat = wdat;

always_comb begin
	rfif.wsel = 0;
	if (cuif.RegDst == 2'b0)
		rfif.wsel = cuif.rd;
	else if (cuif.RegDst == 2'b1)
		rfif.wsel = cuif.rt;
	else if (cuif.RegDst == 2'b10)
		rfif.wsel = 31;								//JAL
end 
////////////////////////////////////////////////////////////

/////////////////////MemToReg Mux///////////////////////////
always_comb begin
	wdat = 0;
  if (cuif.MemToReg == 2'b0)
  	wdat = aluif.OutputPort;
  else if (cuif.MemToReg == 2'b1)
    wdat = dpif.dmemload;							//lw
  else if (cuif.MemToReg == 2'b10)
    wdat = pc4;												//JAL
end

////////////////////////////////////////////////////////////

/////////////////////Request Unit Block//////////////////////
assign ruif.ihit    = dpif.ihit;
assign ruif.dhit    = dpif.dhit;
assign ruif.dREN    = cuif.dREN;
assign ruif.dWEN    = cuif.dWEN;
assign dpif.dmemREN  = ruif.dmemREN;
assign dpif.dmemWEN  = ruif.dmemWEN;
assign dpif.imemREN  = dpif.halt? 0: 1;
////////////////////////////////////////////////////////////

//halt
always_ff @(posedge CLK, negedge nRST) begin
  if(!nRST)
    dpif.halt <= 0;
  else 
    dpif.halt <= cuif.halt;
end


endmodule

