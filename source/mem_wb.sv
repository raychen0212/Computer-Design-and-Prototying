`include "mem_wb_if.vh"
import cpu_types_pkg::*;
module mem_wb (input logic CLK, input logic nRST, mem_wb_if.memwb memwbif);
    always_ff @( posedge CLK, negedge nRST ) begin : MEM_WB_BLOCK
        if(!nRST)begin
            memwbif.imm_o = '0;
            memwbif.pc4_o = '0;
            memwbif.OutputPort_o = '0;
            memwbif.dmemload_o = '0;
            memwbif.wsel_o = '0;
            memwbif.RegWr_o = '0;
            memwbif.halt_o = '0;
            memwbif.MemToReg_o = '0;
            //memwbif.PCsrc_o = '0;
            memwbif.stopread_o = '0;
            memwbif.pc_o <= '0;
            memwbif.next_pc_o <= '0;
            memwbif.instr_o <= '0;
            memwbif.lui_imm_o <= '0;
            memwbif.funct_o <= funct_t'('0);
            memwbif.opcode_o <= opcode_t'('0);
            memwbif.rs_o <= '0;
            memwbif.rt_o <= '0;
            memwbif.branchaddr_o <= '0;
            memwbif.rdat2_o <= '0;
            memwbif.wdat_o = 0;
            memwbif.rd_o <= '0;
            memwbif.dREN_o <= 0;
        end
        else begin
            if(memwbif.flush == 1)begin
                memwbif.imm_o = '0;
                memwbif.pc4_o = '0;
                memwbif.OutputPort_o = '0;
                memwbif.dmemload_o = '0;
                memwbif.wsel_o = '0;
                memwbif.RegWr_o = '0;
                memwbif.halt_o = '0;
                memwbif.MemToReg_o = '0;
                //memwbif.PCsrc_o = '0;
                memwbif.stopread_o = '0;
                memwbif.pc_o <= '0;
                memwbif.next_pc_o <= '0;
                memwbif.instr_o <= '0;
                memwbif.lui_imm_o <= '0;
                memwbif.funct_o <= funct_t'('0);
                memwbif.opcode_o <= opcode_t'('0); 
                memwbif.rs_o <= '0;
                memwbif.rt_o <= '0;
                memwbif.branchaddr_o <= '0;
                memwbif.rdat2_o <= '0;
                memwbif.wdat_o = 0;
                memwbif.rd_o <= '0;
                memwbif.dREN_o <= 0;
            end
            else if(memwbif.en == 1)begin
                memwbif.imm_o = memwbif.imm_i;
                memwbif.pc4_o = memwbif.pc4_i;
                memwbif.OutputPort_o = memwbif.OutputPort_i;
                memwbif.dmemload_o = memwbif.dmemload_i;
                memwbif.wsel_o = memwbif.wsel_i;
                memwbif.RegWr_o = memwbif.RegWr_i;
                memwbif.halt_o = memwbif.halt_i;
                memwbif.MemToReg_o = memwbif.MemToReg_i;
                //memwbif.PCsrc_o = memwbif.PCsrc_i;
                memwbif.stopread_o = memwbif.stopread_i;
                memwbif.pc_o <= memwbif.pc_i;
                memwbif.next_pc_o <= memwbif.next_pc_i;
                memwbif.instr_o <= memwbif.instr_i;
                memwbif.lui_imm_o <= memwbif.lui_imm_i;
                memwbif.funct_o <= memwbif.funct_i;
                memwbif.opcode_o <= memwbif.opcode_i; 
                memwbif.rs_o <= memwbif.rs_i;
                memwbif.rt_o <= memwbif.rt_i;
                memwbif.branchaddr_o <= memwbif.branchaddr_i;
                memwbif.rdat2_o <= memwbif.rdat2_i;
                memwbif.wdat_o = memwbif.wdat_i;
                memwbif.rd_o <= memwbif.rd_i;
                memwbif.dREN_o <= memwbif.dREN_i;
            end
            else begin
                memwbif.imm_o = memwbif.imm_o;
                memwbif.pc4_o = memwbif.pc4_o;
                memwbif.OutputPort_o = memwbif.OutputPort_o;
                memwbif.dmemload_o = memwbif.dmemload_o;
                memwbif.wsel_o = memwbif.wsel_o;
                memwbif.RegWr_o = memwbif.RegWr_o;
                memwbif.halt_o = memwbif.halt_o;
                memwbif.MemToReg_o = memwbif.MemToReg_o;
                //memwbif.PCsrc_o = memwbif.PCsrc_o;
                memwbif.stopread_o = memwbif.stopread_o;
                memwbif.pc_o <= memwbif.pc_o;
                memwbif.next_pc_o <= memwbif.next_pc_o;
                memwbif.instr_o <= memwbif.instr_o;
                memwbif.lui_imm_o <= memwbif.lui_imm_o;
                memwbif.funct_o <= memwbif.funct_o;
                memwbif.opcode_o <= memwbif.opcode_o; 
                memwbif.rs_o <= memwbif.rs_o;
                memwbif.rt_o <= memwbif.rt_o; 
                memwbif.branchaddr_o <= memwbif.branchaddr_o;
                memwbif.rdat2_o <= memwbif.rdat2_o;
                memwbif.wdat_o = memwbif.wdat_o;
                memwbif.rd_o <= memwbif.rd_o;
                memwbif.dREN_o <= memwbif.dREN_o;
            end
        end
    end
endmodule