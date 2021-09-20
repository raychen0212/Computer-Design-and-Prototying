`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

module request_unit (input logic CLK, input logic nRST, request_unit_if.request req);
    import cpu_types_pkg::*;
    always_ff @( posedge CLK, negedge nRST ) begin : REQUEST_UNIT_LOGIC
        if(!nRST)begin
            req.dmemREN <= '0;
            req.dmemWEN <= '0;
            req.imemREN <= 1;
        end
        else begin
            req.imemREN <= 1;
            if(req.dhit == 1) begin
                req.dmemREN <= 0;
                req.dmemWEN <= 0;
            end
            else if (req.ihit == 1) begin
                req.dmemREN <= req.memRead;
                req.dmemWEN <= req.memWr;
            end 
        end
        
    end

endmodule