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
`include "hazard_unit_if.vh"
`include "forward_unit_if.vh"

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
	hazard_unit_if  huif();
	forward_unit_if fuif();

//modules initial
	control_unit  cu(cuif);
	request_unit  ru(CLK, nRST, ruif);
	alu					  alu(aluif);
	register_file rf(CLK, nRST, rfif);
	if_id 		  ii(CLK, nRST, ifidif);
	id_ex 		  ie(CLK, nRST, idexif);
	ex_mem 		  em(CLK, nRST, exmemif);
	mem_wb 		  mw(CLK, nRST, memwbif);
	hazard_unit   hu(huif);
	forward_unit  fu(fuif);

//Global varibles initial
	word_t imm, wdat, muxB;
	logic[1:0] check;

/////////////////////////PC BLOCK//////////////////////////
word_t pc, next_pc, pc4, jumpaddr;
logic pcen;
//logic [2:0] PCSrc;
assign pcen = ((dpif.ihit & !dpif.dhit & ifidif.en) 
 || (exmemif.PCsrc_o == 2'b1)
 || ((exmemif.PCsrc_o == 2'b10 && exmemif.ZeroFlag_o) || (exmemif.PCsrc_o == 3'b110 && !exmemif.ZeroFlag_o)) 
 || (exmemif.PCsrc_o == 2'b11))? 1:0;


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
	//next_pc = pc;
		if (exmemif.PCsrc_o == 2'b0)
		next_pc = pc4;
		else if (exmemif.PCsrc_o == 2'b1)
		next_pc = jumpaddr;
		else if ((exmemif.PCsrc_o == 2'b10 && exmemif.ZeroFlag_o) || (exmemif.PCsrc_o == 3'b110 && !exmemif.ZeroFlag_o))
		next_pc = exmemif.branchaddr_o;
		else if (exmemif.PCsrc_o == 2'b11)
		next_pc = exmemif.rdat1_o;
		else
		next_pc = pc4;
end

	//PC addr to mem
assign dpif.imemaddr = pc;


///////////////////////////////////////////////////////////

/////////////////////////Sign/Zero extend BLOCK////////////
always_comb begin
	imm =0;
	check = 0;
  	if (idexif.ExtOp_o == 2'b0)begin
		imm = {16'h0000, idexif.imm_o}; //zero extend
		check = 2'b01;
	  end
	else if(idexif.ExtOp_o == 2'b1)begin
		if(idexif.imm_o[15] == 1'b1)begin
			imm = {16'hffff, idexif.imm_o[15:0]};
			check = 2'b10;
		end
		else if(idexif.imm_o[15] == 1'b0)begin
			imm = {16'h0000, idexif.imm_o[15:0]};
			check = 2'b11;
		end
	end
    //imm = 32'($signed(idexif.imm_o)); //sign extend
	else if(idexif.ExtOp_o == 2'b10)	begin
		imm = {idexif.imm_o, 16'h0000};		//LUI
	end
end
///////////////////////////////////////////////////////////

/////////////////////////ALU logic////////////////////
//assign aluif.PortA = idexif.rdat1_o;
assign aluif.ALUOP = idexif.ALUOp_o;
assign dpif.dmemaddr = exmemif.OutputPort_o;

always_comb begin
	aluif.PortB = 0;
	if(idexif.ALUsrc_o == 0)
		aluif.PortB = muxB;
	else if (idexif.ALUsrc_o == 1)
		aluif.PortB = imm;
end
////////////////////////////////////////////////////////////

//////////////////////Register File logic///////////////////
assign dpif.dmemstore = exmemif.rdat2_o;
//assign cuif.instr =  ifidif.instr_o;
assign cuif.instr =  (memwbif.dREN_o)? 0: ifidif.instr_o;
//assign rfif.WEN = (dpif.ihit || dpif.dhit)? (memwbif.RegWr_o? 1 : 0): 0;
assign rfif.WEN = memwbif.RegWr_o;
assign rfif.rsel1 = cuif.rs;
assign rfif.rsel2 = cuif.rt;
assign rfif.wdat = wdat;
assign rfif.wsel = memwbif.wsel_o;

always_comb begin
	exmemif.wsel_i = 0;
	//huif.idex_wsel = 0;
	if (idexif.RegDst_o == 2'b0)begin
		exmemif.wsel_i = idexif.rd_o;
		/*if(idexif.PCsrc_o == 2'b10 || idexif.PCsrc_o == 3'b110)begin
		huif.idex_wsel = 0;
		end
		else begin 
			huif.idex_wsel = idexif.rd_o;
		end*/
	end
	else if (idexif.RegDst_o == 2'b1)begin
		exmemif.wsel_i = idexif.rt_o;
		//huif.idex_wsel = idexif.rt_o;
		
	end
	else if (idexif.RegDst_o == 2'b10)begin
		exmemif.wsel_i = 31;	
		//huif.idex_wsel = 31;			
	end					//JAL
	
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
    dpif.halt <= memwbif.halt_i;
end
////////////////////////////////////////////////////////////////
////////////////Forward_unit///////////////////////////////////
assign fuif.idex_rs = idexif.rs_o;
assign fuif.idex_rt = idexif.rt_o;
assign fuif.exmem_wsel = exmemif.wsel_o;
assign fuif.memwb_wsel = memwbif.wsel_o;
//assign fuif.exmem_dmemren = exmemif.dREN_o;
//assign fuif.exmem_dmemwen = exmemif.dWEN_o;
assign fuif.exmem_RegWr = exmemif.RegWr_o;
assign fuif.memwb_RegWr = memwbif.RegWr_o;

//forward
always_comb begin : Forward_1_Logic
aluif.PortA = 0;

	casez (fuif.forward_1)
		2'b00: aluif.PortA = idexif.rdat1_o;
		2'b01: aluif.PortA = (memwbif.dREN_o)? memwbif.dmemload_o: memwbif.OutputPort_o;
		2'b10: aluif.PortA = (exmemif.dREN_o)? dpif.dmemload : exmemif.OutputPort_o;
	endcase
end

always_comb begin : Forward_2_Logic
muxB = 0;
	casez (fuif.forward_2)
		2'b00: muxB = idexif.rdat2_o;
		2'b01:muxB = (memwbif.dREN_o)? memwbif.dmemload_o: memwbif.OutputPort_o;
		2'b10:muxB = (exmemif.dREN_o)? dpif.dmemload : exmemif.OutputPort_o;
	endcase
end

////////////////Hazard_unit//////////////////////////////////
assign huif.exmem_wsel = exmemif.wsel_o;
assign huif.idex_wsel = idexif.rt_o;
assign huif.memwb_wsel = memwbif.wsel_o;
assign huif.ifid_rs = cuif.rs;
assign huif.ifid_rt = cuif.rt;
assign huif.exmem_PCSrc = exmemif.PCsrc_o; 
//assign huif.memwb_MemToReg = memwbif.MemToReg_o;
assign huif.exmem_ZeroFlag = exmemif.ZeroFlag_o;
assign huif.idex_dREN = idexif.dREN_o;
assign huif.exmem_dREN = exmemif.dREN_o;
assign huif.exmem_dWEN = exmemif.dWEN_o;
assign huif.memwb_dREN = memwbif.dREN_o;
assign huif.dhit = dpif.dhit;
////////////////////IF-ID//////////////////////////////////////
always_comb begin : IF_ID_CONNECTION
	//ifidif.instr_i = (pc == next_pc)? ifidif.instr_i: dpif.imemload;
	ifidif.instr_i = dpif.imemload ;
	ifidif.pc4_i   = pc4;
	ifidif.flush = huif.ifid_flush;
	ifidif.en = huif.ifid_en;
	//cputracker only
	ifidif.pc_i = pc;
    ifidif.next_pc_i = next_pc;
end
///////////////////////////////////////////////////////////////

///////////////////ID-EX/////////////////////////////////////
always_comb begin : ID_EX_CONNECTION
	idexif.flush = huif.idex_flush;
	idexif.en    = huif.idex_en;
	idexif.rdat1_i = rfif.rdat1;
    idexif.rdat2_i = rfif.rdat2;
    idexif.imm_i = cuif.imm;
	idexif.pc4_i   = ifidif.pc4_o;
	idexif.jaddr_i = cuif.addr;
	idexif.rs_i	   = cuif.rs;
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
	//cputracker only
	idexif.pc_i = ifidif.pc_o;
	idexif.next_pc_i = ifidif.next_pc_o;
	idexif.instr_i = ifidif.instr_o;
	idexif.lui_imm_i = cuif.imm;
	idexif.funct_i = cuif.funct;
	idexif.opcode_i = cuif.opcode;
	idexif.wdat_i = wdat;
end
//////////////////////////////////////////////////////////////

////////////////EX-MEM///////////////////////////////////////
always_comb begin : EX_MEM_CONNECTION
	exmemif.flush = huif.exmem_flush;
	exmemif.en    = huif.exmem_en;
	exmemif.rdat2_i = ((fuif.forward_2 == 2'b1 || fuif.forward_2 == 2'b10) && idexif.dWEN_o) ? muxB: idexif.rdat2_o;
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
	//cputracker only
	exmemif.pc_i = idexif.pc_o;
	exmemif.next_pc_i = idexif.next_pc_o;
	exmemif.instr_i = idexif.instr_o;
	exmemif.lui_imm_i = idexif.lui_imm_o;
	exmemif.funct_i = idexif.funct_o;
	exmemif.opcode_i = idexif.opcode_o;
	exmemif.rs_i = idexif.rs_o;
	exmemif.rt_i = idexif.rt_o;
	exmemif.wdat_i = idexif.wdat_o;
	exmemif.rd_i = idexif.rd_o; 
	exmemif.rdat1_i = idexif.rdat1_o;
end 
////////////////////////////////////////////////////////////////

//////////////////MEM-WB///////////////////////////////////////
always_comb begin: MEM_WB_CONNECTION
	memwbif.flush = huif.memwb_flush;
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
	//cputracker only
	memwbif.pc_i = exmemif.pc_o;
    memwbif.next_pc_i = exmemif.next_pc_o;
    memwbif.instr_i = exmemif.instr_o;
    memwbif.lui_imm_i = exmemif.lui_imm_o;
    memwbif.funct_i = exmemif.funct_o;
    memwbif.opcode_i = exmemif.opcode_o;
    memwbif.rs_i = exmemif.rs_o;
    memwbif.rt_i = exmemif.rt_o;
    memwbif.branchaddr_i = exmemif.branchaddr_o;
    memwbif.rdat2_i = exmemif.rdat2_o;
	memwbif.wdat_i = exmemif.wdat_o;
	memwbif.rd_i = exmemif.rd_o;
	memwbif.dREN_i = exmemif.dREN_o;
end
/////////////////////////////////////////////////////////////


endmodule