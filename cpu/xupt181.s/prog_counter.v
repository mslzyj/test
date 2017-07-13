`timescale 1ns/1ns
`include "./define.v"

module prog_counter (
	clk,
	rst,
	load,
	addr,
	pc,
	upc
);
input 			clk;
input			rst;
input			load;
input	[7:0]	addr;
output 	[7:0]	pc;
output	[1:0]   upc;

reg [7:0] pc;
reg [1:0] upc;

always @ (posedge clk or posedge rst)
  begin 
    if (rst)
	  upc <= #`FFD 2'h0;
	else
	  upc <= #`FFD upc + 1'b1;
  end
  
always @ (posedge clk or posedge rst)
  begin
	if (rst)
	  pc <= #`FFD 8'h00;
	else if (load)
	  pc <= #`FFD addr;
	else if (upc==2'h3)
	  pc <= #`FFD pc + 1'b1;
	else
	  ;
  end

endmodule