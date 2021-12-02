/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  //TO RAM
  /*
  assign ccif.ramstore = ccif.dWEN ? ccif.dstore: 0;
	always_comb begin
			ccif.ramWEN = 0;
			ccif.ramREN = 0;
		if (ccif.dWEN)begin
			ccif.ramWEN = 1;
			ccif.ramREN = 0;
		end
		else if(ccif.dREN)begin
			ccif.ramWEN = 0;
			ccif.ramREN = 1;
		end
		else if(ccif.iREN)begin
			ccif.ramWEN = 0;
			ccif.ramREN = 1;
		end
	end
  //assign ccif.ramWEN = ccif.dWEN;
  //assign ccif.ramREN = ((ccif.dREN || ccif.iREN) && (!ccif.dWEN)) ? 1 : 0;
  assign ccif.ramaddr = (ccif.dWEN || ccif.dREN) ? ccif.daddr : ccif.iaddr;

  //TO CACHE
  assign ccif.dwait = ((ccif.ramstate == ACCESS) && (ccif.dREN || ccif.dWEN)) ? 0 : 1; 
  assign ccif.dload = (ccif.ramstate == ACCESS)? ccif.ramload : 0;
  assign ccif.iwait = ((ccif.ramstate == ACCESS) && (!(ccif.dREN || ccif.dWEN)) && ccif.iREN) ? 0 : 1;
  assign ccif.iload = ((ccif.ramstate == ACCESS) && ccif.iREN ) ? ccif.ramload : 0;
*/
typedef enum logic [3:0] {IDLE, ARB, SNOOP, WB1, WB2, LD1, LD2, CL1, CL2, IF}State;
State state, nxt_state;
logic nxt_cache;
logic curr_cache;
logic snoop, nxt_snoop, snoopfrom, nxt_snoopfrom;
logic index;
always_ff @( posedge CLK, negedge nRST ) begin : BUS_FF
  if(!nRST)begin
    state <= IDLE;
    curr_cache <= '0;
    snoop <= '0;
    snoopfrom <= '0;
  end
  else begin
    state <= nxt_state;
    curr_cache <= nxt_cache;
    snoop <= nxt_snoop;
    snoopfrom <= nxt_snoopfrom;
  end
end
always_comb begin : BUS_LOGIC
  nxt_state = state;
  nxt_cache = curr_cache;
  nxt_snoop = snoop;
  nxt_snoopfrom = snoopfrom;
  casez(state)
    IDLE: begin
      if(ccif.cctrans)begin
        nxt_state = ARB;
      end
      else if (ccif.dWEN) begin
        nxt_state = WB1;
      end
      else if (ccif.iREN)begin
        nxt_state = IF;
      end
      else begin
        nxt_state = IDLE;
      end
    end
    ARB: begin
      if(ccif.dREN[0])begin
        nxt_state = SNOOP;
        nxt_snoop = 0;
        nxt_snoopfrom = 1;
      end
      else if(ccif.dREN[1])begin
        nxt_state = SNOOP;
        nxt_snoop = 1;
        nxt_snoopfrom = 0;
      end
      else begin
        nxt_state = IDLE;
      end
    end
    SNOOP: begin
      if(ccif.cctrans[snoopfrom])begin //dirty, read from another cache
        nxt_state = CL1;
      end
      else if(!ccif.cctrans[snoopfrom])begin //clean, read data from memory
        nxt_state = LD1;
      end
    end
    IF: begin
      if(ccif.ramstate == ACCESS)begin
        if(ccif.cctrans != 0)begin
          nxt_cache = ~curr_cache;
          nxt_state = ARB;
        end
        else begin
          nxt_cache = ~curr_cache;
          nxt_state = IDLE;
        end
      end
      
      else begin
        nxt_state = IF;
      end
    end

    WB1: begin
      nxt_state = (ccif.ramstate == ACCESS) ? WB2 : WB1;
    end
    WB2: begin
      nxt_state = (~(ccif.dWEN)) ? IDLE : WB2;
    end

    LD1: begin
      nxt_state = (ccif.ramstate == ACCESS) ? LD2 : LD1;
    end
    LD2: begin
      nxt_state = (ccif.ramstate == ACCESS) ? IDLE: LD2;
    end
    CL1: begin
      nxt_state = (ccif.ramstate == ACCESS) ? CL2 : CL1;
    end
    CL2: begin
      nxt_state = (ccif.ramstate == ACCESS) ? IDLE : CL2;
    end

  endcase
