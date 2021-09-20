`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

module control_unit (control_unit_if.control conif);
    import cpu_types_pkg::*;
    opcode_t  alu_g;
    funct_t the_func;
    assign alu_g = opcode_t'(conif.instr[31:26]);
    assign the_func = funct_t'(conif.instr[5:0]);
    always_comb begin : CONTROL_SIGNAL
        conif.alu_op = ALU_SLL;
        conif.memRead = '0;
        conif.memtoreg = '0;
        conif.memWr = '0;
        conif.regWr = '0;
        conif.halt = '0;
        conif.extop = '0;
        conif.regDst = '0;
        conif.pcSrc = '0;
        conif.aluSrc = '0;
        conif.special = '0;
        
        //R_type
        if (alu_g == RTYPE)begin
            
            if(the_func == SLLV) begin
                conif.alu_op = ALU_SLL;
                conif.regWr = 1'b1;
                conif.aluSrc = 1'b0; //get extended value
                
            end
            else if (the_func == SRLV)begin
                conif.alu_op = ALU_SRL;
                conif.regWr = 1'b1;
                conif.aluSrc = 1'b0; // get extended value
                
            end
            else if (the_func == JR)begin
                conif.pcSrc = 2'b01; // jump select
                
            end
            else if (the_func == ADD || the_func == ADDU) begin
                conif.alu_op = ALU_ADD;
                conif.regWr = 1;
            end
            else if (the_func == SUB || the_func == SUBU)begin
                conif.alu_op = ALU_SUB;
                conif.regWr = 1;
            end
            else if (the_func == AND) begin
                conif.alu_op = ALU_AND;
                conif.regWr = 1;
            end
            else if (the_func == OR) begin
                conif.alu_op = ALU_OR;
                conif.regWr = 1;
            end
            else if (the_func == XOR) begin
                conif.alu_op = ALU_XOR;
                conif.regWr = 1;
            end
            else if (the_func == NOR) begin
                conif.alu_op = ALU_NOR;
                conif.regWr = 1;
            end
            else if (the_func == SLT) begin
                conif.alu_op = ALU_SLT;
                conif.regWr = 1;
            end
            else if (the_func == SLTU) begin
                conif.alu_op = ALU_SLTU;
                conif.regWr = 1;
            end
        end

        //J type for J and JAL
        else if(alu_g == J || alu_g == JAL) begin
            if(alu_g == J) begin
                conif.pcSrc = 2'b10;
            end
            else if(alu_g == JAL) begin
                conif.pcSrc = 2'b10;
                conif.regWr = 1;
                conif.regDst = 2'b11;
                conif.memtoreg = 2'b10;
            end
        end

        //I type
        else if (alu_g == ADDI || alu_g == ADDIU) begin
            conif.aluSrc = 1;
            conif.extop = 2'b10;
            conif.alu_op = ALU_ADD;
            conif.regWr = 1;
            conif.regDst = 2'b01; //store into rt
        end
        else if(alu_g == ANDI) begin
            conif.aluSrc = 1;
            conif.extop = 2'b01;
            conif.alu_op = ALU_AND;
            conif.regWr = 1;
            conif.regDst = 2'b01; //store into rt
        end
        else if (alu_g == BEQ) begin
            if(conif.zero == 1)begin
                conif.pcSrc = 2'b11;
            end
            else begin
                conif.pcSrc = 2'b00;
            end
            conif.alu_op = ALU_SUB;
        end
        else if (alu_g == BNE) begin
            if(conif.zero == 0)begin
               conif.pcSrc = 2'b11;
            end
            else begin
                conif.pcSrc = 2'b00;
            end
            conif.alu_op = ALU_SUB;
        end
        else if (alu_g == LUI) begin
            conif.aluSrc = 1;
            conif.extop = 2'b00;
            conif.special = 1;
            conif.regWr = 1;
            conif.alu_op = ALU_OR;
            conif.regDst = 2'b01; //store into rt
        end
        else if (alu_g == LW) begin
            conif.aluSrc = 1;
            conif.memtoreg = 2'b01;
            conif.extop = 2'b10;
            conif.regWr = 1;
            conif.memRead = 1;
            conif.alu_op = ALU_ADD;
            conif.regDst = 2'b01; //store into rt
        end
        else if (alu_g == ORI) begin
            conif.aluSrc = 1;
            conif.extop = 2'b01;
            conif.alu_op = ALU_OR;
            conif.regWr = 1;
            conif.regDst = 2'b01; //store into rt
        end
        else if (alu_g == SLTI)begin
            conif.aluSrc = 1;
            conif.extop = 2'b10;
            conif.alu_op = ALU_SLT;
            conif.regWr = 1;
            conif.regDst = 2'b01; //store into rt
        end
        else if (alu_g == SLTIU) begin
            conif.aluSrc = 1;
            conif.extop = 2'b10;
            conif.alu_op = ALU_SLTU;
            conif.regWr = 1;
            conif.regDst = 2'b01; //store into rt
        end
        else if (alu_g == SW) begin
            conif.aluSrc = 1;
            conif.memWr = 1;
            conif.alu_op = ALU_ADD;
            conif.extop = 2'b10;
        end
        
        else if (alu_g == XORI) begin
            conif.aluSrc = 1;
            conif.extop = 2'b01;
            conif.alu_op = ALU_XOR;
            conif.regWr = 1;
            conif.regDst = 2'b01; //store into rt
        end

        else if (alu_g == HALT) begin
            conif.halt = 1;
        end
        

    end

    //assign rs, rt, rd
    always_comb begin : RS_RT_RD
        conif.rt = '0;
        conif.rs = '0;
        conif.rd = '0;
        conif.imm16 = '0;
        conif.shamt = '0;
        conif.opcode = '0;
        conif.funct = '0;
        conif.addr = '0;
        if(alu_g == RTYPE)begin
            conif.rs = conif.instr[25:21];
            conif.rt = conif.instr[20:16];
            conif.rd = conif.instr[15:11];
            conif.shamt = conif.instr[10:6];
            conif.opcode = conif.instr[31:26];
            conif.funct = conif.instr[5:0];
        end
        else if(alu_g == J || alu_g == JAL)begin
            conif.rt = '0;
            conif.rs = '0;
            conif.rd = '0;
            conif.opcode = conif.instr[31:26];
            conif.addr = conif.instr[25:0];
        end
        else begin
            conif.opcode = conif.instr[31:26];
            conif.rs = conif.instr[25:21];
            conif.rt = conif.instr[20:16];
            conif.imm16 = conif.instr[15:0];
        end
    end
    
endmodule