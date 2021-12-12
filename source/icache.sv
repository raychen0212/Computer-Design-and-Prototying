`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module icache (input logic CLK, nRST, datapath_cache_if.icache dpif, caches_if.icache cif);
//16 bits per block
//total = 512 bits
//data = 32 bits
//tag = 26 bits
//index = 4 bits

logic hit;
logic miss;
logic [2:0]debug;

icachef_t icache_addr;
icache_frame [15:0]frame; // has 16 rows
typedef enum logic [1:0] {IDLE, LOAD} State;
State state,  nxt_state; 

assign icache_addr = icachef_t'(dpif.imemaddr);
//assign icache_addr.tag = dpif.imemaddr[31:6];
//assign icache_addr.idx = dpif.imemaddr[5:2];

assign miss = hit ? 0 : 1;

//assign hit = ((frame[icache_addr.idx].tag == icache_addr.tag) && frame[icache_addr.idx].valid && dpif.imemREN) ? 1 : 0;
assign hit = ((frame[icache_addr.idx].tag == icache_addr.tag) && frame[icache_addr.idx].valid) ? 1 : 0;
always_ff @( posedge CLK, negedge nRST ) begin : icache_ff
    if(nRST == 0)begin
        state <= IDLE;
        for (integer i = 0; i < 16; i = i + 1)begin
            frame[i] <= '0;
        end
    end
    else if(cif.iREN && ~cif.iwait) begin
        //if(cif.iREN && ~cif.iwait)begin
        state <= nxt_state;
        //frame[icache_addr.idx].valid <= valid;
        //frame[icache_addr.idx].tag <= tag;
        //frame[icache_addr.idx].data <= data;
        frame[icache_addr.idx].valid <= 1;
        frame[icache_addr.idx].tag <= icache_addr.tag;
        frame[icache_addr.idx].data <= cif.iload;
        
    end
end
always_comb begin : icache_logic
    nxt_state = state;
    dpif.ihit = '0;
    dpif.imemload = '0;
    cif.iaddr = dpif.imemaddr;
    cif.iREN = 1;
    casez (state)
        IDLE: begin
            //cif.iREN = 0;
            if(hit)begin
                debug = 3'b010;
                dpif.ihit = 1;
                dpif.imemload = frame[icache_addr.idx].data;
                nxt_state = IDLE;
            end
            else begin
                nxt_state = LOAD;
                debug = 3'b001;
                //cif.iREN = 1;
            end
        end
        LOAD: begin
            //cif.iREN = 1;
            dpif.ihit = ~cif.iwait;
            if(!cif.iwait)begin
                dpif.imemload = cif.iload;
                debug = 3'b011;
                nxt_state = IDLE;
            end
            else begin
                debug = 3'b100;
                nxt_state = LOAD;
            end
        end
    endcase
end

endmodule