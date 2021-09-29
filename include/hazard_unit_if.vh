`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_unit_if;
	import cpu_types_pkg::*;

logic ifid_en, ifid_flush, idex_flush, exmem_flush, exmem_ZeroFlag, idex_en, idex_dWEN;

regbits_t idex_wsel, exmem_wsel, ifid_rs, ifid_rt, memwb_wsel;

logic [2:0] exmem_PCSrc, memwb_MemToReg;

modport hu(
    output ifid_flush, idex_flush, ifid_en,exmem_flush,idex_en,
    input idex_wsel, exmem_wsel, ifid_rs, ifid_rt, exmem_PCSrc,memwb_MemToReg, memwb_wsel, exmem_ZeroFlag, idex_dWEN
);

modport tb(
    input ifid_flush, idex_flush, ifid_en,exmem_flush,idex_en,
    output idex_wsel, exmem_wsel, ifid_rs, ifid_rt, exmem_PCSrc,memwb_MemToReg, memwb_wsel, exmem_ZeroFlag, idex_dWEN    
);

endinterface
`endif