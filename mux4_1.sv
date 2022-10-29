//4:1 mux

`timescale 10ps/1ps
module mux4_1(out, inputs, select);   
  output logic out;    
  input  logic [3:0] inputs;
  input  logic [1:0] select;  
     
  logic  v0, v1;   
     
  mux2_1 m0(.out(v0), .inputs(inputs[1:0]), .select(select[0])); //combines 2 2:1 muxes using a 2:1 mux to create 4:1 mux   
  mux2_1 m1(.out(v1), .inputs(inputs[3:2]), .select(select[0]));    
  mux2_1 m (.out(out), .inputs({v1,v0}), .select(select[1])); 
endmodule     

module mux4_1_testbench (); // Tests all possible inputs.
	logic [3:0] inputs;
	logic out;
	logic [1:0] select;
	
	mux4_1 dut (.out, .inputs, .select);
	  
  initial begin   
	 for(int i=0; i<64; i++) begin   
		{select, inputs} = i; #30;
	 end   
  end
endmodule
