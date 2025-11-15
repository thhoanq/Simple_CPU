// Upcount Counter 2-bit
module Counter_2 (
	// Global signals
	input 						clock,

	// Control signals
	input							clear,

	// Control unit
	output reg [1:0]	state
);

always @(posedge clock) begin
	if(clear)
		state <= 0;
	else
		state <= state + 1'b1;
end
endmodule
