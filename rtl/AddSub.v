// AddSub with 5-block Carry Select Adder (CSA) architecture 
module AddSub (
	// Inputs
	input		[15:0]	A,
	input 	[15:0]	B_in,		// input from BusWire
	
	// Control Signal
	input 					sub,
	
	// Output
	output 	[15:0]	S
);
	
wire				Cout_1; 							// Cout_#block
wire				Cout_2;
wire				Cout_3;
wire 				Cout_4;
wire				Cout_5;

wire				Cout_2_0; 						// Cout_#block_(carry_in?)
wire				Cout_2_1;
wire				Cout_3_0;
wire				Cout_3_1;
wire				Cout_4_0;
wire				Cout_4_1;

wire				Cout_2_0_temp;				// Cout_#block_(carry_in?)_temp
wire				Cout_2_1_temp;
wire				Cout_3_0_temp;
wire				Cout_3_1_temp;
wire				Cout_4_0_temp;
wire				Cout_4_1_temp;
wire				Cout_5_0_temp;
wire				Cout_5_1_temp;


wire [1:0]	S_temp_2_0;						// [#bit] Sum_temp_#block_(carry_in?)
wire [1:0]	S_temp_2_1;

wire [2:0]	S_temp_3_0;
wire [2:0]	S_temp_3_1;
 
wire [3:0]	S_temp_4_0;
wire [3:0]	S_temp_4_1;

wire [4:0]	S_temp_5_0;
wire [4:0]	S_temp_5_1;

wire [15:0]	B;

assign	B[0] = B_in[0] ^ sub;
assign	B[1] = B_in[1] ^ sub;
assign	B[2] = B_in[2] ^ sub;
assign	B[3] = B_in[3] ^ sub;
assign	B[4] = B_in[4] ^ sub;
assign	B[5] = B_in[5] ^ sub;
assign	B[6] = B_in[6] ^ sub;
assign	B[7] = B_in[7] ^ sub;
assign	B[8] = B_in[8] ^ sub;
assign	B[9] = B_in[9] ^ sub;
assign	B[10] = B_in[10] ^ sub;
assign	B[11] = B_in[11] ^ sub;
assign	B[12] = B_in[12] ^ sub;
assign	B[13] = B_in[13] ^ sub;
assign	B[14] = B_in[14] ^ sub;
assign	B[15] = B_in[15] ^ sub;

// Block 1
double_fa db_fa_1_0 (
	.A		(A[1:0]),
	.B		(B[1:0]),
	.Cin	(sub),
	.S		(S[1:0]),
	.Cout	(Cout_1)
);

// Block 2
fa_0 fa0_2_0 (
	.in_x				(A[2]),
	.in_y				(B[2]),
	.sum_out		(S_temp_2_0[0]),
	.carry_out	(Cout_2_0_temp)
);

fa fa_2_0 (
	.in_x				(A[3]),
	.in_y				(B[3]),
	.carry_in		(Cout_2_0_temp),
	.sum_out		(S_temp_2_0[1]),
	.carry_out	(Cout_2_0)
);

fa_1 fa1_2_0 (
	.in_x				(A[2]),
	.in_y				(B[2]),
	.sum_out		(S_temp_2_1[0]),
	.carry_out	(Cout_2_1_temp)
);

fa fa_2_1 (
	.in_x				(A[3]),
	.in_y				(B[3]),
	.carry_in		(Cout_2_1_temp),
	.sum_out		(S_temp_2_1[1]),
	.carry_out	(Cout_2_1)
);

assign 	S[2]	= 	(Cout_1) ? S_temp_2_1[0] : S_temp_2_0[0];
assign 	S[3]	= 	(Cout_1) ? S_temp_2_1[1] : S_temp_2_0[1];
assign 	Cout_2	= 	(Cout_1) ? Cout_2_1  : Cout_2_0;

