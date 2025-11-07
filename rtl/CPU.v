// Simple 16-bit CPU
module CPU (
	// Global signals
	input						ICLK,
	input						IRST_N,

	// Control
	input						IRUN,
	output					ODONE,

	// Data
	input		[15:0]	IDIN,
	output	[15:0]	OBUSWIRES
);

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Multiplexer
wire 	[7:0] 	Rout;
wire 					Gout;
wire 					DINout;

// Regs
wire 	[08:0]	IR;
wire 	[15:0]	R0;
wire 	[15:0]	R1;
wire 	[15:0]	R2;
wire 	[15:0]	R3;
wire 	[15:0]	R4;
wire 	[15:0]	R5;
wire 	[15:0]	R6;
wire 	[15:0]	R7;

// Enables
wire 					IRin;
wire 	[7:0]		Rin; 
wire					Ain; 
wire					Gin;

// ALU
wire 	[15:0]	A;
wire 	[15:0]	G;
wire					AddSub;
wire 	[15:0]	Result;

// Counter
wire 					Clear;
wire 	[1:0]		State;

/*****************************************************************************
 *                               Multiplexer                                 *
 *****************************************************************************/

Mux mux (
	// Input
	.iDIN(IDIN),
	// Regs
	.iR0(R0),
	.iR1(R1),
	.iR2(R2),
	.iR3(R3),
	.iR4(R4),
	.iR5(R5),
	.iR6(R6),
	.iR7(R7),
	// ALU
	.iG(G),
	// Control signals
	.iRout(Rout),
	.iGout(Gout),
	.iDINout(DINout),
	// Output
	.oBus(OBUSWIRES)
);

/*****************************************************************************
 *                                 Registers                                 *
 *****************************************************************************/

Reg_9 reg_ir (
	// Global signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iRin(IRin),
	.iR(IDIN[8:0]),
	// Output
	.oR(IR)
);

Reg_16 reg_r0 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[0]),
	// Output
	.oR(R0)
);

Reg_16 reg_r1 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[1]),
	// Output
	.oR(R1)
);

Reg_16 reg_r2 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[2]),
	// Output
	.oR(R2)
);

Reg_16 reg_r3 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[3]),
	// Output
	.oR(R3)
);

Reg_16 reg_r4 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[4]),
	// Output
	.oR(R4)
);

Reg_16 reg_r5 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[5]),
	// Output
	.oR(R5)
);

Reg_16 reg_r6 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[6]),
	// Output
	.oR(R6)
);

Reg_16 reg_r7 (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iR(OBUSWIRES),
	.iRin(Rin[7]),
	// Output
	.oR(R7)
);

/*****************************************************************************
 *                                   ALU                                     *
 *****************************************************************************/

Reg_16	reg_a (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iRin(Ain),
	.iR(OBUSWIRES),
	// Output
	.oR(A)
);

Reg_16	reg_g (
	// Global Signals
	.iClk(ICLK),
	.iRst_n(IRST_N),
	// Inputs
	.iRin(Gin),
	.iR(Result),
	// Output
	.oR(G)
);

//ALU
AddSub add_sub ( 
	// Inputs
	.A(A),
	.B_in(OBUSWIRES),
	// Control Signal
	.sub(AddSub),
	// Output
	.S(Result)
);

/*****************************************************************************
 *                           Finite State Machine                            *
 *****************************************************************************/

Counter_2 counter (
	// Global signals
	.clock(ICLK),
	// Control signals
	.clear(Clear),
	// Control unit
	.state(State)
);

ControlUnit control_unit (
	// Global Signals
	.iReset_n(IRST_N),
	// Control Signals
	.iRun(IRUN),
	.iIR(IR),
	.iState(State),
	.oDone(ODONE),
	.oClear(Clear),
	// Enables
	.oIRin(IRin),
	.oRin(Rin),
	// ALU
	.oAin(Ain),
	.oGin(Gin),
	.oAddSub(AddSub),
	// Muxtiplexer
	.oRout(Rout),
	.oGout(Gout),
	.oDINout(DINout)
);
endmodule
