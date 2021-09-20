`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, dhit, memWr, memRead;
  logic dmemREN, dmemWEN, imemREN;

  modport request (
      input ihit, dhit, memWr, memRead,
      output dmemREN, dmemWEN, imemREN
  );
  modport tb(
      input dmemREN, dmemWEN, imemREN,
      output ihit, dhit, memWr, memRead
  );

endinterface
`endif //Request unit interface