// 9-bit Register
module Reg_9 (
	// Global signals
	input 							iClk,
	input 							iRst_n,

	// Inputs
	input 							iRin, 		// Write enable
	input 			[8:0]		iR,

	// Output
	output reg 	[8:0] 	oR
);

always @(posedge iClk) begin
	if(!iRst_n)
		oR <= 9'b0;
	else if (iRin)
		oR <= iR;
end
endmodule