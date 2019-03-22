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
/*
module win_mul_16_signed(
	input  		[15:0] 	mul_a,
	input  		[15:0] 	mul_b,

	output  	[31:0] 	mul_out
    );
	wire [15:0] mul_wire_a;
	wire [15:0] mul_wire_b;

	assign 	mul_wire_a 	= (mul_a[15] == 1'b0)? mul_a : {mul_a[15],~mul_a[14:0]+1'b1};
	assign  mul_wire_b 	= (mul_b[15] == 1'b0)? mul_b : {mul_b[15],~mul_b[14:0]+1'b1};

endmodule
*/

module win_mul_16_signed(
	input  		[15:0] 	mul_a,
	input  		[15:0] 	mul_b,

	output  	[31:0] 	mul_out
    );

	wire [15:0] mul_wire_a;
	wire [15:0] mul_wire_b;

	wire [29:0] stored0;
	wire [29:0] stored1;
	wire [29:0] stored2;
	wire [29:0] stored3;
	wire [29:0] stored4;
	wire [29:0] stored5;
	wire [29:0] stored6;
	wire [29:0] stored7;
	wire [29:0] stored8;
	wire [29:0] stored9;
	wire [29:0] stored10;
	wire [29:0] stored11;
	wire [29:0] stored12;
	wire [29:0] stored13;
	wire [29:0] stored14;

	wire [30:0] mul_wire_out;

	assign 	mul_wire_a 	= (mul_a[15] == 1'b0)? mul_a : {mul_a[15],~mul_a[14:0]+1'b1};
	assign  mul_wire_b 	= (mul_b[15] == 1'b0)? mul_b : {mul_b[15],~mul_b[14:0]+1'b1};

	assign	stored0 	= mul_wire_b[ 0]? {15'b0, mul_wire_a[14:0] 	  	 } : 30'b0;
	assign	stored1 	= mul_wire_b[ 1]? {14'b0, mul_wire_a[14:0],  1'b0} : 30'b0;
	assign	stored2 	= mul_wire_b[ 2]? {13'b0, mul_wire_a[14:0],  2'b0} : 30'b0;
	assign	stored3 	= mul_wire_b[ 3]? {12'b0, mul_wire_a[14:0],  3'b0} : 30'b0;
	assign	stored4 	= mul_wire_b[ 4]? {11'b0, mul_wire_a[14:0],  4'b0} : 30'b0;
	assign	stored5 	= mul_wire_b[ 5]? {10'b0, mul_wire_a[14:0],  5'b0} : 30'b0;
	assign	stored6 	= mul_wire_b[ 6]? { 9'b0, mul_wire_a[14:0],  6'b0} : 30'b0;
	assign	stored7 	= mul_wire_b[ 7]? { 8'b0, mul_wire_a[14:0],  7'b0} : 30'b0;
	assign	stored8 	= mul_wire_b[ 8]? { 7'b0, mul_wire_a[14:0],  8'b0} : 30'b0;
	assign	stored9 	= mul_wire_b[ 9]? { 6'b0, mul_wire_a[14:0],  9'b0} : 30'b0;
	assign	stored10 	= mul_wire_b[10]? { 5'b0, mul_wire_a[14:0], 10'b0} : 30'b0;
	assign	stored11 	= mul_wire_b[11]? { 4'b0, mul_wire_a[14:0], 11'b0} : 30'b0;
	assign	stored12 	= mul_wire_b[12]? { 3'b0, mul_wire_a[14:0], 12'b0} : 30'b0;
	assign	stored13 	= mul_wire_b[13]? { 2'b0, mul_wire_a[14:0], 13'b0} : 30'b0;
	assign	stored14 	= mul_wire_b[14]? { 1'b0, mul_wire_a[14:0], 14'b0} : 30'b0;

	assign	mul_wire_out = stored0+stored1+stored2+stored3+stored4+stored5+stored6+stored7+stored8+stored9+stored10+stored11+stored12+stored13+stored14;

	assign	mul_out 	= (mul_a == 16'h00 || mul_b == 16'h00) ? 32'h0 : 
						  ((mul_a[15] ^ mul_b[15]) == 1'b1)    ?{1'b1,~mul_wire_out+1} : {1'b0,mul_wire_out};

endmodule
