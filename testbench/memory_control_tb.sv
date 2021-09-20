// mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"
//`include "cpu_tpyes_pkg.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;
  // clock
  always #(PERIOD/2) CLK++;

  // interface 
  caches_if cif0();
  caches_if cif1();
  cache_control_if ccif(cif0, cif1);
  cpu_ram_if prif();

  //Assign cpu_ram_if signals to the cache_control signals
  assign prif.ramstore = ccif.ramstore;
  assign prif.ramaddr = ccif.ramaddr;
  assign prif.ramREN = ccif.ramREN;
  assign prif.ramWEN = ccif.ramWEN;
  assign ccif.ramload = prif.ramload;
  assign ccif.ramstate = prif.ramstate;
  // test program
  test PROG (CLK, nRST, ccif);
  // DUT
`ifndef MAPPED
  memory_control DUT1(CLK, nRST, ccif);
  ram DUT2(CLK, nRST, prif);
`endif

  //Dump memory contents to file with the dump_memory task
  task automatic dump_memory();
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
  endtask


endmodule

program test(input logic CLK, output logic nRST, cache_control_if.cc ccif);
  initial begin
    //Read Instruction from RAM
    nRST = '0;
    @(negedge CLK);
    nRST = 1;
    cif0.iREN = 1'b1;
    cif0.dREN = '0;
    cif0.dWEN = '0;
    cif0.dstore = '0;
    cif0.iaddr = 32'd12;
    cif0.daddr = '0;
    @(negedge CLK);
    if (cif0.iload == ccif.iload && ccif.ramREN == 1 && ccif.ramWEN == 0 && ccif.dwait == 1 && ccif.iwait == 0 && ccif.ramaddr == cif0.iaddr && ccif.ramstore == 0)begin
        $display("Instruction Read Pass");
      end
    else begin
        $display("Instruction Read failed");
    end
    

    //Read data from RAM
    nRST = '0;
    @(negedge CLK);
    nRST = 1;
    cif0.iREN = '0;
    cif0.dREN = 1;
    cif0.dWEN = '0;
    cif0.dstore = '0;
    cif0.iaddr = '0;
    cif0.daddr = 32'd12;
    @(negedge CLK);
    if (cif0.dload == ccif.dload && ccif.ramREN == 1 && ccif.ramWEN == 0 && ccif.dwait == 0 && ccif.iwait == 1 && ccif.ramaddr == cif0.daddr && ccif.ramstore == 0)begin
        $display("DATA Read Pass");
      end
    else begin
        $display("DATA Read failed");
    end
  

    // Write Data to memory
    nRST = '0;
    @(negedge CLK);
    nRST = 1;
    cif0.iREN = '0;
    cif0.dREN = '0;
    cif0.dWEN = 1;
    cif0.dstore = 32'd223;
    cif0.iaddr = '0;
    cif0.daddr = 32'd12;
    @(negedge CLK);
    if (cif0.dload == ccif.dload && ccif.ramREN == 0 && ccif.ramWEN == 1 && ccif.dwait == 0 && ccif.iwait == 1 && ccif.ramaddr == cif0.daddr && ccif.ramstore == cif0.dstore)begin
        $display("DATA Write to Memory Pass");
      end
    else begin
        $display("DATA Write to Memory Fail");
    end

    //Read both instruction and data at the same time
    nRST = '0;
    @(negedge CLK);
    nRST = 1;
    cif0.iREN = 1;
    cif0.dREN = 1;
    cif0.dWEN = '0;
    cif0.dstore = '0;
    cif0.iaddr = 32'd15;
    cif0.daddr = 32'd12;
    @(negedge CLK);
    if (cif0.dload == ccif.dload && ccif.ramREN == 1 && ccif.ramWEN == 0 && ccif.dwait == 0 && ccif.iwait == 1 && ccif.ramaddr == cif0.daddr && ccif.ramstore == '0)begin
        $display("Read both instruction and data pass");
      end
    else begin
        $display("Read both instruction and data fail");
    end
    
    // Read instruction to address and Write data to the address
    nRST = '0;
    @(negedge CLK);
    nRST = 1;
    cif0.iREN = 1;
    cif0.dREN = '0;
    cif0.dWEN = 1;
    cif0.dstore = 32'd1234;
    cif0.iaddr = 32'd15;
    cif0.daddr = 32'd26;
    @(negedge CLK);
    if (cif0.dload == ccif.dload && ccif.ramREN == 0 && ccif.ramWEN == 1 && ccif.dwait == 0 && ccif.iwait == 1 && ccif.ramaddr == cif0.daddr && ccif.ramstore == cif0.dstore)begin
        $display("Read instruction and write data pass");
      end
    else begin
        $display("Read instruction and write data fail");
    end 
    nRST = 0;
    @(negedge CLK);
    nRST = 1;
    $display("dump memory test");
    dump_memory();
 
  end
endprogram
