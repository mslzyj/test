`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:10 11/03/2014 
// Design Name: 
// Module Name:    Output_2_Disp 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module 	 Prep_IO(input  wire clk_100mhz,
	// I/O:
						input wire [15:8] SW,
						inout  [3:0] portE,
						inout  [3:0] portF, 
						output wire led_clk,
						output wire led_clrn,
						output wire led_sout,
						output wire LED_PEN,
				
						output wire seg_clk,
						output wire seg_clrn,
						output wire seg_sout,
						output wire SEG_PEN,
						output Buzzer
						);
				


	
wire[31:0]Div;
wire CK;
wire [3:0]portE=SW[15:12];
wire [3:0]portF=SW[11:8];
wire [3:0] portA;	
wire [3:0] port9;						  
	wire[7:0] Seg0=8'hff;			
	wire[7:0] Seg3=8'hff;
	wire[7:0] Seg4=8'hff;
	wire[7:0] Seg5=8'hff;
	wire[7:0] Seg6=8'hff;
	
	wire[63:0] disp_data ={Seg0,Seg1,Seg2,Seg3,Seg4,Seg5,Seg6,Seg7};
	wire[7:0] Seg1 = SW[15:12] == 0 ? 8'b00000011 : 
	                 SW[15:12] == 1 ? 8'b10011111 :
                    SW[15:12] == 2 ? 8'b00100101 :
                    SW[15:12] == 3 ? 8'b00001101 :
                    SW[15:12] == 4 ?	8'b10011001 :
                    SW[15:12] == 5 ? 8'b01001001 :
						  SW[15:12] == 6 ? 8'b01000001 :
						  SW[15:12] == 7 ? 8'b00011111 :
						  SW[15:12] == 8 ? 8'b00000001 :
                    SW[15:12] == 9 ? 8'b00001001 :
                    SW[15:12] == 10 ? 8'b00010001 :
                    SW[15:12] == 11 ? 8'b11000001 :
                    SW[15:12] == 12 ? 8'b01100011 :
                    SW[15:12] == 13 ? 8'b10000101 :
                    SW[15:12] == 14 ? 8'b01100001 :
                    8'b01110001;
	wire[7:0] Seg2 = SW[11:8] == 0 ? 8'b00000011 : 
	                 SW[11:8] == 1 ? 8'b10011111 :
                    SW[11:8] == 2 ? 8'b00100101 :
                    SW[11:8] == 3 ? 8'b00001101 :
                    SW[11:8] == 4 ?	8'b10011001 :
                    SW[11:8] == 5 ? 8'b01001001 :
						  SW[11:8] == 6 ? 8'b01000001 :
						  SW[11:8] == 7 ? 8'b00011111 :
						  SW[11:8] == 8 ? 8'b00000001 :
                    SW[11:8] == 9 ? 8'b00001001 :
                    SW[11:8] == 10 ? 8'b00010001 :
                    SW[11:8] == 11 ? 8'b11000001 :
                    SW[11:8]== 12 ? 8'b01100011 :
                    SW[11:8] == 13 ? 8'b10000101 :
                    SW[11:8] == 14 ? 8'b01100001 :
                    8'b01110001;
	
	wire[7:0] Seg7 = portE == 0 ? 8'b00000011 : 
	                 portE == 1 ? 8'b10011111 :
                    portE == 2 ? 8'b00100101 :
                    portE == 3 ? 8'b00001101 :
                    portE == 4 ?	8'b10011001 :
                    portE == 5 ? 8'b01001001 :
						  portE == 6 ? 8'b01000001 :
						  portE == 7 ? 8'b00011111 :
						  portE == 8 ? 8'b00000001 :
                    portE == 9 ? 8'b00001001 :
                    portE == 10 ? 8'b00010001 :
                    portE == 11 ? 8'b11000001 :
                    portE == 12 ? 8'b01100011 :
                    portE == 13 ? 8'b10000101 :
                    portE == 14 ? 8'b01100001 :
                    8'b01110001;;
	//wire [7:0] seg0=sw[3:0];
	clk_div       U8(clk_100mhz,1'b0,1'b0,Div,CK);

	P2S 			  #(.DATA_BITS(64),.DATA_COUNT_BITS(6)) 
						  P7SEG (clk_100mhz,
									1'b0,
									Div[20],
									disp_data,
									seg_clk,
									seg_clrn,
									seg_sout,
									SEG_PEN
									);
									
									
	LED_P2S 			  #(.DATA_BITS(16),.DATA_COUNT_BITS(4)) 
					      PLED (clk_100mhz,
									1'b0,
									Div[20],
									~{portE[0],portE[1],portE[2],portE[3],portF[0],portF[1],portF[2],portF[3],
									  portA[0],portA[1],portA[2],portA[3],SW[12],SW[13],SW[14],SW[15]},
									led_clk,
									led_clrn,
									led_sout,
									LED_PEN
									);
									
	xupt181 u_xupt181(
	.clk      (Div[20]),
	.rst      (rst),	
	.port7    (portE),
	.port8    (portF),
	.port9    (portE),
	.porta    (portA)
);

									
	assign Buzzer = 1;
	
endmodule





		