// Block 3
fa_0 fa0_3_0 (
	.in_x				(A[4]),
	.in_y				(B[4]),
	.sum_out		(S_temp_3_0[0]),
	.carry_out	(Cout_3_0_temp)
);

double_fa db_fa_3_0 (
	.A			(A[6:5]),
	.B			(B[6:5]),
	.Cin		(Cout_3_0_temp),
	.S			(S_temp_3_0[2:1]),
	.Cout		(Cout_3_0)
);

fa_1 fa1_3_0 (
	.in_x				(A[4]),
	.in_y				(B[4]),
	.sum_out		(S_temp_3_1[0]),
	.carry_out	(Cout_3_1_temp)
);

double_fa db_fa_3_1 (
	.A			(A[6:5]),
	.B			(B[6:5]),
	.Cin		(Cout_3_1_temp),
	.S			(S_temp_3_1[2:1]),
	.Cout		(Cout_3_1)
);

assign 	S[4]	= 	(Cout_2) ? S_temp_3_1[0] : S_temp_3_0[0];
assign 	S[5]	= 	(Cout_2) ? S_temp_3_1[1] : S_temp_3_0[1];
assign 	S[6]	= 	(Cout_2) ? S_temp_3_1[2] : S_temp_3_0[2];

assign 	Cout_3	= 	(Cout_2) ? Cout_3_1  : Cout_3_0;

// Block 4
fa_0 fa0_4_0 (
	.in_x				(A[7]),
	.in_y				(B[7]),
	.sum_out		(S_temp_4_0[0]),
	.carry_out	(Cout_4_0_temp)
);

triple_fa trip_fa_3_0 (
	.A			(A[10:8]),
	.B			(B[10:8]),
	.Cin		(Cout_4_0_temp),
	.S			(S_temp_4_0[3:1]),
	.Cout		(Cout_4_0)
);

fa_1 fa1_4_0(
	.in_x				(A[7]),
	.in_y				(B[7]),
	.sum_out		(S_temp_4_1[0]),
	.carry_out	(Cout_4_1_temp)
);

triple_fa trip_fa_3_1 (
	.A			(A[10:8]),
	.B			(B[10:8]),
	.Cin		(Cout_4_1_temp),
	.S			(S_temp_4_1[3:1]),
	.Cout		(Cout_4_1)
);

assign 	S[7]	= 	(Cout_3) ? S_temp_4_1[0] : S_temp_4_0[0];
assign 	S[8]	= 	(Cout_3) ? S_temp_4_1[1] : S_temp_4_0[1];
assign 	S[9]	= 	(Cout_3) ? S_temp_4_1[2] : S_temp_4_0[2];
assign 	S[10]	= 	(Cout_3) ? S_temp_4_1[3] : S_temp_4_0[3];

assign 	Cout_4	= 	(Cout_3) ? Cout_4_1  : Cout_4_0;

// Block 5
fa_0 fa0_5_0 (
	.in_x				(A[11]),
	.in_y				(B[11]),
	.sum_out		(S_temp_5_0[0]),
	.carry_out	(Cout_5_0_temp)
);

quad_fa quad_fa_5_0 (
	.A			(A[15:12]),
	.B			(B[15:12]),
	.Cin		(Cout_5_0_temp),
	.S			(S_temp_5_0[4:1])
);

fa_1 fa1_5_0 (
	.in_x		(A[11]),
	.in_y		(B[11]),
	.sum_out	(S_temp_5_1[0]),
	.carry_out	(Cout_5_1_temp)
);

quad_fa quad_fa_5_1 (
	.A			(A[15:12]),
	.B			(B[15:12]),
	.Cin		(Cout_5_1_temp),
	.S			(S_temp_5_1[4:1])
);

