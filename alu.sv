`timescale 10ps/1ps

// Top Level 64 bit ALU Module.
module alu (
input logic [63:0] A,
input logic [63:0] B,
input logic [2:0] cntrl,
output logic [63:0] result,
output logic negative,
output logic overflow,
output logic carry_out,
output logic zero
);
	
	logic [63:0] alu_c_in, alu_out; // Logic  to keep track of all carry ins and outputs
	
	
	assign alu_c_in[0] = cntrl[0]; // Assigns first carry in to cntrl[0] to account for addition/subtraction

	
	
	genvar i;
	generate
		for (i = 0; i < 63; i++) begin: ConnectALUs // Instantiates and connects first 63 alu slices.
			alu_1_bit alu_slice (.a(A[i]), .b(B[i]), .c_in(alu_c_in[i]), .out_slice(alu_out[i]), .c_out(alu_c_in[i+1]), .ctrl(cntrl));
		end
	endgenerate
	
	// Instantiates last alu slice, assigns carry_out of alu.
	alu_1_bit ms_bit (.a(A[63]), .b(B[63]), .c_in(alu_c_in[63]), .out_slice(alu_out[63]), .c_out(carry_out), .ctrl(cntrl));
	
	// Calculates overflow.
	xor #(5) overflow_flag (overflow, carry_out, alu_c_in[63]);

	// assigns negative flag.
	assign negative = alu_out[63];
	
	// assigns result.
	assign result = alu_out;
	
	// assigns zero flag.
	zero_checker zero_flag (.is_zero(zero), .inputs(alu_out));
endmodule
