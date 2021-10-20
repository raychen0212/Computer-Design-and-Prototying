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

//logic valid;
//logic [25:0] tag;
//logic [32:0] data;

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

assign hit = ((frame[icache_addr.idx].tag == icache_addr.tag) && frame[icache_addr.idx].valid && dpif.imemREN) ? 1 : 0;
always_ff @( posedge CLK, negedge nRST ) begin : icache_ff
    if(nRST == 0)begin
        state <= IDLE;
        for (integer i = 0; i < 16; i = i + 1)begin
            frame[i] <= '0;
        end
    end
    else begin
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
    nxt_state = IDLE;
    //valid = frame[icache_addr.idx].valid;
    //tag = frame[icache_addr.idx].tag;
    //data = frame[icache_addr.idx].data;
    dpif.ihit = '0;
    dpif.imemload = '0;
    cif.iaddr = dpif.imemaddr;
    cif.iREN = 1;
    casez (state)
        IDLE: begin
            if(hit)begin
                debug = 3'b010;
                dpif.ihit = hit;
                dpif.imemload = frame[icache_addr.idx].data;
                nxt_state = IDLE;
            end
            else begin
                nxt_state = LOAD;
                debug = 3'b001;
                
                //cif.iaddr = '0;
                //cif.iREN = '0;
            end
        end
        LOAD: begin
            //valid = 1;
            //tag = icache_addr.tag;
            //data = cif.iload;
            
            if(!cif.iwait)begin
                dpif.ihit = ~cif.iwait;
                dpif.imemload = cif.iload;
                debug = 3'b011;
                //dpif.ihit = 0;
                nxt_state = IDLE;
            end
            //cif.iaddr = dpif.imemaddr;
            //cif.iREN = 1;
            else begin
                debug = 3'b100;
                nxt_state = LOAD;
            end
        end
    endcase
end

endmodule