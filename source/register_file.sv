`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

//import register_file_if::*
import cpu_types_pkg::*;

module register_file
(
  input logic CLK, nRST,
  register_file_if.rf rfif
);

word_t [31:0] reg_map ;


always_ff@(negedge CLK, negedge nRST)begin
  if(!nRST)begin
    reg_map <= '0;
  end
  else if(rfif.WEN && rfif.wsel)begin
    reg_map[rfif.wsel] = rfif.wdat;
  end

end

always_comb begin
  rfif.rdat1 = reg_map[rfif.rsel1];
  rfif.rdat2 = reg_map[rfif.rsel2];
end

endmodule
