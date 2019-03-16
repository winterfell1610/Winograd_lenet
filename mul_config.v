`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/01 08:55:52
// Design Name: 
// Module Name: mul_config
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


module mul_config #(
		integer M = 8,
		integer N = 8
	)
	(
	 input			[M-1:0]		MUL_a,
	 input			[N-1:0]		MUL_b,
	 output	reg		[M+N-1:0]	res
	 );

	always @(MUL_a, MUL_b)	begin						//	Do the multiply any time the inputs change
		if(MUL_a[M-1] == MUL_b[N-1])
				res[M+N-1] <= 0;
		else 
				res[M+N-1] <= 1;

		res[M+N-2:0] <= $signed(MUL_a[M-2:0]) * $signed(MUL_b[N-2:0]);	//	Removing the sign bits from the multiply - that 														//	reset overflow flag to zero
	end

endmodule