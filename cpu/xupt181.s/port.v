`timescale 1ns/1ns
`include "./define.v"

module port(
	clk,
	rst,
	sync,
	datai,
	acci,
	porti_mux,
	port7,
	port8,
	port9,
	porta
);
input 			clk;
input 			rst;
input           sync;
input 	[3:0]	datai;
input   [3:0]   acci;
output  [3:0]   porti_mux;
inout   [3:0]	port7;
inout   [3:0]	port8;
inout   [3:0]	port9;
inout   [3:0]	porta;

reg [3:0] dir3,dir4,dir5,dir6;
reg [3:0] port7_o,port8_o,port9_o,porta_o;
wire [3:0] port7_i,port8_i,port9_i,porta_i;



always @ (posedge clk or posedge rst)
  begin
	if (rst)
	  begin
	    dir3    <= #`FFD 4'hf;           //input
		dir4    <= #`FFD 4'hf;
		dir5    <= #`FFD 4'hf;
		dir6    <= #`FFD 4'hf;
		port7_o <= #`FFD 4'hf;
		port8_o <= #`FFD 4'hf;
		port9_o <= #`FFD 4'hf;
		porta_o <= #`FFD 4'hf;
	  end
	else if (sync==1'b1)
	  case (datai)
	    4'h3: dir3    <= #`FFD acci;
		4'h4: dir4    <= #`FFD acci;
		4'h5: dir5    <= #`FFD acci;
		4'h6: dir6    <= #`FFD acci;
		4'h7: port7_o <= #`FFD acci;
		4'h8: port8_o <= #`FFD acci;
		4'h9: port9_o <= #`FFD acci;
		4'ha: porta_o <= #`FFD acci;
		default:
			;
	  endcase
	else
	  ;
  end
  
assign port7[0] = dir3[0] ? 1'bz : port7_o[0];
assign port7[1] = dir3[1] ? 1'bz : port7_o[1];
assign port7[2] = dir3[2] ? 1'bz : port7_o[2];
assign port7[3] = dir3[3] ? 1'bz : port7_o[3];
assign port7_i  = port7;

assign port8[0] = dir4[0] ? 1'bz : port8_o[0];
assign port8[1] = dir4[1] ? 1'bz : port8_o[1];
assign port8[2] = dir4[2] ? 1'bz : port8_o[2];
assign port8[3] = dir4[3] ? 1'bz : port8_o[3];
assign port8_i  = port8;

assign port9[0] = dir5[0] ? 1'bz : port9_o[0];
assign port9[1] = dir5[1] ? 1'bz : port9_o[1];
assign port9[2] = dir5[2] ? 1'bz : port9_o[2];
assign port9[3] = dir5[3] ? 1'bz : port9_o[3];
assign port9_i  = port9;

assign porta[0] = dir6[0] ? 1'bz : porta_o[0];
assign porta[1] = dir6[1] ? 1'bz : porta_o[1];
assign porta[2] = dir6[2] ? 1'bz : porta_o[2];
assign porta[3] = dir6[3] ? 1'bz : porta_o[3];
assign porta_i  = porta;

assign porti_mux =  datai==4'h7 ? port7_i :
					datai==4'h8 ? port8_i :
					datai==4'h9 ? port9_i :
					datai==4'ha ? porta_i : 4'h0;

endmodule