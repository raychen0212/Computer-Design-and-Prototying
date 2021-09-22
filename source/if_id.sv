`include "if_id_if.vh"
module if_id (input logic CLK, input logic nRST, if_id_if.ifid ifidif);
    always_ff @( posedge CLK, negedge nRST ) begin : IF_ID_PIPELINE
        if(!nRST)begin
            ifidif.instr_o <= '0;
            ifidif.pc4_o <= '0;
        end
        else begin
            if (ifidif.flush == 1)begin
                ifidif.instr_o <= '0;
                ifidif.pc4_o <= '0;
            end
            else if(ifidif.en == 1)begin
                ifidif.instr_o <= ifidif.instr_i;
                ifidif.pc4_o <= ifidif.pc4_i;
            end
            else begin
                ifidif.instr_o <= ifidif.instr_o;
                ifidif.pc4_o <= ifidif.pc4_o;
            end
        end
    end
    
endmodule