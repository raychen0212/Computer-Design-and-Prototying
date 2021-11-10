`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"
import cpu_types_pkg::*;
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface
	caches_if cif0();
	caches_if cif1();
  cache_control_if #(.CPUS(2)) ccif(cif0, cif1);
	cpu_ram_if crif();
  // test program
  test PROG (CLK, nRST,ccif);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
  
`else
  memory_control DUT(
		.\CLK (CLK),
		.\nRST (nRST),
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),
    .\ccif.ramload (ccif.ramload),
    .\ccif.dstore (ccif.dstore),
	.\ccif.cctrans(ccif.cctrans),
	.\ccif.ccwrite(ccif.ccwrite),
	.\ccif.ccinv(ccif.ccinv),
	.\ccif.ccsnoopaddr(ccif.ccsnoopaddr),

    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),
  );
  
`endif

`ifndef MAPPED
  ram DUT2(CLK, nRST, crif);

`else
  ram DUT2(
		.\CLK (CLK),
		.\nRST (nRST),
		.\crif.ramWEN (crif.ramWEN),
		.\crif.ramREN (crif.ramREN),
		.\crif.ramstore (crif.ramstore),
		.\crif.ramaddr (crif.ramaddr),
		.\crif.ramload (crif.ramload),
		.\crif.ramstate (crif.ramstate),
	);
	
`endif
//Connection
assign crif.ramWEN = ccif.ramWEN;
assign crif.ramREN = ccif.ramREN;
assign crif.ramstore = ccif.ramstore;
assign crif.ramaddr = ccif.ramaddr;
//assign ccif.ramload = crif.ramload;
//assign ccif.ramstate = crif.ramstate;
endmodule

program test(
	input logic CLK, 
	output logic nRST, 
	cache_control_if.cc ccif
);
parameter PERIOD = 10;
initial begin
	int testnum;
	ccif.ramload = 32'd12341234;
	$display("Test Case 1: Reset");
	nRST = '0;
	cif0.iaddr = 0;
	cif0.daddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.iREN = 0;
	cif0.dstore = 0;
	cif0.ccwrite = 0;
	cif0.cctrans = 0;
	cif1.iaddr = 0;
	cif1.daddr = 0;
	cif1.dWEN = 0;
	cif1.dREN = 0;
	cif1.iREN = 0;
	cif1.dstore = 0;
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	ccif.ramstate = BUSY;
	testnum = 1;
	#(PERIOD * 10);
	@(posedge CLK)
	$display("Test case 2: Check instruction fetch");
	//IDLE
	nRST = 1;
	testnum = 2;
	cif0.iREN = 1;
	@(posedge CLK)
	//IF
	cif0.iREN = 1;
	cif0.cctrans = 0;
	cif0.iaddr = 32'd12;
	ccif.ramstate = ACCESS;
	
	//IDLE
	@(posedge CLK)

	@(posedge CLK)
	nRST = 0;
	cif0.iaddr = 0;
	cif0.daddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.iREN = 0;
	cif0.dstore = 0;
	cif0.ccwrite = 0;
	cif0.cctrans = 0;
	cif1.iaddr = 0;
	cif1.daddr = 0;
	cif1.dWEN = 0;
	cif1.dREN = 0;
	cif1.iREN = 0;
	cif1.dstore = 0;
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	ccif.ramstate = BUSY;
	@(posedge CLK)
	nRST = 1;
	$display("Test Case 3: Snoop clean, read from RAM");
	//IDLE
	testnum = 3;
	@(posedge CLK)
	cif0.cctrans = '1;
	@(posedge CLK)
	//ARB
	cif0.dREN = 1;
	cif0.daddr = 32'd12;
	@(posedge CLK)
	//SNOOP
	cif1.ccwrite = 1;
	cif1.cctrans = 0;
	@(posedge CLK)
	//LD1
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	cif0.cctrans = 0;
	cif0.dREN = 0;
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	//LD2
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	@(posedge CLK)
	@(posedge CLK)
	nRST = '0;
	cif0.iaddr = 0;
	cif0.daddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.iREN = 0;
	cif0.dstore = 0;
	cif0.ccwrite = 0;
	cif0.cctrans = 0;
	cif1.iaddr = 0;
	cif1.daddr = 0;
	cif1.dWEN = 0;
	cif1.dREN = 0;
	cif1.iREN = 0;
	cif1.dstore = 0;
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	ccif.ramstate = BUSY;
	@(posedge CLK)
	nRST = 1;
	$display("Test Case 4: Check write back value");
	//IDLE
	testnum = 4;
	@(posedge CLK)
	cif0.dWEN = 1;
	@(posedge CLK)
	//WB1
	cif0.dstore = 2'b10;
	cif0.daddr = 32'd12;
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	//WB2
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	nRST = '0;
	cif0.iaddr = 0;
	cif0.daddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.iREN = 0;
	cif0.dstore = 0;
	cif0.ccwrite = 0;
	cif0.cctrans = 0;
	cif1.iaddr = 0;
	cif1.daddr = 0;
	cif1.dWEN = 0;
	cif1.dREN = 0;
	cif1.iREN = 0;
	cif1.dstore = 0;
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	ccif.ramstate = BUSY;
	@(posedge CLK)
	nRST = '1;
	$display("Test Case 5: Check for Ram CL section");
	//IDLE
	testnum = 5;
	@(posedge CLK)
	cif0.cctrans = 1;
	@(posedge CLK)
	//ARB
	cif0.dREN = 1;
	cif0.daddr = 32'd12;
	@(posedge CLK)
	//SNOOP
	cif0.ccwrite = 1;
	cif1.cctrans = 1;
	@(posedge CLK)
	//CL1
	cif1.dstore = 32'd1234;
	cif1.daddr = 32'd12;
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	//CL2
	ccif.ramstate = ACCESS;
	@(posedge CLK)

	nRST = '0;
	cif0.iaddr = 0;
	cif0.daddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.iREN = 0;
	cif0.dstore = 0;
	cif0.ccwrite = 0;
	cif0.cctrans = 0;
	cif1.iaddr = 0;
	cif1.daddr = 0;
	cif1.dWEN = 0;
	cif1.dREN = 0;
	cif1.iREN = 0;
	cif1.dstore = 0;
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	ccif.ramstate = BUSY;
	@(posedge CLK)
	nRST = 1;
	@(posedge CLK)
	@(posedge CLK)
	@(posedge CLK)
	$display("Test Case 6: m to s");
	//IDLE
	testnum = 6;
	@(posedge CLK)
	cif0.cctrans = 1;
	@(posedge CLK)
	//ARB
	cif0.dREN = 1;
	cif0.daddr = 32'd12;
	@(posedge CLK)
	//SNOOP
	cif0.ccwrite = 0;
	cif1.cctrans = 1;
	@(posedge CLK)
	//CL1
	cif1.dstore = 32'd1234;
	cif1.daddr = 32'd12;
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	//CL2
	ccif.ramstate = ACCESS;
	@(posedge CLK)
	@(posedge CLK)
	nRST = '0;
	cif0.iaddr = 0;
	cif0.daddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.iREN = 0;
	cif0.dstore = 0;
	cif0.ccwrite = 0;
	cif0.cctrans = 0;
	cif1.iaddr = 0;
	cif1.daddr = 0;
	cif1.dWEN = 0;
	cif1.dREN = 0;
	cif1.iREN = 0;
	cif1.dstore = 0;
	cif1.ccwrite = 0;
	cif1.cctrans = 0;
	ccif.ramstate = BUSY;
	$finish;
end

/*task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask*/
endprogram
