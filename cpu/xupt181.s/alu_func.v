`timescale 1ns/1ns
`include "./define.v"

module alu_func(
	clk,
	rst,
	sync,
	funci,
	funco
);
input 			clk;
input 			rst;
input           sync;
input 	[3:0]	funci;
output  [3:0]	funco;

reg [3:0] funco;


always @ (posedge clk or posedge rst)
  begin
	if (rst)
	  funco <= #`FFD 4'h0;
	else if (sync)
	  funco <= #`FFD funci;
	else
	  ;
  end

endmodule