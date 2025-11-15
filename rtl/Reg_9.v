// Register 9-bit
module Reg_9 (
	// Global signals
	input 							iClk,

	// Inputs
	input 							iRin, 		// Write enable
	input 			[8:0]		iR,

	// Output
	output reg 	[8:0] 	oR
);

always @(posedge iClk) begin
	if (iRin)
		oR <= iR;
end
endmodule