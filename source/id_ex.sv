`include "id_ex_if.vh"
`include "control_unit_if.vh"
module id_ex (input logic CLK, input logic nRST, id_ex_if.idex idexif);
import cpu_types_pkg::*;
    always_ff @( posedge CLK, negedge nRST ) begin : ID_EX_PIPELINE
        if(!nRST)begin
            idexif.rdat1_o <= '0;
            idexif.rdat2_o <= '0;
            idexif.imm_o <= '0;
            idexif.pc4_o <= '0;
            idexif.jaddr_o <= '0;
            idexif.rd_o <= '0;
            idexif.rs_o <= '0;
            idexif.rt_o <= '0;
            idexif.RegWr_o <= '0;
            idexif.halt_o <= '0;
            idexif.ALUsrc_o <= '0;
            idexif.dREN_o <= '0;
            idexif.dWEN_o <= '0;
            idexif.RegDst_o <= '0;
            idexif.MemToReg_o <= '0;
            idexif.PCsrc_o <= '0;
            idexif.ExtOp_o <= '0;
            idexif.ALUOp_o <= ALU_SLL;
            idexif.stopread_o <= '0;
            idexif.pc_o <= '0;
            idexif.next_pc_o <= '0;
            idexif.instr_o <= '0;
            idexif.lui_imm_o <= '0;
            idexif.funct_o <= funct_t'('0);
            idexif.opcode_o <= opcode_t'('0);
            idexif.wdat_o = 0;
        end
        else begin
            if (idexif.flush == 1)begin
                idexif.rdat1_o <= '0;
                idexif.rdat2_o <= '0;
                idexif.imm_o <= '0;
                idexif.pc4_o <= '0;
                idexif.jaddr_o <= '0;
                idexif.rd_o <= '0;
                idexif.rs_o <= '0;
                idexif.rt_o <= '0;
                idexif.RegWr_o <= '0;
                idexif.halt_o <= '0;
                idexif.ALUsrc_o <= '0;
                idexif.dREN_o <= '0;
                idexif.dWEN_o <= '0;
                idexif.RegDst_o <= '0;
                idexif.MemToReg_o <= '0;
                idexif.PCsrc_o <= '0;
                idexif.ExtOp_o <= '0;
                idexif.ALUOp_o <= ALU_SLL;   
                idexif.stopread_o <= '0;   
                idexif.pc_o <= '0;
                idexif.next_pc_o <= '0;
                idexif.instr_o <= '0;
                idexif.lui_imm_o <= '0;
                idexif.funct_o <= funct_t'('0);
                idexif.opcode_o <= opcode_t'('0);   
                idexif.wdat_o = 0;   
            end
            else if(idexif.en == 1)begin
                idexif.rdat1_o <= idexif.rdat1_i;
                idexif.rdat2_o <= idexif.rdat2_i;
                idexif.imm_o <= idexif.imm_i;
                idexif.pc4_o <= idexif.pc4_i;
                idexif.jaddr_o <= idexif.jaddr_i;
                idexif.rd_o <= idexif.rd_i;
                idexif.rs_o <= idexif.rs_i;
                idexif.rt_o <= idexif.rt_i;
                idexif.RegWr_o <= idexif.RegWr_i;
                idexif.halt_o <= idexif.halt_i;
                idexif.ALUsrc_o <= idexif.ALUsrc_i;
                idexif.dREN_o <= idexif.dREN_i;
                idexif.dWEN_o <= idexif.dWEN_i;
                idexif.RegDst_o <= idexif.RegDst_i;
                idexif.MemToReg_o <= idexif.MemToReg_i;
                idexif.PCsrc_o <= idexif.PCsrc_i;
                idexif.ExtOp_o <= idexif.ExtOp_i;
                idexif.ALUOp_o <= idexif.ALUOp_i;   
                idexif.stopread_o <= idexif.stopread_i;  
                idexif.pc_o <= idexif.pc_i;
                idexif.next_pc_o <= idexif.next_pc_i;
                idexif.instr_o <= idexif.instr_i;
                idexif.lui_imm_o <= idexif.lui_imm_i;
                idexif.funct_o <= idexif.funct_i;
                idexif.opcode_o <= idexif.opcode_i; 
                idexif.wdat_o = idexif.wdat_i;  
            end
            else begin
                idexif.rdat1_o <= idexif.rdat1_o;
                idexif.rdat2_o <= idexif.rdat2_o;
                idexif.imm_o <= idexif.imm_o;
                idexif.pc4_o <= idexif.pc4_o;
                idexif.jaddr_o <= idexif.jaddr_o;
                idexif.rd_o <= idexif.rd_o;
                idexif.rs_o <= idexif.rs_o;
                idexif.rt_o <= idexif.rt_o;
                idexif.RegWr_o <= idexif.RegWr_o;
                idexif.halt_o <= idexif.halt_o;
                idexif.ALUsrc_o <= idexif.ALUsrc_o;
                idexif.dREN_o <= idexif.dREN_o;
                idexif.dWEN_o <= idexif.dWEN_o;
                idexif.RegDst_o <= idexif.RegDst_o;
                idexif.MemToReg_o <= idexif.MemToReg_o;
                idexif.PCsrc_o <= idexif.PCsrc_o;
                idexif.ExtOp_o <= idexif.ExtOp_o;
                idexif.ALUOp_o <= idexif.ALUOp_o; 
                idexif.stopread_o <= idexif.stopread_o; 
                idexif.pc_o <= idexif.pc_o;
                idexif.next_pc_o <= idexif.next_pc_o;
                idexif.instr_o <= idexif.instr_o;
                idexif.lui_imm_o <= idexif.lui_imm_o;
                idexif.funct_o <= idexif.funct_o;
                idexif.opcode_o <= idexif.opcode_o;   
                idexif.wdat_o = idexif.wdat_o;
            end
        end
    end
    
endmodule