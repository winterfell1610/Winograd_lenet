`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 15:44:33
// Design Name: 
// Module Name: win_mul_8
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


module win_mul_8(
	input  		[7:0] 	mul_a,
	input  		[7:0] 	mul_b,
	input 		[1:0]	sign,

	output  	[15:0] 	mul_out
    );

	wire [15:0] stored0;
	wire [15:0] stored1;
	wire [15:0] stored2;
	wire [15:0] stored3;
	wire [15:0] stored4;
	wire [15:0] stored5;
	wire [15:0] stored6;
	wire [15:0] stored7;

	wire [ 7:0] mul_wire_a;
	wire [ 7:0] mul_wire_b;
	wire [15:0] mul_wire_out;

	assign 	mul_wire_a 	= 	((sign[1] == 1'b1) && (mul_a[7] == 1'b1))? {1'b0,~mul_a[6:0]+1'b1} : mul_a;
	assign  mul_wire_b 	= 	((sign[0] == 1'b1) && (mul_b[7] == 1'b1))? {1'b0,~mul_b[6:0]+1'b1} : mul_b;

	assign	stored0 	= 	mul_wire_b[0]? {8'b0, mul_wire_a[7:0] 	   } : 16'b0;
	assign	stored1 	= 	mul_wire_b[1]? {7'b0, mul_wire_a[7:0], 1'b0} : 16'b0;
	assign	stored2 	= 	mul_wire_b[2]? {6'b0, mul_wire_a[7:0], 2'b0} : 16'b0;
	assign	stored3 	= 	mul_wire_b[3]? {5'b0, mul_wire_a[7:0], 3'b0} : 16'b0;
	assign	stored4 	= 	mul_wire_b[4]? {4'b0, mul_wire_a[7:0], 4'b0} : 16'b0;
	assign	stored5 	= 	mul_wire_b[5]? {3'b0, mul_wire_a[7:0], 5'b0} : 16'b0;
	assign	stored6 	= 	mul_wire_b[6]? {2'b0, mul_wire_a[7:0], 6'b0} : 16'b0;
	assign	stored7 	= 	mul_wire_b[7]? {1'b0, mul_wire_a[7:0], 7'b0} : 16'b0;

	assign	mul_wire_out= 	stored0+stored1+stored2+stored3+stored4+stored5+stored6+stored7;

	assign	mul_out 	= 	(   mul_a == 8'h00 ||  mul_b == 8'h00 ) ?    16'h0 :
							((sign[1] == 1'b1) && (sign[0] == 1'b1) && ((mul_a[7] ^ mul_b[7]) == 1'b1)) ? {1'b1,~mul_wire_out[14:0]+1} : 
							((sign[1] == 1'b1) && (sign[0] == 1'b1) && ((mul_a[7] ^ mul_b[7]) == 1'b0)) ? {1'b0, mul_wire_out[14:0]  } : 
							((sign[1] == 1'b1) && (sign[0] == 1'b0) && ((mul_a[7]  			) == 1'b1)) ? {1'b1,~mul_wire_out[14:0]+1} :
							((sign[1] == 1'b1) && (sign[0] == 1'b0) && ((mul_a[7]  			) == 1'b0)) ? {1'b0, mul_wire_out[14:0]  } :
							((sign[1] == 1'b0) && (sign[0] == 1'b1) && ((  			mul_b[7]) == 1'b1)) ? {1'b1,~mul_wire_out[14:0]+1} :
							((sign[1] == 1'b0) && (sign[0] == 1'b1) && ((  			mul_b[7]) == 1'b0)) ? {1'b0, mul_wire_out[14:0]  } : mul_wire_out;

endmodule
