`include "register_file_if.vh"
`include "alu_if.vh"



module alu(
	alu_if.alu aluif
);

import cpu_types_pkg::*;
	//if (aluif.OutputPort[31])begin
		assign aluif.NegFlag = aluif.OutputPort[31]? 1: 0;
	//end
	//if (aluif.OutputPort==0)begin
		assign aluif.ZeroFlag = (aluif.OutputPort==0)? 1:0;
	//end
always_comb begin
	aluif.Overflow = 0;
	//aluif.NegFlag = 0;
	//aluif.ZeroFlag = 0;
	//aluif.OutputPort = 0;

	case(aluif.ALUOP)

		ALU_SLL: aluif.OutputPort = aluif.PortA << aluif.PortB;

		ALU_SRL: aluif.OutputPort = aluif.PortA >> aluif.PortB;

		ALU_ADD: begin 
			aluif.OutputPort = $signed(aluif.PortA) + $signed(aluif.PortB);
			if((aluif.PortA[31]==aluif.PortB[31]) && (aluif.OutputPort[31] != aluif.PortA[31]))begin
				aluif.Overflow = 1;end
		end

		ALU_SUB: begin
			aluif.OutputPort = $signed(aluif.PortA) - $signed(aluif.PortB);
			if((aluif.PortA[31]!=aluif.PortB[31]) && (aluif.OutputPort[31] != aluif.PortA[31]))begin
				aluif.Overflow = 1;end
		end

		ALU_AND: aluif.OutputPort = aluif.PortA & aluif.PortB;

		ALU_OR: aluif.OutputPort = aluif.PortA | aluif.PortB;

		ALU_XOR: aluif.OutputPort = aluif.PortA ^ aluif.PortB;

		ALU_NOR: aluif.OutputPort = !(aluif.PortA | aluif.PortB);

		ALU_SLT: aluif.OutputPort = ($signed(aluif.PortA) < $signed(aluif.PortB))? 1:0;

		ALU_SLTU: aluif.OutputPort = ($unsigned(aluif.PortA) < $unsigned(aluif.PortB))? 1:0;
	endcase
end

endmodule
