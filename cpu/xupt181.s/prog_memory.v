`timescale 1ns/1ns
`include "./define.v"

module prog_memory (
	clk,
	rst,
	addr,
	upc,
	inst	
);
input 		clk;
input			rst;
input	[7:0]	addr;
input   [1:0]   upc;
output 	[7:0]  	inst;

reg [7:0] mem [0:255];
//synopsys translate_off
/*
initial begin
		  ProgMem[0]=8'h4c; 
        ProgMem[1]=8'h4c; 
        ProgMem[2]=8'h12;   
        ProgMem[3]=8'h52;   
        ProgMem[4]=8'hf7;  
end
*/
//synopsys translate_on


reg [7:0] inst;

always @ (posedge clk or posedge rst)
  begin 
    if (rst)
	 begin
	    inst <= #`FFD 8'h0;		 
		  //mem[0]=8'h10; 
        //mem[1]=8'he7; 
        //mem[2]=8'h20;   
        //mem[3]=8'h10;   
        //mem[4]=8'he8;
		  //mem[5]=8'h4c; 
        //mem[6]=8'h60; 
        //mem[7]=8'hf9;
			mem[0]=8'h11;
			mem[1]=8'h4c;
			mem[2]=8'h54;
			mem[3]=8'hf7;
		end 
	else if (upc==2'b11)
		inst <= #`FFD mem[addr];
  end

//assign inst = mem[addr];

endmodule