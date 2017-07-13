`timescale 1ns/1ns
`include "./define.v"

module reg_16x4(
	clk,
	rst,
	we,
	addr,
	dati,
	dato
);
input 			clk;
input 			rst;
input			we;
input	[3:0]	addr;
input 	[3:0]   dati;
output	[3:0]	dato;

reg [3:0] mem [0:15];

always @ (posedge clk or posedge rst)
  begin 
	if (rst)
	  begin
		mem[0] <= #`FFD 4'h0;
		mem[1] <= #`FFD 4'h0;
		mem[2] <= #`FFD 4'h0;
		mem[3] <= #`FFD 4'h0;
		mem[4] <= #`FFD 4'h0;
		mem[5] <= #`FFD 4'h0;
		mem[6] <= #`FFD 4'h0;
		mem[7] <= #`FFD 4'h0;
		mem[8] <= #`FFD 4'h0;
		mem[9] <= #`FFD 4'h0;
		mem[10]<= #`FFD 4'h0;
		mem[11]<= #`FFD 4'h0;
		mem[12]<= #`FFD 4'h0;
		mem[13]<= #`FFD 4'h0;
		mem[14]<= #`FFD 4'h0;
		mem[15]<= #`FFD 4'h0;
	  end
	else if (we)
	  begin
		mem[addr] <= #`FFD dati;
	  end
  end
  
assign dato = mem[addr];

endmodule