`timescale 10ps/1ps

// 1 bit full adder module.
module full_adder (
input logic a,
input logic b,
input logic c_in,
output logic c_out,
output logic sum
);

	logic a_xor_b, and_1, and_2;  // full adder logic temp variables.
	
	xor #(5) (a_xor_b, a, b);    // full adder logic.
	
	and #(5) (and_1, a_xor_b, c_in);
	and #(5) (and_2, a, b);
	
	xor #(5) (sum, a_xor_b, c_in);
	or  #(5) (c_out, and_1, and_2);

endmodule


module full_adder_testbench (); // Tests all possible input combinations.
	logic a, b, c_in;
	logic c_out, sum;
	
	full_adder dut (.a, .b, .c_in, .c_out, .sum);
	
	initial begin
		for (int i = 0; i < 8; i++) begin
			{a, b, c_in} = i; #30;
		end
	end
endmodule

