`include "forward_unit_if.vh"

module forward_unit (forward_unit_if.fu fuif);
    
    always_comb begin : FORWARD_LOGIC
        fuif.forward_1 = '0; //assign 0 just set rdat1 
        fuif.forward_2 = '0;
        if(fuif.memwb_RegWr == 1)begin
            if(fuif.memwb_wsel != 0)begin
                if(fuif.memwb_wsel == fuif.idex_rs)begin //assign 1 mean to send wdat value
                    fuif.forward_1 = 2'b1;
                end
                else if(fuif.memwb_wsel == fuif.idex_rt)begin
                    fuif.forward_2 = 2'b1;
                end
            end
        end
        if (fuif.exmem_RegWr == 1) begin
            if (fuif.exmem_wsel != 0)begin
                if(fuif.exmem_wsel == fuif.idex_rs)begin // assign 2 mean to send exmemoutput value
                    fuif.forward_1 = 2'b10;
                end
                else if(fuif.exmem_wsel == fuif.idex_rt)begin
                    fuif.forward_2 = 2'b10;
                end
            end
        end
    end
endmodule