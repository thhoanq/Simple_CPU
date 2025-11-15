// Register 16-bit
module Reg_16 (
	// Global signals
	input 							iClk,

	// Inputs
	input 							iRin, 		// Write enable
	input 			[15:0]	iR,

	// Output
	output reg 	[15:0] 	oR
);

always @(posedge iClk) begin
	if (iRin)
		oR <= iR;
end
endmodule
