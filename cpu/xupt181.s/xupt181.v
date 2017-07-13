`timescale 1ns/1ns
`include "./define.v"

module xupt181(
	clk,
	rst,	
	port7,
	port8,
	port9,
	porta
);
input			clk;
input			rst;
inout	[3:0]	port7;
inout 	[3:0] 	port8;
inout 	[3:0]	port9;
inout	[3:0] 	porta;

//======================================
wire pc_load;
wire [7:0] pc_addr;
wire [7:0] pc;
wire [1:0] upc;

wire [7:0] inst;

wire [3:0] op;
wire [15:0] f;

wire reg_we;
wire [3:0] reg_addr,reg_dati,reg_dato;

wire [3:0] alu_s,alu_a,alu_b,alu_f;
wire       alu_m,alu_cnb,alu_cn4b,alu_aeb;

wire [3:0] data_bus;
wire [3:0] acco;
wire       acc_sync,acc_we;

wire [1:0] flago;
wire   	   flag_sync,flag_we;

wire [3:0] funco;
wire       func_sync;

wire [3:0] porti_mux;
wire       port_sync;
//======================================

prog_counter u_prog_counter(
	.clk		(clk),
	.rst		(rst),
	.load		(pc_load),
	.addr		(pc_addr),
	.pc			(pc),
	.upc		(upc)
);

prog_memory u_prog_memory(
	.clk		(clk),
	.rst		(rst),
	.addr		(pc),
	.upc        (upc),
	.inst		(inst)
);
assign op = inst[7:4];
control_memory u_control_memory(
	.clk		(clk),
	.rst		(rst),
	.op			(op),
	.cnt		(upc),
	.f			(f)
);

reg_16x4 u_reg_16x4(
	.clk		(clk),
	.rst		(rst),
	.we			(reg_we),
	.addr		(inst[3:0]),
	.dati		(acco),
	.dato		(reg_dato)
);
assign reg_we =~f[10]; //f10: 0=Write to register

acc u_acc(
	.clk		(clk),
	.rst		(rst),
	.sync       (acc_sync),
	.we			(acc_we),
	.acci		(alu_f),
	.acco       (acco)
);
assign acc_sync = f[6] ;   //f6: 1=latch alu result & flags
assign acc_we   = f[5] ;   //f5: 1=load accumulator 

alu_flag u_alu_flag(
	.clk		(clk),
	.rst		(rst),
	.sync		(flag_sync),
	.we			(flag_we),
	.flagi		({alu_aeb,alu_cn4b}),
	.flago		(flago)
);
assign flag_sync = f[6];  //f6: 1=latch alu result & flags
assign flag_we   = f[7];  //f7: 1=load flags

alu_func u_alu_func(
	.clk		(clk),
	.rst		(rst),
	.sync		(func_sync),
	.funci		(inst[3:0]),
	.funco		(funco)
);
assign func_sync = f[12];  //f12: 1= latch alu function

port u_port(
	.clk		(clk),
	.rst		(rst),
	.sync		(port_sync),
	.datai		(inst[3:0]),
	.acci		(acco),
	.porti_mux  (porti_mux),
	.port7		(port7),
	.port8		(port8),
	.port9		(port9),
	.porta		(porta)
);
assign port_sync = f[8] & ~f[9];  //f9: 0=port enable ; f8: 0=input port, 1= latch out port

//====================================================================
assign alu_b = f[4]==1'b0 ? inst[3:0] :         //f4: 0=data on bus enable
			   f[3]==1'b0 ? reg_dato  :         //f3: 0=reg on bus enable
			   f[8]==1'b0 ? porti_mux : 4'h0;   //f9: 0=port enable 
                                                 //f8: selected port , 0=input port, 1= latch out port			   
assign alu_a = acco;

assign alu_s = f[0]==0 ? funco :                 //f0: alu function select , 0=latched , 1=direct
				{~f[11],f[11],f[1],~f[1]};       //f11,f1: alu direct operation selection
				
assign alu_m = f[2];                             //f2: alu function mode , logic=1, arith=0				

//carry flag input (1=no carry , 0=with carry)
assign alu_cnb = f[13]==0 ? flago[1] :           //f13: set_carry
						    alu_s[2] | acco[0];

//f14: jump condition 1 (0=low, 1=zero flag, 0=carry flag, 1=high)							
//f15: jump condition 2 (0=low, 0=zero flag, 1=carry flag, 1=high)	
assign pc_load = f[15:14]==2'b00 ? 1'b0      : // no jump 
				 f[15:14]==2'b01 ? flago[0]  : // zero flag
				 f[15:14]==2'b10 ? ~flago[1] : // carry flag (neg)
				                   1'b1      ; // incondition jump
assign pc_addr = {inst[3:0],acco};								   
								   
							
alu_74181 u_alu_74181(
	.S			(alu_s), 
	.A			(alu_a), 
	.B			(alu_b),	 
	.M			(alu_m), 
	.CNb		(alu_cnb), 
	.F			(alu_f), 
	.X			(), 
	.Y			(), 
	.CN4b		(alu_cn4b), 
	.AEB		(alu_aeb)
	);

endmodule