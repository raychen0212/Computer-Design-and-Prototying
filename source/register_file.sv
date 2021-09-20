`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

module register_file (input logic CLK, nRST, register_file_if.rf rfif);
    import cpu_types_pkg::*;
    word_t [31:0] register;
    always_ff @( posedge CLK, negedge nRST) begin: REGISTER_LOGIC
        if(nRST == 0)begin
            register <= '0;
        end
        else if (rfif.wsel != '0)begin
            if(rfif.WEN)begin
                register[rfif.wsel] <= rfif.wdat;
            end

        end
        else begin
            register[rfif.wsel]='0;
        end
        
    end
    
    always_comb begin: WriteRead_Logic
        if (rfif.rsel1 == 0)begin
            rfif.rdat1 = '0;
        end
        else begin
            rfif.rdat1 = register[rfif.rsel1];
        end

        if (rfif.rsel2 == 0)begin
            rfif.rdat2 = '0;
        end
        else begin
            rfif.rdat2 = register[rfif.rsel2];
        end
    end




endmodule