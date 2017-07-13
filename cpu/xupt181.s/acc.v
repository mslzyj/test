`timescale 1ns/1ns
`include "./define.v"

module acc(
	clk,
	rst,
	sync,
	we,
	acci,
	acco
);
input 			clk;
input 			rst;
input           sync;
input			we;
input 	[3:0]	acci;
output  [3:0]	acco;

reg [3:0] accs;
reg [3:0] acco;

always @ (posedge clk or posedge rst)
  begin 
    if (rst)
	  accs <= #`FFD 4'h0;
	else if (sync==1'b1)
	  accs <= #`FFD acci;
	else
	  ;
  end

always @ (posedge clk or posedge rst)
  begin
	if (rst)
	  acco <= #`FFD 4'h0;
	else if (we)
	  acco <= #`FFD accs;
	else
	  ;
  end

endmodule