`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 15:23:09
// Design Name: 
// Module Name: win_mul_16_signed
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module win_mul_16_signed(
	input  		[15:0] 	mul_a,
	input  		[15:0] 	mul_b,
	input 		[ 1:0] 	bitwidth,
	
	output  	[31:0] 	mul_out
	//output  	[63:0] 	mul_out
    );

	wire 		[ 7:0] 	a_high;
	wire 		[ 7:0] 	a_low;
	wire 		[ 7:0] 	b_high;
	wire 		[ 7:0] 	b_low;

	wire 		[15:0]	res_a1_b1;
	wire		[15:0]	res_a1_b2;
	wire 		[15:0]	res_a2_b1;
	wire 		[15:0]	res_a2_b2;

	wire 		[15:0]	res8_a1_b1;
	wire		[15:0]	res8_a1_b2;
	wire 		[15:0]	res8_a2_b1;
	wire 		[15:0]	res8_a2_b2;

	wire 		[15:0]  mul_wire_a;
	wire 		[15:0]  mul_wire_b;

	wire 		[31:0] 	mul_res_16;
	wire 		[31:0] 	mul_res_16_wei;

	assign 	mul_wire_a 	= 	((mul_a[15] == 1'b1))? {1'b1,~mul_a[14:0]+1'b1} : mul_a;
	assign  mul_wire_b 	= 	((mul_b[15] == 1'b1))? {1'b1,~mul_b[14:0]+1'b1} : mul_b;

	assign a_high = (bitwidth == 2'b00) ? {1'b0,mul_wire_a[14:8]} : mul_a[15:8];
	assign a_low  = (bitwidth == 2'b00) ? 		mul_wire_a[ 7:0]  : mul_a[ 7:0];
	assign b_high = (bitwidth == 2'b00) ? {1'b0,mul_wire_b[14:8]} : mul_b[15:8];
	assign b_low  = (bitwidth == 2'b00) ? 		mul_wire_b[ 7:0]  : mul_b[ 7:0];

	win_mul_8 inst1_win_mul_8(a_high,b_high,2'b00,res_a1_b1);
	win_mul_8 inst2_win_mul_8(a_high,b_low ,2'b00,res_a1_b2);
	win_mul_8 inst3_win_mul_8(a_low ,b_high,2'b00,res_a2_b1);
	win_mul_8 inst4_win_mul_8(a_low ,b_low ,2'b00,res_a2_b2);

	win_mul_8 inst81_win_mul_8(a_high,b_high,2'b11,res8_a1_b1);
	//win_mul_8 inst82_win_mul_8(a_high,b_low ,2'b11,res8_a1_b2);
	//win_mul_8 inst83_win_mul_8(a_low ,b_high,2'b11,res8_a2_b1);
	win_mul_8 inst84_win_mul_8(a_low ,b_low ,2'b11,res8_a2_b2);

	assign mul_res_16_wei = ((res_a1_b1<<16) + ((res_a1_b2+res_a2_b1)<<8) + res_a2_b2);
	assign mul_res_16 = ((mul_a[15] ^ mul_b[15]) == 1'b1) ? {1'b1,~mul_res_16_wei[30:0]+1} : mul_res_16_wei ;

	/*
	assign mul_out 	  = (bitwidth == 2'b00) ? {32'b0,mul_res_16} : 
						(bitwidth == 2'b11) ? {res8_a1_b1,res8_a2_b1,res8_a1_b2,res8_a2_b2} : {32'b0,mul_res_16};
	*/
	assign mul_out 	  = (bitwidth == 2'b00) ? mul_res_16 : 
						(bitwidth == 2'b11) ? {res8_a1_b1,res8_a2_b2} : mul_res_16;

endmodule
