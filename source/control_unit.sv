`include "register_file_if.vh"
`include "control_unit_if.vh"

module control_unit(
	control_unit_if.cu cuif
);

import cpu_types_pkg::*;
always_comb begin
//intruction bit fields
	 cuif.opcode = opcode_t'(cuif.instr[31:26]);
	 cuif.rs 		 = cuif.instr[25:21];
	 cuif.rt 		 = cuif.instr[20:16];
	 cuif.rd 		 = cuif.instr[15:11];
	 cuif.shamt  = cuif.instr[10:6];
	 cuif.funct  = funct_t'(cuif.instr[5:0]);
	 cuif.imm 	 = cuif.instr[15:0];
	 cuif.addr 	 = cuif.instr[25:0];
	 cuif.stopread = 0;
	 cuif.datomic = 0;

//1-bit signals
	cuif.RegWr = 1; //rfif.WEN 
  cuif.halt  = 0; 
	cuif.ALUsrc= 0; //default busB
	cuif.iREN  = 1; //default read instr
  cuif.dREN  = 0;
	cuif.dWEN  = 0;

//2-bit signals
	cuif.RegDst		 = 0; //default rd
 	cuif.PCsrc		 = 0; //default = pc + 4 
	cuif.ExtOp		 = 0; //default zero extend
  cuif.MemToReg	 = 0; //default alu output
	cuif.ALUOp		 = ALU_SLL; //default aluop

	case(cuif.opcode)
//R-type
	RTYPE: begin
//check funct field
		case(cuif.funct)
			ADDU: cuif.ALUOp = ALU_ADD;
			ADD:	cuif.ALUOp = ALU_ADD;
			AND:	cuif.ALUOp = ALU_AND;
			JR:begin
						cuif.RegWr = 0;
						cuif.PCsrc = 2'b11;  // pc = $31
					end
			NOR: cuif.ALUOp = ALU_NOR;
			OR:  cuif.ALUOp = ALU_OR;
			SLT: cuif.ALUOp = ALU_SLT;
			SLTU:cuif.ALUOp = ALU_SLTU;
			SLLV:cuif.ALUOp = ALU_SLL;
			SRLV:cuif.ALUOp = ALU_SRL;
			SUBU:cuif.ALUOp = ALU_SUB;
			SUB: cuif.ALUOp = ALU_SUB;
			XOR: cuif.ALUOp = ALU_XOR;
		endcase
	end
//I-type
	ADDIU:begin
					cuif.ExtOp		 = 1;
					cuif.ALUOp = ALU_ADD;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUsrc = 1; //portB = imm;
				end
	ADDI:begin
					cuif.ExtOp		 = 1;
					cuif.ALUOp = ALU_ADD;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUsrc = 1; //portB = imm;
			 end
	ANDI:begin
					cuif.ALUOp = ALU_AND;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUsrc = 1; //portB = imm;
			 end
	BEQ:begin
					cuif.ALUOp = ALU_SUB;
					//cuif.ExtOp = 2'b1;
					cuif.RegWr = 0;
					cuif.PCsrc = 2'b10; //branch
			end
	BNE:begin
					cuif.ALUOp = ALU_SUB;
					cuif.RegWr = 0;
					//cuif.ExtOp = 2'b1;
					cuif.PCsrc = 3'b110; //branch
			end
	LUI:begin
					cuif.ALUOp		 = ALU_OR;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ExtOp = 2'b10; //zero extend to right
					cuif.ALUsrc = 1; //portB = imm;
					cuif.MemToReg = 2'b11;
			end
	LW:begin
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUOp = ALU_ADD;
					cuif.dREN = 1;
					cuif.MemToReg = 2'b1;
					cuif.ALUsrc = 1;//portB = imm
					cuif.ExtOp		 = 1;
					cuif.stopread = 1;
					
		 end
	ORI:begin
					cuif.ALUOp = ALU_OR;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUsrc = 1; //portB = imm;
			end
	SLTI:begin
					cuif.ALUOp = ALU_SLT;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUsrc = 1; //portB = imm;
					cuif.ExtOp		 = 1;
			end
	SLTIU:begin
					cuif.ALUOp = ALU_SLTU;
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUsrc = 1; //portB = imm;
					cuif.ExtOp		 = 1;
				end
	SW:begin
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUOp = ALU_ADD;
					cuif.dWEN = 1;
					cuif.ALUsrc = 1;//portB = imm
					cuif.RegWr = 0;
					cuif.ExtOp		 = 1;
		 end
	XORI:begin
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUOp = ALU_XOR;
					cuif.ALUsrc = 1;//portB = imm

		 end
	//adding LL and SC
	LL: begin
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUOp = ALU_ADD;
					cuif.dREN = 1;
					cuif.MemToReg = 2'b1;
					cuif.ALUsrc = 1;//portB = imm
					cuif.ExtOp		 = 1;
					cuif.stopread = 1;
					cuif.datomic = 1;
	end		
	SC: begin
					cuif.RegDst = 1; //wsel = rt;
					cuif.ALUOp = ALU_ADD;
					cuif.dWEN = 1;
					cuif.ALUsrc = 1;//portB = imm
					cuif.RegWr = 1;
					cuif.ExtOp		 = 1;
					cuif.datomic = 1;
					cuif.MemToReg = 1;
	end		
	/////////////////////////	
//J-type
	J:begin
					cuif.PCsrc = 2'b01; //pc = jumpaddr
					cuif.RegWr = 0;
		end
	JAL:begin
					cuif.PCsrc = 2'b01; //pc = jumpaddr
					cuif.MemToReg = 2'b10; //wdat = pc +4
					cuif.RegDst = 2'b10; //wsel = $31
		end
//HALT
	HALT:begin
				cuif.halt = 1;
				cuif.RegWr = 0;
			 end
	endcase
end

endmodule
			









