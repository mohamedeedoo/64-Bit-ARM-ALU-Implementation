`timescale 10ps/1ps

// This module checks to see if the given input is zero.
module zero_checker (
input logic [63:0] inputs,
output logic is_zero
);
	logic [15:0] level1;
	logic [3:0] level2;
	logic level3;
	
	genvar i;
	generate // Create 16 4 input or gates with each or gate getting 4 of the 64 inputs
		for (i = 0; i < 64; i = i + 4) begin: layer0
			or_4 orgate (level1[i / 4], inputs[i], inputs[i + 1], inputs [i + 2], inputs[i + 3]); 
		end
	endgenerate
	
	generate // Creates 4 4 input or gates with each gate getting 4 of the 16 or gate outputs.
		for (i = 0; i < 16; i = i + 4) begin: layer1
			or_4 orgate (level2[i / 4], level1[i], level1[i + 1], level1[i + 2], level1[i + 3]);
		end
	endgenerate
	
	// 4 input or gate which takes in the outputs of the 4 or gates generated above.
	or_4 final_level (level3, level2[0], level2[1], level2[2], level2[3]); 
	
	// invert final result so out is true when input is 0.
	not #(5) (is_zero, level3);
endmodule

module zero_checker_testbench (); // Tries various input combos, ensuring 
	logic [63:0] inputs;				 // 'is_zero' is only true when input == 0
	logic is_zero;
	
	zero_checker dut (.inputs, .is_zero);
	
	initial begin
		inputs = 64'h0000000000000001; #30;
												 #30;
		inputs = 64'hFFFFFFFFFFFFFFFF; #30;
												 #30;
		inputs = 64'h0101010101010101; #30;
												 #30;
		inputs = 64'h0000000000000000; #30;
												 #30;
	end
endmodule




