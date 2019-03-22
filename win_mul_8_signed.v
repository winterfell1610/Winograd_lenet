`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 15:23:09
// Design Name: 
// Module Name: win_mul_8_signed
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



module win_mul_8_signed(
	input  		[7:0] 	mul_a,
	input  		[7:0] 	mul_b,

	output  	[15:0] 	mul_out
    );

	wire [ 7:0] mul_wire_a;
	wire [ 7:0] mul_wire_b;

	wire [13:0] stored0;
	wire [13:0] stored1;
	wire [13:0] stored2;
	wire [13:0] stored3;
	wire [13:0] stored4;
	wire [13:0] stored5;
	wire [13:0] stored6;

	wire [14:0] mul_wire_out;

	assign 	mul_wire_a 	= (mul_a[7] == 1'b0)? mul_a : {mul_a[7],~mul_a[6:0]+1'b1};
	assign  mul_wire_b 	= (mul_b[7] == 1'b0)? mul_b : {mul_b[7],~mul_b[6:0]+1'b1};

	assign	stored0 	= mul_wire_b[0]? {7'b0, mul_wire_a[6:0] 	 } : 14'b0;
	assign	stored1 	= mul_wire_b[1]? {6'b0, mul_wire_a[6:0], 1'b0} : 14'b0;
	assign	stored2 	= mul_wire_b[2]? {5'b0, mul_wire_a[6:0], 2'b0} : 14'b0;
	assign	stored3 	= mul_wire_b[3]? {4'b0, mul_wire_a[6:0], 3'b0} : 14'b0;
	assign	stored4 	= mul_wire_b[4]? {3'b0, mul_wire_a[6:0], 4'b0} : 14'b0;
	assign	stored5 	= mul_wire_b[5]? {2'b0, mul_wire_a[6:0], 5'b0} : 14'b0;
	assign	stored6 	= mul_wire_b[6]? {1'b0, mul_wire_a[6:0], 6'b0} : 14'b0;

	assign	mul_wire_out = stored0+stored1+stored2+stored3+stored4+stored5+stored6;

	assign	mul_out 	= (mul_a == 8'h00 || mul_b == 8'h00) ? 16'h0 : 
						  ((mul_a[7] ^ mul_b[7]) == 1'b1)    ?{1'b1,~mul_wire_out+1} : {1'b0,mul_wire_out};

endmodule
