`include "ex_mem_if.vh"

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
            end
        end
    end
endmodule