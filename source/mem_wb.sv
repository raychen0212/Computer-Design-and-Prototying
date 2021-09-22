`include "mem_wb_if.vh"
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
            end
        end
    end
endmodule