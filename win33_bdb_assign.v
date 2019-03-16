`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/02 19:29:01
// Design Name: 
// Module Name: win33
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


module win33_bdb(
    input  					clk, 
    input 					rst_n,
    input					enable,
    input  		[15:0]		kernel,
    input  		[63:0]		act1,
    input  		[63:0]		act2,
    input  		[63:0]		act3,
    input  		[63:0]		act4,
    //input  		[31:0] 		psum_in,
    
    //output	reg		 		end_signal,
    output 		[63:0] 		v_tmp1,
    output		[63:0] 		v_tmp2,
    output		[63:0] 		v_tmp3,
    output		[63:0] 		v_tmp4
    );

	wire [15:0] d1_1,d1_2,d1_3,d1_4;
	wire [15:0] d2_1,d2_2,d2_3,d2_4;
	wire [15:0] d3_1,d3_2,d3_3,d3_4;
	wire [15:0] d4_1,d4_2,d4_3,d4_4;

	wire [15:0] b1_1,b1_2,b1_3,b1_4;
	wire [15:0] b2_1,b2_2,b2_3,b2_4;
	wire [15:0] b3_1,b3_2,b3_3,b3_4;
	wire [15:0] b4_1,b4_2,b4_3,b4_4;

	wire [15:0] v1_1,v1_2,v1_3,v1_4;
	wire [15:0] v2_1,v2_2,v2_3,v2_4;
	wire [15:0] v3_1,v3_2,v3_3,v3_4;
	wire [15:0] v4_1,v4_2,v4_3,v4_4;

	assign {d1_1,d1_2,d1_3,d1_4} = act1;
	assign {d2_1,d2_2,d2_3,d2_4} = act2;
	assign {d3_1,d3_2,d3_3,d3_4} = act3;
	assign {d4_1,d4_2,d4_3,d4_4} = act4;

	assign b1_1 = $signed(d1_1) - $signed(d3_1);
	assign b1_2 = $signed(d1_2) - $signed(d3_2);
	assign b1_3 = $signed(d1_3) - $signed(d3_3);
	assign b1_4 = $signed(d1_4) - $signed(d3_4);

	assign b2_1 = $signed(d2_1) + $signed(d3_1);
	assign b2_2 = $signed(d2_2) + $signed(d3_2);
	assign b2_3 = $signed(d2_3) + $signed(d3_3);
	assign b2_4 = $signed(d2_4) + $signed(d3_4);

	assign b3_1 = $signed(d3_1) - $signed(d2_1);
	assign b3_2 = $signed(d3_2) - $signed(d2_2);
	assign b3_3 = $signed(d3_3) - $signed(d2_3);
	assign b3_4 = $signed(d3_4) - $signed(d2_4);

	assign b4_1 = $signed(d2_1) - $signed(d4_1);
	assign b4_2 = $signed(d2_2) - $signed(d4_2);
	assign b4_3 = $signed(d2_3) - $signed(d4_3);
	assign b4_4 = $signed(d2_4) - $signed(d4_4);



	assign v1_1 = $signed(b1_1) - $signed(b1_3);
	assign v2_1 = $signed(b2_1) - $signed(b2_3);
	assign v3_1 = $signed(b3_1) - $signed(b3_3);
	assign v4_1 = $signed(b4_1) - $signed(b4_3);

	assign v1_2 = $signed(b1_2) + $signed(b1_3);
	assign v2_2 = $signed(b2_2) + $signed(b2_3);
	assign v3_2 = $signed(b3_2) + $signed(b3_3);
	assign v4_2 = $signed(b4_2) + $signed(b4_3);

	assign v1_3 = $signed(b1_3) - $signed(b1_2);
	assign v2_3 = $signed(b2_3) - $signed(b2_2);
	assign v3_3 = $signed(b3_3) - $signed(b3_2);
	assign v4_3 = $signed(b4_3) - $signed(b4_2);

	assign v1_4 = $signed(b1_2) - $signed(b1_4);
	assign v2_4 = $signed(b2_2) - $signed(b2_4);
	assign v3_4 = $signed(b3_2) - $signed(b3_4);
	assign v4_4 = $signed(b4_2) - $signed(b4_4);

	assign v_tmp1 = {v1_1,v1_2,v1_3,v1_4};
	assign v_tmp2 = {v2_1,v2_2,v2_3,v2_4};
	assign v_tmp3 = {v3_1,v3_2,v3_3,v3_4};
	assign v_tmp4 = {v4_1,v4_2,v4_3,v4_4};

endmodule
