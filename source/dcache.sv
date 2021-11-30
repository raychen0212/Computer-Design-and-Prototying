`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module dcache (input logic CLK, nRST, datapath_cache_if.dcache dpif, caches_if.dcache cif);

//16 bits per block
//total = 1024 bits
//two way associative, two words per block
//data = 32 bits
//tag = 25 bits
//index = 3 bits
//blockoffset = 2 bits
typedef struct packed {
	dcache_frame left;
    dcache_frame right;
} twoway_dcache;

logic [25:0] left_tag, right_tag;
logic left_dirty, right_dirty, left_valid, right_valid, link_valid, next_link_valid;
word_t left_data0, left_data1, right_data0, right_data1, link_reg, next_link_reg;

dcachef_t dcache_addr;
twoway_dcache [7:0]frame; // has 8 rows

typedef enum logic [3:0] {ACCESS, WB0, WB1, MEM0, MEM1, FLUSH_CNT, FLUSH0, FLUSH1, HCTR, HALT, SNOOPCHECK, SNOOP_SHARE1, SNOOP_SHARE2} State;
State state,  next_state; 

logic recent[7:0], next_recent[7:0]; //0 for left, 1 for right
word_t hit_counter, next_hit_counter; 
logic [4:0] flush_count, next_flush_count;
logic [2:0] flush_index;
logic ind;
assign dcache_addr = dcachef_t'(dpif.dmemaddr);
//Deal with cc signal/////////////////
//assign cif.ccwrite = dcif.dmemWEN;
logic [25:0] snooptag;
logic [2:0] snoopidx;
logic snoopoff;
assign snooptag = cif.ccsnoopaddr[31:6];
assign snoopidx = cif.ccsnoopaddr[5:3];
assign snoopoff = cif.ccsnoopaddr[2];
////////////////////////////////////
always_ff @( posedge CLK, negedge nRST ) begin : dcache_ff
    if(nRST == 0)begin
        state <= ACCESS;
        for (int i = 0; i < 8; i = i + 1)begin
            frame[i] <= '0;
            recent[i] <= 0;
        end
        hit_counter <= 0;
        flush_count <= 0;
        link_reg <= '0;
        link_valid <= 0;
    end
    else if (ind)begin
        state <= next_state;
        frame[snoopidx].left.valid <= left_valid;
        frame[snoopidx].left.dirty <= left_dirty;
        frame[snoopidx].left.tag <= left_tag;
        frame[snoopidx].left.data[0] <= left_data0;
        frame[snoopidx].left.data[1] <= left_data1;

        frame[snoopidx].right.valid <= right_valid;
        frame[snoopidx].right.dirty <= right_dirty;
        frame[snoopidx].right.tag <= right_tag;
        frame[snoopidx].right.data[0] <= right_data0;
        frame[snoopidx].right.data[1] <= right_data1;

        hit_counter <= next_hit_counter;
        flush_count <= next_flush_count;
        link_reg <= next_link_reg;
        link_valid <= next_link_valid;
        for (int i = 0; i < 8; i = i + 1)begin
            recent[i] <= next_recent[i];
        end
    end
    else begin
        state <= next_state;
        frame[dcache_addr.idx].left.valid <= left_valid;
        frame[dcache_addr.idx].left.dirty <= left_dirty;
        frame[dcache_addr.idx].left.tag <= left_tag;
        frame[dcache_addr.idx].left.data[0] <= left_data0;
        frame[dcache_addr.idx].left.data[1] <= left_data1;

        frame[dcache_addr.idx].right.valid <= right_valid;
        frame[dcache_addr.idx].right.dirty <= right_dirty;
        frame[dcache_addr.idx].right.tag <= right_tag;
        frame[dcache_addr.idx].right.data[0] <= right_data0;
        frame[dcache_addr.idx].right.data[1] <= right_data1;

        hit_counter <= next_hit_counter;
        flush_count <= next_flush_count;
        link_reg <= next_link_reg;
        link_valid <= next_link_valid;
        for (int i = 0; i < 8; i = i + 1)begin
            recent[i] <= next_recent[i];
        end
    end
end

always_comb begin
    next_state = state;
    next_flush_count = flush_count;
    next_hit_counter = hit_counter;
    for (int i = 0; i < 8; i = i + 1)begin
        next_recent[i] = recent[i];
    end
    left_valid = frame[dcache_addr.idx].left.valid;
    left_dirty = frame[dcache_addr.idx].left.dirty;
    left_tag = frame[dcache_addr.idx].left.tag;
    left_data0 = frame[dcache_addr.idx].left.data[0];
    left_data1 = frame[dcache_addr.idx].left.data[1];

    right_valid = frame[dcache_addr.idx].right.valid;
    right_dirty = frame[dcache_addr.idx].right.dirty;
    right_tag = frame[dcache_addr.idx].right.tag;
    right_data0 = frame[dcache_addr.idx].right.data[0];
    right_data1 = frame[dcache_addr.idx].right.data[1];
    dpif.dhit = 0;
    dpif.flushed = 0;
    dpif.dmemload = 0;

    cif.dREN = 0;
    cif.dWEN = 0;
    cif.dstore = 0;
    cif.daddr = 0;
    flush_index = 0;
    ind = 0;
    //cc signal
    cif.cctrans = '0;
    cif.ccwrite = dpif.dmemWEN;
    next_link_reg = link_reg;
    next_link_valid = link_valid;

    case(state)
        ACCESS:begin
            if (cif.ccwait)begin
                    next_state = SNOOPCHECK;
                    //cif.cctrans = (frame[snoopidx].right.dirty || frame[snoopidx].left.dirty);
            end 
            ///////////////////////////////////////////////Read/////////////////////////////////////////////////////////////////
            else if (~cif.ccwait && dpif.dmemREN)begin //read hit
                    /////////LL/////
                    if (dpif.datomic)begin
                        next_link_reg = dpif.dmemaddr;
                        next_link_valid = 1;
                    end
                    if((dcache_addr.tag == frame[dcache_addr.idx].left.tag) && frame[dcache_addr.idx].left.valid)begin
                        dpif.dhit = 1;
                        if (dcache_addr.blkoff == 1)begin
                            dpif.dmemload = frame[dcache_addr.idx].left.data[1];                
                        end
                        else if (dcache_addr.blkoff == 0)begin
                            dpif.dmemload = frame[dcache_addr.idx].left.data[0];                
                        end
                        next_hit_counter = hit_counter + 1;
                        next_recent[dcache_addr.idx] = 0;
                    end 
                    else if ((dcache_addr.tag == frame[dcache_addr.idx].right.tag) && frame[dcache_addr.idx].right.valid)begin
                        dpif.dhit = 1;
                        if (dcache_addr.blkoff == 1)begin
                            dpif.dmemload = frame[dcache_addr.idx].right.data[1];                
                        end
                        else if (dcache_addr.blkoff == 0)begin
                            dpif.dmemload = frame[dcache_addr.idx].right.data[0];                
                        end
                        next_hit_counter = hit_counter + 1;
                        next_recent[dcache_addr.idx] = 1;
                    end 
                    else begin //miss logic
                        next_hit_counter = hit_counter - 1;
                        if (recent[dcache_addr.idx] == 0)begin//left recent
                            if(frame[dcache_addr.idx].right.dirty)begin
                                next_state = WB0;
                                cif.cctrans = 0;
                            end
                            else begin
                                next_state = MEM0;
                                cif.cctrans = 1;
                            end
                        end
                        else if (recent[dcache_addr.idx] == 1)begin//right recent
                            if(frame[dcache_addr.idx].left.dirty)begin
                                next_state = WB0;
                                cif.cctrans = 0;
                            end
                            else begin
                                next_state = MEM0;
                                cif.cctrans = 1;
                            end
                        end
                    end
                    
            end
///////////////////////////////////////////////WRITE//////////////////////////////////////////////////////////////////
            else if (~cif.ccwait && dpif.dmemWEN)begin 
                if(dpif.datomic)begin///SC check & store
                    if ((dpif.dmemaddr == link_reg) && link_valid)begin
                        dpif.dmemload = 1;
                        if((dcache_addr.tag == frame[dcache_addr.idx].left.tag)&& frame[dcache_addr.idx].left.valid)begin//hit
                            dpif.dhit = 1;
                            left_dirty = 1;
                            //cif.cctrans = 1;
                            if (dcache_addr.blkoff == 1)begin
                                left_data1 = dpif.dmemstore;               
                            end
                            else if (dcache_addr.blkoff == 0)begin
                                left_data0 = dpif.dmemstore;                
                            end
                            next_hit_counter = hit_counter + 1;
                            next_recent[dcache_addr.idx] = 0;
                            next_link_reg = 0;
                            next_link_valid = 0;
                        end 
                        else if ((dcache_addr.tag == frame[dcache_addr.idx].right.tag)&& frame[dcache_addr.idx].right.valid)begin
                            dpif.dhit = 1;
                            right_dirty = 1;
                            //cif.cctrans = 1;
                            if (dcache_addr.blkoff == 1)begin
                                right_data1 = dpif.dmemstore;               
                            end
                            else if (dcache_addr.blkoff == 0)begin
                                right_data0 = dpif.dmemstore;                
                            end
                            next_hit_counter = hit_counter + 1;
                            next_recent[dcache_addr.idx] = 1;
                            next_link_reg = 0;
                            next_link_valid = 0;
                        end
                    
                        else begin //miss logic
                            next_hit_counter = hit_counter - 1;
                            if (recent[dcache_addr.idx] == 0)begin//left recent
                                if(frame[dcache_addr.idx].right.dirty)begin
                                    next_state = WB0;   
                                    cif.cctrans = 0;                 
                                end
                                else begin
                                    next_state = MEM0;
                                    cif.cctrans = 1;
                                end
                            end
                            else if (recent[dcache_addr.idx] == 1)begin//right recent
                                if(frame[dcache_addr.idx].left.dirty)begin
                                    next_state = WB0;
                                    cif.cctrans = 0; 
                                end
                                else begin
                                    next_state = MEM0;
                                    cif.cctrans = 1; 
                                end
                            end
                        end
                    end

                    else begin//check fail
                        dpif.dmemload = 0;
                        dpif.dhit = 1;
                    end


                end

                else begin////regular SW
                    if (cif.ccsnoopaddr == link_reg)begin
                        next_link_reg = 0;
                        next_link_valid = 0;
                    end
                    if((dcache_addr.tag == frame[dcache_addr.idx].left.tag)&& frame[dcache_addr.idx].left.valid)begin
                        dpif.dhit = 1;
                        left_dirty = 1;
                        //cif.cctrans = 1;
                        if (dcache_addr.blkoff == 1)begin
                            left_data1 = dpif.dmemstore;               
                        end
                        else if (dcache_addr.blkoff == 0)begin
                            left_data0 = dpif.dmemstore;                
                        end
                        next_hit_counter = hit_counter + 1;
                        next_recent[dcache_addr.idx] = 0;
                    end 
                    else if ((dcache_addr.tag == frame[dcache_addr.idx].right.tag)&& frame[dcache_addr.idx].right.valid)begin
                        dpif.dhit = 1;
                        right_dirty = 1;
                        //cif.cctrans = 1;
                        if (dcache_addr.blkoff == 1)begin
                            right_data1 = dpif.dmemstore;               
                        end
                        else if (dcache_addr.blkoff == 0)begin
                            right_data0 = dpif.dmemstore;                
                        end
                        next_hit_counter = hit_counter + 1;
                        next_recent[dcache_addr.idx] = 1;
                    end
                
                    else begin //miss logic
                        next_hit_counter = hit_counter - 1;
                        if (recent[dcache_addr.idx] == 0)begin//left recent
                            if(frame[dcache_addr.idx].right.dirty)begin
                                next_state = WB0;   
                                cif.cctrans = 0;                 
                            end
                            else begin
                                next_state = MEM0;
                                cif.cctrans = 1;
                            end
                        end
                        else if (recent[dcache_addr.idx] == 1)begin//right recent
                            if(frame[dcache_addr.idx].left.dirty)begin
                                next_state = WB0;
                                cif.cctrans = 0; 
                            end
                            else begin
                                next_state = MEM0;
                                cif.cctrans = 1; 
                            end
                        end
                    end
                end
            end  



            else if (dpif.halt)begin //flush
                    next_state = FLUSH_CNT;
                    next_hit_counter = hit_counter;
            end                    
            
        end

        SNOOPCHECK:begin
            if (cif.ccwait && snooptag == frame[snoopidx].right.tag)begin
                if (frame[snoopidx].right.dirty)begin
                    next_state = SNOOP_SHARE1;
                    cif.cctrans = 1;
                end
                else if (cif.ccinv && !frame[snoopidx].right.dirty)begin
                    right_valid = 0;
                    right_dirty = 0;
                    right_tag = 0;
                    right_data0 = 0;
                    right_data1 = 0;
                    next_state = ACCESS;
                    ind = 1;
                    //cif.cctrans = 1;
                end
            end
            else if (cif.ccwait && snooptag == frame[snoopidx].left.tag )begin
                if (frame[snoopidx].left.dirty)begin
                    next_state = SNOOP_SHARE1;
                    cif.cctrans = 1;
                end
                else if (cif.ccinv && !frame[snoopidx].left.dirty)begin
                    left_valid = 0;
                    left_dirty = 0;
                    left_tag = 0;
                    left_data0 = 0;
                    left_data1 = 0;
                    next_state = ACCESS;
                    ind = 1;
                    //cif.cctrans = 1;
                end
            end

            else begin
                cif.cctrans = 0;
                next_state = ACCESS;
            end
        end

        SNOOP_SHARE1:begin
            if (snooptag == frame[snoopidx].left.tag)begin
                cif.dstore = frame[snoopidx].left.data[0];
                cif.daddr = {frame[snoopidx].left.tag, snoopidx,1'b0,2'b00};
                //cif.ramstore = frame[snoopidx].left.data[0];
                //cif.ramaddr = {frame[dcache_addr.idx].left.tag, dcache_addr.idx,1'b0,2'b00};
            end
            else if (snooptag == frame[snoopidx].right.tag)begin
                cif.dstore = frame[snoopidx].right.data[0];
                cif.daddr = {frame[snoopidx].right.tag, snoopidx,1'b0,2'b00};
                //cif.ramstore = frame[snoopidx].right.data[0];
                //cif.ramaddr = {frame[dcache_addr.idx].right.tag, dcache_addr.idx,1'b0,2'b00};
            end
            if (~cif.dwait)begin
                next_state = SNOOP_SHARE2;
            end
        end

        SNOOP_SHARE2:begin
            if (snooptag == frame[snoopidx].left.tag)begin
                cif.dstore = frame[snoopidx].left.data[1];
                cif.daddr = {frame[snoopidx].left.tag, snoopidx,1'b1,2'b00};
                //cif.ramstore = frame[snoopidx].left.data[0];
                //cif.ramaddr = {frame[dcache_addr.idx].left.tag, dcache_addr.idx,1'b1,2'b00};
                if (~cif.dwait)begin
                next_state = ACCESS;
                if(cif.ccinv)begin
                    right_valid = 0;
                    right_dirty = 0;
                    right_tag = 0;
                    right_data0 = 0;
                    right_data1 = 0;
                end
                end
            end
            else if (snooptag == frame[snoopidx].right.tag)begin
                cif.dstore = frame[snoopidx].right.data[1];
                cif.daddr = {frame[snoopidx].right.tag, snoopidx,1'b1,2'b00};
                //cif.ramstore = frame[snoopidx].right.data[0];
                //cif.ramaddr = {frame[dcache_addr.idx].right.tag, dcache_addr.idx,1'b1,2'b00};
                if (~cif.dwait)begin
                next_state = ACCESS;
                if(cif.ccinv)begin
                    right_valid = 0;
                    right_dirty = 0;
                    right_tag = 0;
                    right_data0 = 0;
                    right_data1 = 0;
                end
                end
                
            end
            //if (~cif.dwait)begin
            //    next_state = ACCESS;
            //end
        end
        
        WB0:begin
            if (recent[dcache_addr.idx] == 1)begin//left
                cif.daddr = {frame[dcache_addr.idx].left.tag, dcache_addr.idx,1'b0,2'b00};
                cif.dstore = frame[dcache_addr.idx].left.data[0];
            end
            else if(recent[dcache_addr.idx] == 0)begin//right
                cif.daddr = {frame[dcache_addr.idx].right.tag, dcache_addr.idx,1'b0,2'b00};
                cif.dstore = frame[dcache_addr.idx].right.data[0];
            end
            if (~cif.dwait)begin//next state logic  
                next_state = WB1;
            end
            cif.dWEN = 1;
        end

        WB1:begin
            if (recent[dcache_addr.idx] == 1)begin//left
                cif.daddr = {frame[dcache_addr.idx].left.tag, dcache_addr.idx,1'b1,2'b00};
                cif.dstore = frame[dcache_addr.idx].left.data[1];
            end
            else if(recent[dcache_addr.idx] == 0)begin//right
                cif.daddr = {frame[dcache_addr.idx].right.tag, dcache_addr.idx,1'b1,2'b00};
                cif.dstore = frame[dcache_addr.idx].right.data[1];
            end
            if (~cif.dwait)begin//next state logic
                next_state = MEM0;
            end
            cif.dWEN = 1;
        end

        MEM0:begin
            cif.daddr = {dcache_addr.tag, dcache_addr.idx, 1'b0,2'b00};
            if (recent[dcache_addr.idx] == 1)begin//left
                left_data0 = cif.dload;
                
            end
            else if(recent[dcache_addr.idx] == 0)begin//right
                right_data0 = cif.dload;
                
            end
            if (~cif.dwait)begin//next state logic
                next_state = MEM1;
            end
            if (cif.ccwait)begin
                next_state = SNOOPCHECK;
            end
            cif.dREN = 1;
            cif.cctrans = !cif.ccwait;
        end

        MEM1:begin
            cif.daddr = {dcache_addr.tag, dcache_addr.idx, 1'b1,2'b00};
            if (recent[dcache_addr.idx] == 1)begin//left
                left_data1 = cif.dload;
                left_tag = dcache_addr.tag;
                left_dirty = 0;
                left_valid = 1;
                if (~cif.dwait)begin
                next_recent[dcache_addr.idx] = 0;
                end
            end
            else if(recent[dcache_addr.idx] == 0)begin//right
                right_data1 = cif.dload;
                right_tag = dcache_addr.tag;
                right_dirty = 0;
                right_valid = 1;
                if (~cif.dwait)begin
                next_recent[dcache_addr.idx] = 1;
                end
                
            end
            if (~cif.dwait)begin//next state logic
                next_state = ACCESS;
            end
            cif.dREN = 1;
        end

        FLUSH_CNT:begin
            if (flush_count == 16)begin
                        next_state = HCTR;
            end

            else if (flush_count < 8)begin
                if (frame[flush_count].left.dirty )begin
                        next_state = FLUSH0;
                end
                else begin
                        next_state = FLUSH_CNT;
                end
                next_flush_count = flush_count + 1;
            end

            else if (flush_count > 7)begin
                if ( frame[flush_count - 8].right.dirty)begin
                        next_state = FLUSH0;
                end
                else begin
                        next_state = FLUSH_CNT;
                end
                next_flush_count = flush_count + 1;
            end
            if(cif.ccwait)begin
                next_state = SNOOPCHECK;
                next_flush_count = flush_count;
            end
            
        end

        FLUSH0:begin
            if ((flush_count < 9) && frame[flush_count-1].left.dirty )begin
                flush_index = flush_count[3:0] - 1;
                cif.daddr = {frame[flush_index].left.tag, flush_index,1'b0,2'b00};
                cif.dstore = frame[flush_index].left.data[0];
            end
            else if ((flush_count > 8) && frame[flush_count-9].right.dirty)begin
                flush_index = flush_count[4:0] - 9;
                cif.daddr = {frame[flush_index].right.tag, flush_index,1'b0,2'b00};
                cif.dstore = frame[flush_index].right.data[0];
            end

            if(cif.ccwait)begin
                next_state = SNOOPCHECK;
                next_flush_count = flush_count - 1;
            end
            else if (~cif.dwait)begin//next state logic
                next_state = FLUSH1;
            end
            
            cif.dWEN = 1;
        end

        FLUSH1:begin
            
            if ((flush_count < 9) && frame[flush_count-1].left.dirty )begin
                flush_index = flush_count[3:0] - 1;
                cif.daddr = {frame[flush_index].left.tag, flush_index,1'b1,2'b00};
                cif.dstore = frame[flush_index].left.data[1];
            end
            else if ((flush_count > 8) && frame[flush_count-9].right.dirty)begin
                flush_index = flush_count[4:0] - 9;
                cif.daddr = {frame[flush_index].right.tag, flush_index,1'b1,2'b00};
                cif.dstore = frame[flush_index].right.data[1];
            end
            
            if(cif.ccwait)begin
                next_state = SNOOPCHECK;
                next_flush_count = flush_count;
            end
            else if (~cif.dwait)begin//next state logic
                next_state = FLUSH_CNT;
            end
            
            cif.dWEN = 1;
        end

        HCTR:begin
            //cif.dWEN = 1;
            //cif.daddr = 32'h3100;
            //cif.dstore = hit_counter;
            dpif.flushed = 1;
            /*if (~cif.dwait)begin//next state logic
                next_state = HALT;
            end*/
        end
        HALT: dpif.flushed = 1;
    endcase
end


endmodule