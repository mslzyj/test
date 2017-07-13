`timescale 1ns/1ns
`include "./define.v"

module alu_flag(
	clk,
	rst,
	sync,
	we,
	flagi,
	flago
);
input 			clk;
input 			rst;
input           sync;
input			we;
input 	[1:0]	flagi;
output  [1:0]	flago;

reg [1:0] flags;
reg [1:0] flago;

always @ (posedge clk or posedge rst)
  begin 
    if (rst)
	  flags <= #`FFD 2'h0;
	else if (sync==1'b1)
	  flags <= #`FFD flagi;
	else
	  ;
  end

always @ (posedge clk or posedge rst)
  begin
	if (rst)
	  flago <= #`FFD 2'h0;
	else if (we)
	  flago <= #`FFD flags;
	else
	  ;
  end

endmodule