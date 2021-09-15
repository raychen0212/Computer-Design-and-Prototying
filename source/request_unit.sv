`include "register_file_if.vh"
`include "request_unit_if.vh"

module request_unit(
	input logic CLK, nRST,
	request_unit_if.ru ruif
);

always_ff @(posedge CLK, negedge nRST) begin
	if(!nRST)begin
		ruif.dmemREN <= 0;
		ruif.dmemWEN <= 0;
	end
	else if(ruif.dhit)begin
		ruif.dmemREN <= 0;
		ruif.dmemWEN <= 0;
	end	
	else if(ruif.ihit)begin	
		ruif.dmemREN <= ruif.dREN;
		ruif.dmemWEN <= ruif.dWEN;
	end	
end
endmodule
