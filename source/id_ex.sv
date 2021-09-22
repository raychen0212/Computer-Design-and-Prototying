`include "id_ex_if.vh"
module if_id (input logic CLK, input logic nRST, id_ex_if.idex idexif);
    always_ff @( posedge CLK, negedge nRST ) begin : ID_EX_PIPELINE
        if(!nRST)begin
            idexif.rdat1_o = '0;
            idexif.rdat2_o = '0;
            idexif.imm_o = '0;
            idexif.pc4_o = '0;
            idexif.jaddr_o = '0;
            idexif.rd_o = '0;
            //idexif.rs_o = '0;
            idexif.rt_o = '0;
            idexif.RegWr_o = '0;
            idexif.halt_o = '0;
            idexif.ALU_src_o = '0;
            idexif.dREN_o = '0;
            idexif.dWEN_o = '0;
            idexif.RegDst_o = '0;
            idexif.MemToReg_o = '0;
            idexif.PCsrc = '0;
            idexif.ALUOp_o = '0;

        end
        else begin
            if (ifidif.flush == 1)begin
                idexif.rdat1_o = '0;
                idexif.rdat2_o = '0;
                idexif.imm_o = '0;
                idexif.pc4_o = '0;
                idexif.jaddr_o = '0;
                idexif.rd_o = '0;
                //idexif.rs_o = '0;
                idexif.rt_o = '0;
                idexif.RegWr_o = '0;
                idexif.halt_o = '0;
                idexif.ALU_src_o = '0;
                idexif.dREN_o = '0;
                idexif.dWEN_o = '0;
                idexif.RegDst_o = '0;
                idexif.MemToReg_o = '0;
                idexif.PCsrc = '0;
                idexif.ALUOp_o = '0;            
            end
            else if(ifidif.en == 1)begin
                idexif.rdat1_o = idexif.rdat1_i;
                idexif.rdat2_o = idexif.rdat2_i;
                idexif.imm_o = idexif.imm_i;
                idexif.pc4_o = idexif.pc4_i;
                idexif.jaddr_o = idexif.jaddr_i;
                idexif.rd_o = idexif.rd_i;
                //idexif.rs_o = idexif.rs_i;
                idexif.rt_o = idexif.rt_i;
                idexif.RegWr_o = idexif.RegWr_i;
                idexif.halt_o = idexif.halt_i;
                idexif.ALUsrc_o = idexif.ALUsrc_i;
                idexif.dREN_o = idexif.dREN_i;
                idexif.dWEN_o = idexif.dWEN_i;
                idexif.RegDst_o = idexif.RegDst_i;
                idexif.MemToReg_o = idexif.MemToReg_i;
                idexif.PCsrc_o = idexif.PCsrc_i;
                idexif.ALUOp_o = idexif.ALUOp_i;        
            end
            else begin
                idexif.rdat1_o = idexif.rdat1_o;
                idexif.rdat2_o = idexif.rdat2_o;
                idexif.imm_o = idexif.imm_o;
                idexif.pc4_o = idexif.pc4_o;
                idexif.jaddr_o = idexif.jaddr_o;
                idexif.rd_o = idexif.rd_o;
                //idexif.rs_o = idexif.rs_o;
                idexif.rt_o = idexif.rt_o;
                idexif.RegWr_o = idexif.RegWr_o;
                idexif.halt_o = idexif.halt_o;
                idexif.ALUsrc_o = idexif.ALUsrc_o;
                idexif.dREN_o = idexif.dREN_o;
                idexif.dWEN_o = idexif.dWEN_o;
                idexif.RegDst_o = idexif.RegDst_o;
                idexif.MemToReg_o = idexif.MemToReg_o;
                idexif.PCsrc_o = idexif.PCsrc_o;
                idexif.ALUOp_o = idexif.ALUOp_o;    
            end
        end
    end
    
endmodule