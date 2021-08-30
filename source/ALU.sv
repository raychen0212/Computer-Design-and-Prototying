`include "register_file_if.vh"
`include "ALU_if.vh"

import cpu_types_pkg::*;

module ALU(
	ALU_if.alu aluif
);


always_comb begin
	if (aluif.OutputPort[31])begin
		aluif.NegFlag = 1;
	end
	if (!aluif.OutputPort)begin
		aluif.ZeroFlag = 1;
	end
	case(aluif.ALUOP)
		aluif.Overflow = 0;

		ALU_SLL: aluif.OutputPort = aluif.PortA << aluif.PortB;

		ALU_SRL: aluif.OutputPort = aluif.PortA >> aluif.PortB;

		ALU_ADD: begin 
			aluif.OutputPort = $signed(aluif.PortA) + $signed(aluif.PortB);
			if((aluif.PortA[31]==aluif.PortB[31]) && (aluif.OutputPort[31] != aluif.PortA[31])begin
				aluif.Overflow = 1;end
		end

		ALU_SUB: begin
			aluif.OutputPort = $signed(aluif.PortA) - $signed(aluif.PortB);
			if((aluif.PortA[31]!=aluif.PortB[31]) && (aluif.OutputPort[31] != aluif.PortA[31])begin
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
