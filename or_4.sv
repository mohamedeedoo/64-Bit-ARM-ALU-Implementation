`timescale 10ps/1ps

// 4 input or gate
module or_4 (
output logic out,
input logic in0, 
input logic in1, 
input logic in2, 
input logic in3
);

	or #(5) (out, in0, in1, in2, in3); // 4 input or gate
	
endmodule

	
module or_4_testbench (); // Tests all possible input combinations
	logic out, in0, in1, in2, in3;
	
	or_4 dut (.out, .in0, .in1, .in2, .in3);
	
	initial begin
		for (int i = 0; i < 16; i++) begin
			{in0, in1, in2, in3} = i; #30;
		end
	end
endmodule
