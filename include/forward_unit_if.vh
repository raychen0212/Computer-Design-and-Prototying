`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface forward_unit_if;
	import cpu_types_pkg::*;



regbits_t idex_rs, idex_rt, exmem_wsel, memwb_wsel;
logic [1:0] forward_1, forward_2;
logic exmem_dmemren, exmem_dmemwen, exmem_RegWr, memwb_RegWr;


modport fu(
    output forward_1, forward_2,
    input idex_rs, idex_rt, exmem_wsel, memwb_wsel,
          exmem_dmemren, exmem_dmemwen, exmem_RegWr, memwb_RegWr
);

modport tb(
    input forward_1, forward_2,
    output idex_rs, idex_rt, exmem_wsel, memwb_wsel,
           exmem_dmemren, exmem_dmemwen, exmem_RegWr, memwb_RegWr
);

endinterface
`endif