end
assign ccif.ccinv[1] = ccif.ccwrite[0];
assign ccif.ccinv[0] = ccif.ccwrite[1];
always_comb begin : OUTPUT_LOGIC
  ccif.iwait = '1;
  ccif.dwait = '1;
  ccif.iload = '0;
  ccif.dload = '0;
  ccif.ramstore = '0;
  ccif.ramaddr = '0;
  ccif.ramREN = '0;
  ccif.ramWEN = '0;
  ccif.ccwait = '0;
  ccif.ccsnoopaddr = '0;
  index = 0;
  casez(state)
    IDLE: begin
      ccif.ccwait = '0;
    end
    ARB: begin
      ccif.ccwait[nxt_snoopfrom] = 1;
    end
    SNOOP: begin
      ccif.ccsnoopaddr[snoopfrom] = ccif.daddr[snoop];
      ccif.ccwait[snoopfrom] = 1;
    end
    IF: begin
        ccif.iload[curr_cache] = ccif.ramload;
        ccif.ramaddr = ccif.iaddr[curr_cache];
        ccif.ramREN = ccif.iREN[curr_cache]; 
        if(ccif.ramstate != ACCESS)begin
        ccif.iwait[curr_cache] = '1;
        end
        else begin
          ccif.iwait[curr_cache] = '0;
        end
        
      /*if (ccif.iREN[0])begin
        index = 0;
        ccif.iload[index] = ccif.ramload;
        ccif.ramaddr = ccif.iaddr[index];
        ccif.ramREN = ccif.iREN[index]; 
        if(ccif.ramstate != ACCESS)begin
        ccif.iwait[index] = '1;
        end
        else begin
          ccif.iwait[index] = '0;
        end
      end
      else if (ccif.iREN[1]) begin
        index = 1;
        ccif.iload[index] = ccif.ramload;
        ccif.ramaddr = ccif.iaddr[index];
        ccif.ramREN = ccif.iREN[index]; 
        if(ccif.ramstate != ACCESS)begin
        ccif.iwait[index] = '1;
        end
        else begin
          ccif.iwait[index] = '0;
        end
      end*/

      /*if(ccif.ramstate != ACCESS)begin
        ccif.iwait[index] = '1;
      end
      else begin
        ccif.iwait[index] = '0;
      end
      ccif.iload[index] = ccif.ramload;
      ccif.ramaddr = ccif.iaddr[index];
      ccif.ramREN = ccif.iREN[index]; */
    end

    WB1: begin
      if(ccif.dWEN[0])begin
        ccif.ramaddr = ccif.daddr[0];
        ccif.ramWEN = ccif.dWEN[0];
        ccif.ramstore = ccif.dstore[0];
        ccif.dwait[0] = (ccif.ramstate == ACCESS) ? 0 : 1;
        ccif.ccwait[1] = 1;
      end
      else if(ccif.dWEN[1])begin
        ccif.ramaddr = ccif.daddr[1];
        ccif.ramWEN = ccif.dWEN[1];
        ccif.ramstore = ccif.dstore[1];
        ccif.dwait[1] = (ccif.ramstate == ACCESS) ? 0 : 1;
        ccif.ccwait[0] = 0;
      end
    end

    WB2: begin
      if(ccif.dWEN[0])begin
        ccif.dload[0] = ccif.ramload;
        ccif.ramaddr = ccif.daddr[0];
        ccif.ramWEN = ccif.dWEN[0];
        ccif.ramstore = ccif.dstore[0];
        ccif.dwait[0] = (ccif.ramstate == ACCESS) ? 0 : 1;
        ccif.ccwait[1] = 1;
      end
      else if(ccif.dWEN[1])begin
        ccif.dload[1] = ccif.ramload;
        ccif.ramaddr = ccif.daddr[1];
        ccif.ramWEN = ccif.dWEN[1];
        ccif.ramstore = ccif.dstore[1];
        ccif.dwait[1] = (ccif.ramstate == ACCESS) ? 0 : 1;
        ccif.ccwait[0] = 0;
      end
    end

    LD1: begin
      ccif.dwait[snoop] = (ccif.ramstate == ACCESS) ? 0 : 1;
      ccif.dload[snoop] = ccif.ramload;
      ccif.ramaddr = ccif.daddr[snoop];
      ccif.ramREN = '1;
      ccif.ccwait[snoopfrom] = '1;
      ccif.ccsnoopaddr[snoopfrom] = ccif.daddr[snoop];
    end
    LD2: begin
      ccif.dwait[snoop] = (ccif.ramstate == ACCESS) ? 0 : 1;
      ccif.dload[snoop] = ccif.ramload;
      ccif.ramaddr = ccif.daddr[snoop];
      ccif.ramREN = '1;
      ccif.ccwait[snoopfrom] = '1;
      ccif.ccsnoopaddr[snoopfrom] = ccif.daddr[snoop];
    end

    CL1: begin
      //snoop into the cache
      ccif.dload[snoop] = ccif.dstore[snoopfrom];
      ccif.dwait[snoopfrom] = (ccif.ramstate == ACCESS) ? 0 : 1;
      ccif.dwait[snoop] = (ccif.ramstate == ACCESS) ? 0 : 1;
      //update the ram
      ccif.ramWEN = 1;
      ccif.ramaddr = ccif.daddr[snoopfrom];
      ccif.ramstore = ccif.dstore[snoopfrom];

      ccif.ccsnoopaddr[snoopfrom] = ccif.daddr[snoop];
      ccif.ccwait[snoopfrom] = '1;
    end

    CL2: begin
      ccif.dload[snoop] = ccif.dstore[snoopfrom];
      ccif.dwait[snoopfrom] = (ccif.ramstate == ACCESS) ? 0 : 1;
      ccif.dwait[snoop] = (ccif.ramstate == ACCESS) ? 0 : 1;

      ccif.ramWEN = 1;
      ccif.ramaddr = ccif.daddr[snoopfrom];
      ccif.ramstore = ccif.dstore[snoopfrom];

      ccif.ccsnoopaddr[snoopfrom] = ccif.daddr[snoop];
      ccif.ccwait[snoopfrom] = '1;
    end

  endcase
end
endmodule
