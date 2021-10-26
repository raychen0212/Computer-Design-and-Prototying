`include "hazard_unit_if.vh"

module hazard_unit(
	hazard_unit_if.hu huif
);

always_comb begin 
//Data Hazard
huif.ifid_en = 1;
huif.idex_en = 1;
huif.exmem_en = 1;
huif.ifid_flush = 0;
huif.idex_flush = 0;
huif.exmem_flush = 0;
huif.memwb_flush = 0;

if((huif.exmem_dREN || huif.exmem_dWEN) && !huif.dhit)begin //exmem conflict with idex
   huif.ifid_en = 0;
   huif.idex_en = 0;
   huif.exmem_en = 0;
   huif.memwb_flush = 1;
end

/*
if((huif.idex_wsel == huif.ifid_rs || huif.idex_wsel == huif.ifid_rt)&& huif.idex_wsel != 0 && huif.idex_dREN)begin //exmem conflict with idex
   huif.ifid_en = 0;
   huif.idex_flush = 1;
end


//else 
else if ((huif.exmem_wsel == huif.ifid_rs || huif.exmem_wsel == huif.ifid_rt)&& huif.exmem_wsel != 0 && huif.exmem_dREN)begin //exmem conflict with ifid
   huif.ifid_en = 0;
    //huif.idex_en = 0;
   huif.idex_flush = 1;
end


else if((huif.memwb_wsel == huif.ifid_rs || huif.memwb_wsel == huif.ifid_rt )&& huif.memwb_wsel != 0 && huif.memwb_dREN)begin
    huif.ifid_en = 0;
    //huif.idex_en = 0;
    huif.idex_flush = 1;
end
*/

//jump/branch
if (huif.exmem_PCSrc == 2'b01 || huif.exmem_PCSrc == 2'b11 || (huif.exmem_PCSrc == 2'b10 && huif.exmem_ZeroFlag) || (huif.exmem_PCSrc == 3'b110 && !huif.exmem_ZeroFlag))begin
    huif.ifid_flush = 1;
    //huif.ifid_en = 0;
    huif.idex_flush = 1;
    //huif.idex_en = 0;
    huif.exmem_flush = 1;
end
end

endmodule