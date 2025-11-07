// Multiplexer
module Mux (
	// Input
	input		[15:0]	iDIN,

	// Registers
	input		[15:0]	iR0,
	input		[15:0]	iR1,
	input		[15:0]	iR2,
	input		[15:0]	iR3,
	input		[15:0]	iR4,
	input		[15:0]	iR5,
	input		[15:0]	iR6,
	input		[15:0]	iR7,
	
	// ALU
	input		[15:0]	iG,

	// Control signals
	input 	[7:0]		iRout,
	input						iGout,
	input						iDINout,

	// Output
	output	[15:0]	oBus	
);

assign oBus =	( {(16){iRout[0]}} 	& iR0 ) |
							( {(16){iRout[1]}} 	& iR1 ) |
							( {(16){iRout[2]}} 	& iR2 ) |
							( {(16){iRout[3]}} 	& iR3 ) |
							( {(16){iRout[4]}} 	& iR4 ) |
							( {(16){iRout[5]}} 	& iR5 ) |
							( {(16){iRout[6]}} 	& iR6 ) |
							( {(16){iRout[7]}} 	& iR7 ) |
							( {(16){iGout}} 		& iG ) 	|
							( {(16){iDINout}} 	& iDIN );
endmodule
