// 2:1 mux

`timescale 10ps/1ps
module mux2_1(out, inputs, select);   
  output logic out;    // output
  input  logic [1:0] inputs;   // inputs
  input logic select;	// select
  
  logic select_not, and_1, and_0;
  
  not #(5) (select_not, select);
  
  and #(5) (and_1, select, inputs[1]);  //2:1 mux gate logic
  and #(5) (and_0, select_not, inputs[0]);
  or  #(5) (out, and_1, and_0);
endmodule   
   
module mux2_1_testbench (); // Tests all possible inputs.
	logic [1:0] inputs;
	logic out;
	logic select;
	
	mux2_1 dut (.out, .inputs, .select);
	
  integer i;   
  initial begin   
	 for(i=0; i< 8; i++) begin   
		{select, inputs} = i; #30;    
	 end   
  end
endmodule
