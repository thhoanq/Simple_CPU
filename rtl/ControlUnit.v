// Control Unit based on Counter and Decoder
module ControlUnit (
	// Global signals
	input					iReset_n,

	// Control signals
	input					iRun,
	input		[8:0]	iIR,
	input		[1:0]	iState,
	output				oDone,
	output				oClear,

	// Enable signals
	output				oIRin,
	output	[7:0]	oRin,

	// ALU
	output				oAin,
	output				oGin,
	output				oAddSub,

	// Multiplexer
	output				oGout,
	output	[7:0]	oRout,
	output				oDINout
);

// Function register
wire	[2:0] I;
wire	[2:0] X;
wire	[2:0] Y;

// State
wire			ST0, ST1, ST2, ST3;

// Register
wire			I0, I1, I2, I3;

// Conditions
wire			Rin_cond;
wire			RoutX_cond, RoutY_cond;

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

assign I = iIR[8:6];	//instruction
assign X = iIR[5:3];	//destination
assign Y = iIR[2:0];	//source

// State (2-to-4 decoder)
assign ST0 = ~iState[1] & ~iState[0];
assign ST1 = ~iState[1] &  iState[0];
assign ST2 =  iState[1] & ~iState[0];
assign ST3 =  iState[1] &  iState[0];

// Register (2-to-4 decoder)
assign I0 = ~I[2]	&	~I[1]	&	~I[0]; // mv
assign I1 = ~I[2]	&	~I[1]	&	 I[0]; // load
assign I2 = ~I[2]	&	 I[1]	&	~I[0]; // add
assign I3 = ~I[2]	&	 I[1]	&	 I[0]; // sub

// Addresses (3-to-8 decoder)
assign X0 = ~X[2] & ~X[1] & ~X[0];
assign X1 = ~X[2] & ~X[1] &  X[0];
assign X2 = ~X[2] &  X[1] & ~X[0];
assign X3 = ~X[2] &  X[1] &  X[0];
assign X4 =  X[2] & ~X[1] & ~X[0];
assign X5 =  X[2] & ~X[1] &  X[0];
assign X6 =  X[2] &  X[1] & ~X[0];
assign X7 =  X[2] &  X[1] &  X[0];
assign Y0 = ~Y[2] & ~Y[1] & ~Y[0];
assign Y1 = ~Y[2] & ~Y[1] &  Y[0];
assign Y2 = ~Y[2] &  Y[1] & ~Y[0];
assign Y3 = ~Y[2] &  Y[1] &  Y[0];
assign Y4 =  Y[2] & ~Y[1] & ~Y[0];
assign Y5 =  Y[2] & ~Y[1] &  Y[0];
assign Y6 =  Y[2] &  Y[1] & ~Y[0];
assign Y7 =  Y[2] &  Y[1] &  Y[0];

/*****************************************************************************
 *                             Control Outputs                               *
 *****************************************************************************/

assign oClear 	= ~iReset_n | oDone | (~iRun & ST0);
assign oIRin 		= iRun & ST0;
assign oDINout	= I1 & ST1;
assign oDone		= Rin_cond;

assign oAin 		= (I2 | I3) & ST1;
assign oGin			= (I2 | I3) & ST2;
assign oGout		= (I2 | I3) & ST3;
assign oAddSub	= I3 & ST2;

assign Rin_cond	= ((I0 | I1) & ST1) | ((I2 | I3) & ST3);
assign oRin[0]	= X0 & Rin_cond;
assign oRin[1]	= X1 & Rin_cond;
assign oRin[2]	= X2 & Rin_cond;
assign oRin[3]	= X3 & Rin_cond;
assign oRin[4]	= X4 & Rin_cond;
assign oRin[5]	= X5 & Rin_cond;
assign oRin[6]	= X6 & Rin_cond;
assign oRin[7]	= X7 & Rin_cond;

assign RoutX_cond	= (I2 | I3) & ST1;
assign RoutY_cond = (I0 & ST1) | ((I2 | I3) & ST2);
assign oRout[0] 	= (X0 & RoutX_cond) | (Y0 & RoutY_cond);
assign oRout[1] 	= (X1 & RoutX_cond) | (Y1 & RoutY_cond);
assign oRout[2] 	= (X2 & RoutX_cond) | (Y2 & RoutY_cond);
assign oRout[3] 	= (X3 & RoutX_cond) | (Y3 & RoutY_cond);
assign oRout[4] 	= (X4 & RoutX_cond) | (Y4 & RoutY_cond);
assign oRout[5] 	= (X5 & RoutX_cond) | (Y5 & RoutY_cond);
assign oRout[6] 	= (X6 & RoutX_cond) | (Y6 & RoutY_cond);
assign oRout[7] 	= (X7 & RoutX_cond) | (Y7 & RoutY_cond);
endmodule
