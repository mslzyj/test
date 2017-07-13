`timescale 1ns/1ns
`include "./define.v"

module control_memory (
	clk,
	rst,
	op,
	cnt,
	f
);

input			clk;
input			rst;
input [3:0] 	op;
input [1:0] 	cnt;
output [15:0] 	f;    

reg [15:0] f;

always @ (*)
  begin
    //if (rst)
	//  f <= #`FFD 16'b0;
	//else 
	  case ({op,cnt})
		//0n:Jump to location (16*n+Acc)
	    6'b0000_00: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b0000_01: f <= #`FFD 16'b1100_0111_0000_1001;
		6'b0000_10: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b0000_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//1n: Load Acc with (n)
		6'b0001_00: f <= #`FFD 16'b0000_0111_0100_1111;
		6'b0001_01: f <= #`FFD 16'b0000_0111_0000_1111;
		6'b0001_10: f <= #`FFD 16'b0000_0111_0010_1001;
		6'b0001_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//2r: Load Register(r) with ACC
		6'b0010_00: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b0010_01: f <= #`FFD 16'b0000_0011_0000_1001;
		6'b0010_10: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b0010_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//3r: Load Acc with Register(r)
		6'b0011_00: f <= #`FFD 16'b0000_0111_0101_0111;
		6'b0011_01: f <= #`FFD 16'b0000_0111_0001_0111;
		6'b0011_10: f <= #`FFD 16'b0000_0111_0010_1001;
		6'b0011_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//4p: Set ALU to Operation(p)
		6'b0100_00: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b0100_01: f <= #`FFD 16'b0001_0111_0000_1001;
		6'b0100_10: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b0100_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//5n: Execute Operation(p) in Arithmetic mode on operands 
		//    A (ACC) and  B(n)
		6'b0101_00: f <= #`FFD 16'b0000_0111_0100_1000;
		6'b0101_01: f <= #`FFD 16'b0000_0111_0000_1000;
		6'b0101_10: f <= #`FFD 16'b0000_0111_1010_1001;
		6'b0101_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//6r: Execute Operation(p) in Arithmetic mode on operands 
		//    A (ACC) and  B(Register(r))
		6'b0110_00: f <= #`FFD 16'b0000_0111_0101_0000;
		6'b0110_01: f <= #`FFD 16'b0000_0111_0001_0000;
		6'b0110_10: f <= #`FFD 16'b0000_0111_1010_1001;
		6'b0110_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//7n: Execute Operation(p) in Logic mode on operands 
		//    A (ACC) and  B(n)
		6'b0111_00: f <= #`FFD 16'b0000_0111_0100_1100;
		6'b0111_01: f <= #`FFD 16'b0000_0111_0000_1100;
		6'b0111_10: f <= #`FFD 16'b0000_0111_0010_1001;
		6'b0111_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//8r: Execute Operation(p) in Logic mode on operands 
		//    A (ACC) and  B(Register(r))
		6'b1000_00: f <= #`FFD 16'b0000_0111_0101_0100;
		6'b1000_01: f <= #`FFD 16'b0000_0111_0001_0100;
		6'b1000_10: f <= #`FFD 16'b0000_0111_0010_1001;
		6'b1000_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//9s: Set Carry_Flag to "No_Carry" (s=0000) or 
		//    Set Carry_Flag to "with_Carry" (s=1111)
		6'b1001_00: f <= #`FFD 16'b0010_0111_0100_1001;
		6'b1001_01: f <= #`FFD 16'b0010_0111_0000_1001;
		6'b1001_10: f <= #`FFD 16'b0000_0111_1000_1001;
		6'b1001_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//an: Compare Acc with (n) and Set "with_carry" if ACC > n  or
		//    Set Zero_Flag to if Acc==n
		6'b1010_00: f <= #`FFD 16'b0010_1111_0100_1011;
		6'b1010_01: f <= #`FFD 16'b0010_1111_0000_1011;
		6'b1010_10: f <= #`FFD 16'b0000_0111_1000_1001;
		6'b1010_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//br: Compare Acc with Register(r) and Set "with_carry" if ACC > Register(r)  or
		//    Set Zero_Flag to if Acc==Register(r)
		6'b1011_00: f <= #`FFD 16'b0010_1111_0101_0011;
		6'b1011_01: f <= #`FFD 16'b0010_1111_0001_0011;
		6'b1011_10: f <= #`FFD 16'b0000_0111_1000_1001;
		6'b1011_11: f <= #`FFD 16'b0000_0111_0000_1001;
		//cn: if Zero_flag==1 Jump to location(16*n + ACC)
		6'b1100_00: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b1100_01: f <= #`FFD 16'b0100_0111_0000_1001;
		6'b1100_10: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b1100_11: f <= #`FFD 16'b0000_0111_0000_1001;	
		//dn: if "With Carry" Jump to location(16*n + ACC)
		6'b1101_00: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b1101_01: f <= #`FFD 16'b1000_0111_0000_1001;
		6'b1101_10: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b1101_11: f <= #`FFD 16'b0000_0111_0000_1001;	
		//en: Input from Port(n) and Load Acc
		6'b1110_00: f <= #`FFD 16'b0000_0110_0001_1001;
		6'b1110_01: f <= #`FFD 16'b0000_0100_0101_1111;
		6'b1110_10: f <= #`FFD 16'b0000_0100_0001_1111;
		6'b1110_11: f <= #`FFD 16'b0000_0110_0011_1001;	
		//fn: Load Output Port (n) with Acc
		6'b1111_00: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b1111_01: f <= #`FFD 16'b0000_0101_0000_1001;
		6'b1111_10: f <= #`FFD 16'b0000_0111_0000_1001;
		6'b1111_11: f <= #`FFD 16'b0000_0111_0000_1001;			
	  endcase
  end

endmodule