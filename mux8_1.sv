// 8:1 mux

`timescale 10ps/1ps
module mux8_1(out, inputs, select);   
  output logic out;    
  input  logic [7:0] inputs;
  input  logic [2:0] select;
     
  logic  v0, v1;   
  
  mux4_1 m0(.out(v0), .inputs(inputs[3:0]), .select(select[1:0])); // Combines two 4:1 muxes using a 2:1 mux to create 8:1 mux.
  mux4_1 m1(.out(v1), .inputs(inputs[7:4]), .select(select[1:0]));
  mux2_1 m(.out(out), .inputs({v1,v0}), .select(select[2])); // 4:1 muxes outputs go into inputs of 2:1 mux
endmodule     

module mux8_1_testbench (); // Tests various inputs.
	logic [7:0] inputs;
	logic out;
	logic [2:0] select;
	
	mux4_1 dut (.out, .inputs, .select);
	  
  initial begin   
	 for(int i=0; i<64; i++) begin   
		{select, inputs} = i; #30;
	 end   
  end
endmodule

