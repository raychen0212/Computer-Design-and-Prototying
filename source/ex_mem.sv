`include "ex_mem_if.vh"
import cpu_types_pkg::*;
module ex_mem (input logic CLK, input logic nRST, ex_mem_if.exmem exmemif);
    always_ff @( posedge CLK, negedge nRST ) begin : EX_MEM_BLOCK
        if(!nRST)begin
            exmemif.rdat2_o = '0;
            exmemif.imm_o = '0;
            exmemif.pc4_o = '0;
            exmemif.jaddr_o = '0;
            exmemif.branchaddr_o = '0;
            exmemif.OutputPort_o = '0;
            exmemif.wsel_o = '0;
            exmemif.RegWr_o = '0;
            exmemif.halt_o = '0;
            exmemif.dREN_o = '0;
            exmemif.dWEN_o = '0;
            exmemif.ZeroFlag_o = '0;
            exmemif.MemToReg_o = '0;
            exmemif.PCsrc_o = '0;
            exmemif.stopread_o = '0;
            exmemif.pc_o <= '0;
            exmemif.next_pc_o <= '0;
            exmemif.instr_o <= '0;
            exmemif.lui_imm_o <= '0;
            exmemif.funct_o <= funct_t'('0);
            exmemif.opcode_o <= opcode_t'('0);
            exmemif.rs_o <= '0;
            exmemif.rt_o <= '0;
            exmemif.wdat_o = 0;
            exmemif.rd_o <= '0;
            exmemif.rdat1_o = '0;
        end
        else begin
            if(exmemif.flush == 1)begin
                exmemif.rdat2_o = '0;
                exmemif.imm_o = '0;
                exmemif.pc4_o = '0;
                exmemif.jaddr_o = '0;
                exmemif.branchaddr_o = '0;
                exmemif.OutputPort_o = '0;
                exmemif.wsel_o = '0;
                exmemif.RegWr_o = '0;
                exmemif.halt_o = '0;
                exmemif.dREN_o = '0;
                exmemif.dWEN_o = '0;
                exmemif.ZeroFlag_o = '0;
                exmemif.MemToReg_o = '0;
                exmemif.PCsrc_o = '0;
                exmemif.stopread_o = '0;
                exmemif.pc_o <= '0;
                exmemif.next_pc_o <= '0;
                exmemif.instr_o <= '0;
                exmemif.lui_imm_o <= '0;
                exmemif.funct_o <= funct_t'('0);
                exmemif.opcode_o <= opcode_t'('0); 
                exmemif.rs_o <= '0;
                exmemif.rt_o <= '0;
                exmemif.wdat_o = 0;
                exmemif.rd_o <= '0;
                exmemif.rdat1_o = '0;
            end
            else if(exmemif.en == 1)begin
                exmemif.rdat2_o = exmemif.rdat2_i;
                exmemif.imm_o = exmemif.imm_i;
                exmemif.pc4_o = exmemif.pc4_i;
                exmemif.jaddr_o = exmemif.jaddr_i;
                exmemif.branchaddr_o = exmemif.branchaddr_i;
                exmemif.OutputPort_o = exmemif.OutputPort_i;
                exmemif.wsel_o = exmemif.wsel_i;
                exmemif.RegWr_o = exmemif.RegWr_i;
                exmemif.halt_o = exmemif.halt_i;
                exmemif.dREN_o = exmemif.dREN_i;
                exmemif.dWEN_o = exmemif.dWEN_i;
                exmemif.ZeroFlag_o = exmemif.ZeroFlag_i;
                exmemif.MemToReg_o = exmemif.MemToReg_i;
                exmemif.PCsrc_o = exmemif.PCsrc_i;
                exmemif.stopread_o = exmemif.stopread_i;
                exmemif.pc_o <= exmemif.pc_i;
                exmemif.next_pc_o <= exmemif.next_pc_i;
                exmemif.instr_o <= exmemif.instr_i;
                exmemif.lui_imm_o <= exmemif.lui_imm_i;
                exmemif.funct_o <= exmemif.funct_i;
                exmemif.opcode_o <= exmemif.opcode_i; 
                exmemif.rs_o <= exmemif.rs_i;
                exmemif.rt_o <= exmemif.rt_i;
                exmemif.wdat_o = exmemif.wdat_i;
                exmemif.rd_o <= exmemif.rd_i;
                exmemif.rdat1_o = exmemif.rdat1_i;
            end
            else begin
                exmemif.rdat2_o = exmemif.rdat2_o;
                exmemif.imm_o = exmemif.imm_o;
                exmemif.pc4_o = exmemif.pc4_o;
                exmemif.jaddr_o = exmemif.jaddr_o;
                exmemif.branchaddr_o = exmemif.branchaddr_o;
                exmemif.OutputPort_o = exmemif.OutputPort_o;
                exmemif.wsel_o = exmemif.wsel_o;
                exmemif.RegWr_o = exmemif.RegWr_o;
                exmemif.halt_o = exmemif.halt_o;
                exmemif.dREN_o = exmemif.dREN_o;
                exmemif.dWEN_o = exmemif.dWEN_o;
                exmemif.ZeroFlag_o = exmemif.ZeroFlag_o;
                exmemif.MemToReg_o = exmemif.MemToReg_o;
                exmemif.PCsrc_o = exmemif.PCsrc_o;
                exmemif.stopread_o = exmemif.stopread_o;
                exmemif.pc_o <= exmemif.pc_o;
                exmemif.next_pc_o <= exmemif.next_pc_o;
                exmemif.instr_o <= exmemif.instr_o;
                exmemif.lui_imm_o <= exmemif.lui_imm_o;
                exmemif.funct_o <= exmemif.funct_o;
                exmemif.opcode_o <= exmemif.opcode_o; 
                exmemif.rs_o <= exmemif.rs_o;
                exmemif.rt_o <= exmemif.rt_o; 
                exmemif.wdat_o = exmemif.wdat_o;
                exmemif.rd_o <= exmemif.rd_o; 
                exmemif.rdat1_o = exmemif.rdat1_o;
            end
        end
    end
endmodule