// 16-bit Register
module Reg_16 (
	// Global signals
	input 							iClk,
	input 							iRst_n,

	// Inputs
	input 							iRin, 		// Write enable
	input 			[15:0]	iR,

	// Output
	output reg 	[15:0] 	oR
);

always @(posedge iClk) begin
	if(!iRst_n)
		oR <= 16'b0;
	else if (iRin)
		oR <= iR;
end
endmodule
