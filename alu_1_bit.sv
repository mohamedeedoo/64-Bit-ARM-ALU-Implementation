`timescale 10ps/1ps

// 1 bit ALU slice module
module alu_1_bit (
input logic a,
input logic b,
input logic c_in,
input logic [2:0] ctrl,
output logic out_slice,
output logic c_out
);
	logic [7:0] mux_inputs; // inputs for the mux
	logic fa_output, and_output, or_output, xor_output; // Temp logic
	logic not_b, fa_b_input;
	
	not #(5) (not_b, b); // Invert b for 2s comp addition or subtraction
	mux2_1 subtract (.out(fa_b_input), .inputs({not_b, b}), .select(ctrl[0])); // Mux to select b or b_not depending on
																										// if ctrl is add or subtract.
	
	full_adder fa (.a(a), .b(fa_b_input), .c_in(c_in), .c_out(c_out), .sum(fa_output)); // full adder instantiation
	
	and #(5) (and_output, a, b); // a and b
	or  #(5) (or_output, a, b);  // a or b
	xor #(5) (xor_output, a, b); // a xor b
	 
	// Concatenate the various possible operation outputs into a bus, 1'bx for don't care alu op signals 
	assign mux_inputs = {1'bx, xor_output, or_output, and_output, fa_output, fa_output, 1'bx, b};
	
	// insert all alu op outputs into mux for selection.
	mux8_1 mux8 (.out(out_slice), .inputs(mux_inputs), .select(ctrl));
endmodule

module alu_1_bit_testbench (); // Tests all possible combinations of a/b and ctrl inputs.
	logic a, b;
	logic [2:0] ctrl;
	logic out, c_out;
	
	alu_1_bit dut (.a(a), .b(b), .c_in(ctrl[0]), .ctrl(ctrl), .out(out), .c_out(c_out));
	
	initial begin
		for (int i = 0; i < 32; i++) begin
			{a, b, ctrl[2], ctrl[1], ctrl[0]} = i; #10;
		end
	end
endmodule
