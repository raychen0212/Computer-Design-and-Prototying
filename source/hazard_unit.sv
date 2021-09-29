`include "hazard_unit_if.vh"

module hazard_unit(
	hazard_unit_if.hu huif
);

always_comb begin 
//Data Hazard
huif.ifid_en = 1;
huif.idex_en = 1;
huif.ifid_flush = 0;
huif.idex_flush = 0;
huif.exmem_flush = 0;

if((huif.idex_wsel == huif.ifid_rs || huif.idex_wsel == huif.ifid_rt )&& huif.idex_wsel != 0 && !huif.idex_dWEN)begin //exmem conflict with idex
    huif.ifid_en = 0;
   huif.idex_en = 0;
   huif.idex_flush = 1;
end
else if ((huif.exmem_wsel == huif.ifid_rs || huif.exmem_wsel == huif.ifid_rt)&& huif.exmem_wsel != 0 && !huif.idex_dWEN)begin //exmem conflict with ifid
   huif.ifid_en = 0; 
    huif.idex_en = 0;
    huif.idex_flush = 1;
end
/*else if ((huif.memwb_wsel == huif.ifid_rs || huif.memwb_wsel == huif.ifid_rt)&& huif.exmem_wsel != 0 && !huif.idex_dWEN)begin //exmem conflict with ifid
   huif.ifid_en = 0; 
end*/
//lui
else if((huif.memwb_wsel == huif.ifid_rs || huif.memwb_wsel == huif.ifid_rt )&& huif.memwb_wsel != 0 && !huif.idex_dWEN)begin
    huif.ifid_en = 0;
    huif.idex_en = 0;
    huif.idex_flush = 1;
end

//jump/branch
if (huif.exmem_PCSrc == 2'b01 || (huif.exmem_PCSrc == 2'b10 && huif.exmem_ZeroFlag) || (huif.exmem_PCSrc == 3'b110 && !huif.exmem_ZeroFlag))begin
    huif.ifid_flush = 1;
    //huif.ifid_en = 0;
    huif.idex_flush = 1;
    //huif.idex_en = 0;
    huif.exmem_flush = 1;
end
end

endmodule