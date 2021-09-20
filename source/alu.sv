`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu (alu_if.aluport alureg);
    import cpu_types_pkg::*;
    always_comb begin : ALU_CODE
        alureg.outport = '0;
        alureg.overflow = '0;
        
        casez (alureg.alu_op)
            ALU_SLL:begin
                alureg.outport = alureg.port_B << alureg.port_A[4:0];
            end
            ALU_SRL: begin
                alureg.outport = alureg.port_B >> alureg.port_A[4:0];
            end
            ALU_ADD: begin
                alureg.outport = $signed(alureg.port_A) + $signed(alureg.port_B);
                if(alureg.port_A[31] == alureg.port_B[31] && alureg.outport[31] != alureg.port_A[31])begin
                    alureg.overflow = 1;
                end
            end
            ALU_SUB:begin
                alureg.outport = $signed(alureg.port_A) - $signed(alureg.port_B);
                if(alureg.port_A[31] != alureg.port_B[31] && alureg.outport[31] != alureg.port_A[31])begin
                    alureg.overflow = 1;
                end
            end
            ALU_AND: begin
               alureg.outport = alureg.port_A & alureg.port_B;
            end
            ALU_OR: begin
                alureg.outport = alureg.port_A | alureg.port_B;
            end
            ALU_XOR: begin
                alureg.outport = alureg.port_A ^ alureg.port_B;
            end
            ALU_NOR: begin
                alureg.outport = ~(alureg.port_A | alureg.port_B);
            end
            ALU_SLT: begin
                alureg.outport = ($signed(alureg.port_A) < $signed(alureg.port_B));
            end
            ALU_SLTU: begin
                alureg.outport = (alureg.port_A < alureg.port_B);
            end
            

        endcase
    end
    assign alureg.zero = (alureg.outport == '0)?1:0;
    assign alureg.neg = (alureg.outport[31] == 1)?1:0;



endmodule