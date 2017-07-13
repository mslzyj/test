`timescale 1ns/1ns
`include "./define.v"

module test;

reg clk,rst;


wire [3:0] port7,port8,port9,porta;

xupt181 u_xupt181(
	.clk      (clk),
	.rst      (rst),	
	.port7    (port7),
	.port8    (port8),
	.port9    (port9),
	.porta    (porta)
);

pullup(port8[0]);
pullup(port8[2]);
pulldown(port8[1]);
pulldown(port8[3]);

initial begin
	clk = 0;
	rst = 1;
	#1000
	rst = 0;
	
	#10000;
	$finish;
end


always #10 clk = ~clk;

initial begin
    $fsdbDumpfile("rtl.fsdb");
    $fsdbDumpvars(0, test);
end

endmodule