assign 	S[11]	= 	(Cout_4) ? S_temp_5_1[0] : S_temp_5_0[0];
assign 	S[12]	= 	(Cout_4) ? S_temp_5_1[1] : S_temp_5_0[1];
assign 	S[13]	= 	(Cout_4) ? S_temp_5_1[2] : S_temp_5_0[2];
assign 	S[14]	= 	(Cout_4) ? S_temp_5_1[3] : S_temp_5_0[3];
assign 	S[15]	= 	(Cout_4) ? S_temp_5_1[4] : S_temp_5_0[4];
endmodule


// full adder 4-bit
module quad_fa (	
	input		[3:0]		A,
	input 	[3:0]		B,
	input 					Cin,
	output	[3:0]		S
);

wire		Cout_internal;					

triple_fa	tri_fa_0 (
	.A		(A[2:0]),
	.B		(B[2:0]),
	.Cin	(Cin),
	.S		(S[2:0]),
	.Cout	(Cout_internal)
);	

fa_no_cout fa (
	.in_x			(A[3]),
	.in_y			(B[3]),
	.carry_in	(Cout_internal),
	.sum_out	(S[3])
);							
endmodule

// full adder 3-bit
module triple_fa (
	input		[2:0]		A,
	input 	[2:0]		B,
	input 					Cin,
	output 	[2:0]		S,
	output 					Cout
);

wire		Cout_internal;

double_fa db_fa_0 (
	.A		(A[1:0]),
	.B		(B[1:0]),
	.Cin	(Cin),
	.S		(S[1:0]),
	.Cout	(Cout_internal)
);					

fa fa_0 (
	.in_x				(A[2]),
	.in_y				(B[2]),
	.carry_in		(Cout_internal),
	.sum_out		(S[2]),
	.carry_out	(Cout)
);							
endmodule


// full adder 2-bit
module double_fa (
	input 	[1:0]		A,
	input 	[1:0]		B,
	input 					Cin,
	output  [1:0]		S,
	output 					Cout
);

wire		Cout_internal;

fa	fa_0 (
	.in_x				(A[0]),
	.in_y				(B[0]),
	.carry_in		(Cin),
	.sum_out		(S[0]),
	.carry_out	(Cout_internal)
);							
	
fa	fa_1 (
	.in_x				(A[1]),
	.in_y				(B[1]),
	.carry_in		(Cout_internal),
	.sum_out		(S[1]),
	.carry_out	(Cout)
);			
endmodule


// full adder with no carry_out
module fa_no_cout (
	//	Inputs
	input		in_x,
	input		in_y,
	input		carry_in,
	
	//	Outputs
	output		sum_out
);

assign sum_out   = carry_in ^ in_x ^ in_y; 
endmodule


// full adder with carry_in=1
module fa_1 (
	//	Inputs
	input		in_x,
	input		in_y,
	
	//	Outputs
	output		sum_out,
	output		carry_out
);

wire a_xor_b;
wire a_and_b;

assign a_xor_b = in_x ^ in_y;
assign a_and_b = in_x & in_y;
assign sum_out   = ~a_xor_b; 
assign carry_out = a_xor_b | a_and_b;
endmodule


// full adder with carry_in=0
module fa_0 (
	//	Inputs
	input		in_x,
	input		in_y,
	
	//	Outputs
	output		sum_out,
	output		carry_out
);

wire a_xor_b;
wire a_and_b;

assign a_xor_b = in_x ^ in_y;
assign a_and_b = in_x & in_y;
assign sum_out   = a_xor_b; 
assign carry_out = a_and_b;
endmodule


// normal full adder
module fa(
	//	Inputs
	input		in_x,
	input		in_y,
	input		carry_in,
	
	//	Outputs
	output		sum_out,
	output		carry_out
);

wire a_xor_b;
wire a_and_b;

assign a_xor_b = in_x ^ in_y;
assign a_and_b = in_x & in_y;
assign sum_out   = carry_in ^ a_xor_b; 
assign carry_out = (a_xor_b & carry_in) | a_and_b;
endmodule
