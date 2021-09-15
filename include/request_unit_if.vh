`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface request_unit_if;
	import cpu_types_pkg::*;
 
	logic ihit, dhit, dREN, dWEN, dmemREN, dmemWEN;

	modport ru(
	input ihit, dhit, dREN, dWEN,
	output dmemREN, dmemWEN
	);

	modport tb(
	output ihit, dhit, dREN, dWEN,
	input dmemREN, dmemWEN
	);

endinterface
`endif

