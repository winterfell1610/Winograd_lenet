`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: gc
// 
// Create Date: 2019/03/03 18:39:07
// Design Name: 
// Module Name: win33_a
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


module win33_a(
    input  					clk, 
    input 					rst_n,
    input					enable,

    input  		[63:0]		m_tmp1,
    input  		[63:0]		m_tmp2,
    input  		[63:0]		m_tmp3,
    input  		[63:0]		m_tmp4,

    output      [31:0]      f_tmp1,
    output      [31:0]      f_tmp2
    );

	wire [15:0] m1_1,m1_2,m1_3,m1_4;
	wire [15:0] m2_1,m2_2,m2_3,m2_4;
	wire [15:0] m3_1,m3_2,m3_3,m3_4;
	wire [15:0] m4_1,m4_2,m4_3,m4_4;

	wire [15:0] v1_1,v1_2,v1_3,v1_4;
	wire [15:0] v2_1,v2_2,v2_3,v2_4;

    wire [15:0] f1_1,f1_2;
    wire [15:0] f2_1,f2_2;

	assign {m1_1,m1_2,m1_3,m1_4} = m_tmp1;
	assign {m2_1,m2_2,m2_3,m2_4} = m_tmp2;
	assign {m3_1,m3_2,m3_3,m3_4} = m_tmp3;
	assign {m4_1,m4_2,m4_3,m4_4} = m_tmp4;

	assign v1_1 = (enable == 0) ? 0 :($signed(m1_1) + $signed(m2_1) + $signed(m3_1));
	assign v1_2 = (enable == 0) ? 0 :($signed(m1_2) + $signed(m2_2) + $signed(m3_2));
	assign v1_3 = (enable == 0) ? 0 :($signed(m1_3) + $signed(m2_3) + $signed(m3_3));
	assign v1_4 = (enable == 0) ? 0 :($signed(m1_4) + $signed(m2_4) + $signed(m3_4));

	assign v2_1 = (enable == 0) ? 0 :($signed(m2_1) - $signed(m3_1) - $signed(m4_1));
	assign v2_2 = (enable == 0) ? 0 :($signed(m2_2) - $signed(m3_2) - $signed(m4_2));
	assign v2_3 = (enable == 0) ? 0 :($signed(m2_3) - $signed(m3_3) - $signed(m4_3));
	assign v2_4 = (enable == 0) ? 0 :($signed(m2_4) - $signed(m3_4) - $signed(m4_4));


	assign f1_1 = (enable == 0) ? 0 :($signed(v1_1) + $signed(v1_2) + $signed(v1_3));
	assign f2_1 = (enable == 0) ? 0 :($signed(v2_1) + $signed(v2_2) + $signed(v2_3));

	assign f1_2 = (enable == 0) ? 0 :($signed(v1_2) - $signed(v1_3) - $signed(v1_4));
	assign f2_2 = (enable == 0) ? 0 :($signed(v2_2) - $signed(v2_3) - $signed(v2_4));

	assign f_tmp1 = {f1_1,f1_2};
	assign f_tmp2 = {f2_1,f2_2};

endmodule
