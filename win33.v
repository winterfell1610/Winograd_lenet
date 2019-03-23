`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 10:07:44
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


module win33(
    input  					clk, 
    input 					rst_n,
    input					enable,

    input  		[63:0]		act1,
    input  		[63:0]		act2,
    input  		[63:0]		act3,
    input  		[63:0]		act4,

    input       [47:0]      kernel1,
    input       [47:0]      kernel2,
    input       [47:0]      kernel3,
    
    input 		[ 1:0]		bitwidth,

    output     	[127:0]     f_tmp,

    output  				end_signal_win33
    );

    wire		[63:0] 		v_tmp1;
    wire		[63:0] 		v_tmp2;
    wire		[63:0] 		v_tmp3;
    wire		[63:0] 		v_tmp4;

	wire 		[63:0] 		u_tmp1;
	wire 		[63:0] 		u_tmp2;
	wire 		[63:0] 		u_tmp3;
	wire 		[63:0] 		u_tmp4;

	wire  		[127:0] 	m_tmp1;
	wire  		[127:0] 	m_tmp2;
	wire  		[127:0] 	m_tmp3;
	wire  		[127:0] 	m_tmp4;

	wire 					end_signal_d;
	wire 					end_signal_g;
	wire 					end_signal_mul;


	win33_bdb inst_win33_bdb
		(
			.clk    (clk),
			.rst_n  (rst_n),
			.enable (enable),
			.act1   (act1),
			.act2   (act2),
			.act3   (act3),
			.act4   (act4),
			.bitwidth  (bitwidth),
			.v_tmp1 (v_tmp1),
			.v_tmp2 (v_tmp2),
			.v_tmp3 (v_tmp3),
			.v_tmp4 (v_tmp4),
            .end_signal(end_signal_d)
		);

	win33_g inst_win33_g
		(
			.clk     (clk),
			.rst_n   (rst_n),
			.enable  (enable),
			.kernel1 (kernel1),
			.kernel2 (kernel2),
			.kernel3 (kernel3),
			.bitwidth  (bitwidth),
			.u_tmp1  (u_tmp1),
			.u_tmp2  (u_tmp2),
			.u_tmp3  (u_tmp3),
			.u_tmp4  (u_tmp4),
            .end_signal(end_signal_g)
		);

	win33_mul inst_win33_mul
		(
			.clk    (clk),
			.rst_n  (rst_n),
			.enable (end_signal_d && end_signal_g),
			.v_tmp1 (v_tmp1),
			.v_tmp2 (v_tmp2),
			.v_tmp3 (v_tmp3),
			.v_tmp4 (v_tmp4),
			.u_tmp1 (u_tmp1),
			.u_tmp2 (u_tmp2),
			.u_tmp3 (u_tmp3),
			.u_tmp4 (u_tmp4),
			.m_tmp1 (m_tmp1),
			.m_tmp2 (m_tmp2),
			.m_tmp3 (m_tmp3),
			.m_tmp4 (m_tmp4),
            .end_signal(end_signal_mul)
		);
	win33_a inst_win33_a
		(
			.clk    (clk),
			.rst_n  (rst_n),
			.enable (end_signal_mul),
			.m_tmp1 (m_tmp1),
			.m_tmp2 (m_tmp2),
			.m_tmp3 (m_tmp3),
			.m_tmp4 (m_tmp4),
			.f_tmp  (f_tmp),
            .end_signal(end_signal_win33)
		);

endmodule
