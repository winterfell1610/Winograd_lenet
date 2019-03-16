`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 10:08:48
// Design Name: 
// Module Name: winPE_array
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


module winPE_array(
	input					clk,
	input 					rst_n,
	input 					enable,

	input 					enable_1,
	input 					enable_2,
	input 					enable_3,
	input 					enable_4,
	input 					enable_5,
	input 					enable_6,

	input			[399:0]	kernel_1,
	input			[399:0]	kernel_2,
	input			[399:0]	kernel_3,
	input			[399:0]	kernel_4,
	input			[399:0]	kernel_5,
	input			[399:0]	kernel_6,

	input			[575:0]	act,

	input			[127:0]	psum_in_1,
	input			[127:0]	psum_in_2,
	input			[127:0]	psum_in_3,
	input			[127:0]	psum_in_4,
	input			[127:0]	psum_in_5,
	input			[127:0]	psum_in_6,

	output	wire			end_signal_1,
	output	wire			end_signal_2,
	output	wire			end_signal_3,
	output	wire			end_signal_4,
	output	wire			end_signal_5,
	output	wire			end_signal_6,

	//output	wire	[63:0]	result_1_16
	output	wire	[63:0]	result_1,
	output	wire	[63:0]	result_2,
	output	wire	[63:0]	result_3,
	output	wire	[63:0]	result_4,
	output	wire	[63:0]	result_5,
	output	wire	[63:0]	result_6
);

wire 				[31:0]	win1_result1 ,win1_result2;
wire 				[31:0]	win1_result3 ,win1_result4;

wire 				[15:0]	win1_16_result1 ,win1_16_result2;
wire 				[15:0]	win1_16_result3 ,win1_16_result4;

wire 				[15:0]	win1_out1_1_16 ;

wire 				[15:0]	win1_out2_1_16 ,win1_out3_1_16;
wire 				[15:0]	win1_out4_1_16 ;

wire 				[127:0] win1_out1;
wire 				[127:0] win1_out2;
wire 				[127:0] win1_out3;
wire 				[127:0] win1_out4;
wire					    win1_end1 ,win1_end2 ,win1_end3 ,win1_end4 ;

win33 inst_win1_1(clk,rst_n,(enable&&enable_1),act[575:512],act[479:416],act[383:320],act[287:224],
								kernel_1[399:352],kernel_1[319:272],kernel_1[239:192],win1_out1,win1_end1);
win33 inst_win1_2(clk,rst_n,(enable&&enable_1),act[383:320],act[287:224],act[191:128],act[ 95: 32],
								48'h0		   ,kernel_1[159:112],kernel_1[ 79: 32],win1_out2,win1_end2);
win33 inst_win1_3(clk,rst_n,(enable&&enable_1),act[543:480],act[447:384],act[351:288],act[255:192],
								{16'h0,kernel_1[351:320]},{16'h0,kernel_1[271:240]},{16'h0,kernel_1[191:160]},win1_out3,win1_end3);
win33 inst_win1_4(clk,rst_n,(enable&&enable_1),act[351:288],act[255:192],act[159: 96],act[ 63:  0],
								48'h0 ,{16'h0,kernel_1[111:80]},{16'h0,kernel_1[31:0]},win1_out4,win1_end4);

assign win1_result4 = $signed(win1_out1[127:96]) + $signed(win1_out2[127:96]) + $signed(win1_out3[127:96]) + $signed(win1_out4[127:96]) + $signed(psum_in_1[127:96]); 
assign win1_result3 = $signed(win1_out1[ 95:64]) + $signed(win1_out2[ 95:64]) + $signed(win1_out3[ 95:64]) + $signed(win1_out4[ 95:64]) + $signed(psum_in_1[ 95:64]); 
assign win1_result2 = $signed(win1_out1[ 63:32]) + $signed(win1_out2[ 63:32]) + $signed(win1_out3[ 63:32]) + $signed(win1_out4[ 63:32]) + $signed(psum_in_1[ 63:32]); 
assign win1_result1 = $signed(win1_out1[ 31: 0]) + $signed(win1_out2[ 31: 0]) + $signed(win1_out3[ 31: 0]) + $signed(win1_out4[ 31: 0]) + $signed(psum_in_1[ 31: 0]); 

assign win1_16_result1 	= 	{win1_result1[31],win1_result1[29:15]};
assign win1_16_result2 	= 	{win1_result2[31],win1_result2[29:15]};
assign win1_16_result3	= 	{win1_result3[31],win1_result3[29:15]};
assign win1_16_result4 	= 	{win1_result4[31],win1_result4[29:15]};

assign win1_out1_1_16[15:0] 	= 	{win1_out1[31],win1_out1[29:15]};
assign win1_out2_1_16[15:0] 	= 	{win1_out2[31],win1_out2[29:15]};
assign win1_out3_1_16[15:0] 	= 	{win1_out3[31],win1_out3[29:15]};
assign win1_out4_1_16[15:0] 	= 	{win1_out4[31],win1_out4[29:15]};


assign result_1   = {win1_16_result4,win1_16_result3,win1_16_result2,win1_16_result1};

assign end_signal_1 = {win1_end1 && win1_end2 && win1_end3 && win1_end4};

wire 				[31:0]	win2_result1 ,win2_result2;
wire 				[31:0]	win2_result3 ,win2_result4;

wire 				[15:0]	win2_16_result1 ,win2_16_result2;
wire 				[15:0]	win2_16_result3 ,win2_16_result4;

wire 				[15:0]	win2_out1_1_16 ;

wire 				[15:0]	win2_out2_1_16 ,win2_out3_1_16;
wire 				[15:0]	win2_out4_1_16 ;

wire 				[127:0] win2_out1;
wire 				[127:0] win2_out2;
wire 				[127:0] win2_out3;
wire 				[127:0] win2_out4;
wire					    win2_end1 ,win2_end2 ,win2_end3 ,win2_end4 ;

win33 inst_win2_1(clk,rst_n,(enable&&enable_2),act[575:512],act[479:416],act[383:320],act[287:224],
								kernel_2[399:352],kernel_2[319:272],kernel_2[239:192],win2_out1,win2_end1);
win33 inst_win2_2(clk,rst_n,(enable&&enable_2),act[383:320],act[287:224],act[191:128],act[ 95: 32],
								48'h0		   ,kernel_2[159:112],kernel_2[ 79: 32],win2_out2,win2_end2);
win33 inst_win2_3(clk,rst_n,(enable&&enable_2),act[543:480],act[447:384],act[351:288],act[255:192],
								{16'h0,kernel_2[351:320]},{16'h0,kernel_2[271:240]},{16'h0,kernel_2[191:160]},win2_out3,win2_end3);
win33 inst_win2_4(clk,rst_n,(enable&&enable_2),act[351:288],act[255:192],act[159: 96],act[ 63:  0],
								48'h0 ,{16'h0,kernel_2[111:80]},{16'h0,kernel_2[31:0]},win2_out4,win2_end4);

assign win2_result4 = $signed(win2_out1[127:96]) + $signed(win2_out2[127:96]) + $signed(win2_out3[127:96]) + $signed(win2_out4[127:96]) + $signed(psum_in_2[127:96]); 
assign win2_result3 = $signed(win2_out1[ 95:64]) + $signed(win2_out2[ 95:64]) + $signed(win2_out3[ 95:64]) + $signed(win2_out4[ 95:64]) + $signed(psum_in_2[ 95:64]); 
assign win2_result2 = $signed(win2_out1[ 63:32]) + $signed(win2_out2[ 63:32]) + $signed(win2_out3[ 63:32]) + $signed(win2_out4[ 63:32]) + $signed(psum_in_2[ 63:32]); 
assign win2_result1 = $signed(win2_out1[ 31: 0]) + $signed(win2_out2[ 31: 0]) + $signed(win2_out3[ 31: 0]) + $signed(win2_out4[ 31: 0]) + $signed(psum_in_2[ 31: 0]); 

assign win2_16_result1 	= 	{win2_result1[31],win2_result1[29:15]};
assign win2_16_result2 	= 	{win2_result2[31],win2_result2[29:15]};
assign win2_16_result3 	= 	{win2_result3[31],win2_result3[29:15]};
assign win2_16_result4 	= 	{win2_result4[31],win2_result4[29:15]};

assign win2_out1_1_16[15:0] 	= 	{win2_out1[31],win2_out1[29:15]};
assign win2_out2_1_16[15:0] 	= 	{win2_out2[31],win2_out2[29:15]};
assign win2_out3_1_16[15:0] 	= 	{win2_out3[31],win2_out3[29:15]};
assign win2_out4_1_16[15:0] 	= 	{win2_out4[31],win2_out4[29:15]};


assign result_2   = {win2_16_result4,win2_16_result3,win2_16_result2,win2_16_result1};

assign end_signal_2 = {win2_end1 && win2_end2 && win2_end3 && win2_end4};


wire 				[31:0]	win3_result1 ,win3_result2;
wire 				[31:0]	win3_result3 ,win3_result4;

wire 				[15:0]	win3_16_result1 ,win3_16_result2;
wire 				[15:0]	win3_16_result3 ,win3_16_result4;

wire 				[15:0]	win3_out1_1_16 ;
wire 				[15:0]	win3_out2_1_16 ,win3_out3_1_16;
wire 				[15:0]	win3_out4_1_16 ;

wire 				[127:0] win3_out1;
wire 				[127:0] win3_out2;
wire 				[127:0] win3_out3;
wire 				[127:0] win3_out4;
wire					    win3_end1 ,win3_end2 ,win3_end3 ,win3_end4 ;

win33 inst_win3_1(clk,rst_n,(enable&&enable_3),act[575:512],act[479:416],act[383:320],act[287:224],
								kernel_3[399:352],kernel_3[319:272],kernel_3[239:192],win3_out1,win3_end1);
win33 inst_win3_2(clk,rst_n,(enable&&enable_3),act[383:320],act[287:224],act[191:128],act[ 95: 32],
								48'h0		   ,kernel_3[159:112],kernel_3[ 79: 32],win3_out2,win3_end2);
win33 inst_win3_3(clk,rst_n,(enable&&enable_3),act[543:480],act[447:384],act[351:288],act[255:192],
								{16'h0,kernel_3[351:320]},{16'h0,kernel_3[271:240]},{16'h0,kernel_3[191:160]},win3_out3,win3_end3);
win33 inst_win3_4(clk,rst_n,(enable&&enable_3),act[351:288],act[255:192],act[159: 96],act[ 63:  0],
								48'h0 ,{16'h0,kernel_3[111:80]},{16'h0,kernel_3[31:0]},win3_out4,win3_end4);

assign win3_result4 = $signed(win3_out1[127:96]) + $signed(win3_out2[127:96]) + $signed(win3_out3[127:96]) + $signed(win3_out4[127:96]) + $signed(psum_in_3[127:96]); 
assign win3_result3 = $signed(win3_out1[ 95:64]) + $signed(win3_out2[ 95:64]) + $signed(win3_out3[ 95:64]) + $signed(win3_out4[ 95:64]) + $signed(psum_in_3[ 95:64]); 
assign win3_result2 = $signed(win3_out1[ 63:32]) + $signed(win3_out2[ 63:32]) + $signed(win3_out3[ 63:32]) + $signed(win3_out4[ 63:32]) + $signed(psum_in_3[ 63:32]); 
assign win3_result1 = $signed(win3_out1[ 31: 0]) + $signed(win3_out2[ 31: 0]) + $signed(win3_out3[ 31: 0]) + $signed(win3_out4[ 31: 0]) + $signed(psum_in_3[ 31: 0]); 

assign win3_16_result1 	= 	{win3_result1[31],win3_result1[29:15]};
assign win3_16_result2 	= 	{win3_result2[31],win3_result2[29:15]};
assign win3_16_result3 	= 	{win3_result3[31],win3_result3[29:15]};
assign win3_16_result4 	= 	{win3_result4[31],win3_result4[29:15]};

assign win3_out1_1_16[15:0] 	= 	{win3_out1[31],win3_out1[29:15]};
assign win3_out2_1_16[15:0] 	= 	{win3_out2[31],win3_out2[29:15]};
assign win3_out3_1_16[15:0] 	= 	{win3_out3[31],win3_out3[29:15]};
assign win3_out4_1_16[15:0] 	= 	{win3_out4[31],win3_out4[29:15]};


assign result_3   = {win3_16_result4,win3_16_result3,win3_16_result2,win3_16_result1};

assign end_signal_3 = {win3_end1 && win3_end2 && win3_end3 && win3_end4};
wire 				[31:0]	win4_result1 ,win4_result2;
wire 				[31:0]	win4_result3 ,win4_result4;

wire 				[15:0]	win4_16_result1 ,win4_16_result2;
wire 				[15:0]	win4_16_result3 ,win4_16_result4;

wire 				[15:0]	win4_out1_1_16 ;
wire 				[15:0]	win4_out2_1_16 ,win4_out3_1_16;
wire 				[15:0]	win4_out4_1_16 ;

wire 				[127:0] win4_out1;
wire 				[127:0] win4_out2;
wire 				[127:0] win4_out3;
wire 				[127:0] win4_out4;
wire					    win4_end1 ,win4_end2 ,win4_end3 ,win4_end4 ;

win33 inst_win4_1(clk,rst_n,(enable&&enable_4),act[575:512],act[479:416],act[383:320],act[287:224],
								kernel_4[399:352],kernel_4[319:272],kernel_4[239:192],win4_out1,win4_end1);
win33 inst_win4_2(clk,rst_n,(enable&&enable_4),act[383:320],act[287:224],act[191:128],act[ 95: 32],
								48'h0		   ,kernel_4[159:112],kernel_4[ 79: 32],win4_out2,win4_end2);
win33 inst_win4_3(clk,rst_n,(enable&&enable_4),act[543:480],act[447:384],act[351:288],act[255:192],
								{16'h0,kernel_4[351:320]},{16'h0,kernel_4[271:240]},{16'h0,kernel_4[191:160]},win4_out3,win4_end3);
win33 inst_win4_4(clk,rst_n,(enable&&enable_4),act[351:288],act[255:192],act[159: 96],act[ 63:  0],
								48'h0 ,{16'h0,kernel_4[111:80]},{16'h0,kernel_4[31:0]},win4_out4,win4_end4);

assign win4_result4 = $signed(win4_out1[127:96]) + $signed(win4_out2[127:96]) + $signed(win4_out3[127:96]) + $signed(win4_out4[127:96]) + $signed(psum_in_4[127:96]); 
assign win4_result3 = $signed(win4_out1[ 95:64]) + $signed(win4_out2[ 95:64]) + $signed(win4_out3[ 95:64]) + $signed(win4_out4[ 95:64]) + $signed(psum_in_4[ 95:64]); 
assign win4_result2 = $signed(win4_out1[ 63:32]) + $signed(win4_out2[ 63:32]) + $signed(win4_out3[ 63:32]) + $signed(win4_out4[ 63:32]) + $signed(psum_in_4[ 63:32]); 
assign win4_result1 = $signed(win4_out1[ 31: 0]) + $signed(win4_out2[ 31: 0]) + $signed(win4_out3[ 31: 0]) + $signed(win4_out4[ 31: 0]) + $signed(psum_in_4[ 31: 0]); 

assign win4_16_result1 	= 	{win4_result1[31],win4_result1[29:15]};
assign win4_16_result2 	= 	{win4_result2[31],win4_result2[29:15]};
assign win4_16_result3 	= 	{win4_result3[31],win4_result3[29:15]};
assign win4_16_result4 	= 	{win4_result4[31],win4_result4[29:15]};

assign win4_out1_1_16[15:0] 	= 	{win4_out1[31],win4_out1[29:15]};
assign win4_out2_1_16[15:0] 	= 	{win4_out2[31],win4_out2[29:15]};
assign win4_out3_1_16[15:0] 	= 	{win4_out3[31],win4_out3[29:15]};
assign win4_out4_1_16[15:0] 	= 	{win4_out4[31],win4_out4[29:15]};

assign result_4   = {win4_16_result4,win4_16_result3,win4_16_result2,win4_16_result1};

assign end_signal_4 = {win4_end1 && win4_end2 && win4_end3 && win4_end4};


wire 				[31:0]	win5_result1 ,win5_result2;
wire 				[31:0]	win5_result3 ,win5_result4;

wire 				[15:0]	win5_16_result1 ,win5_16_result2;
wire 				[15:0]	win5_16_result3 ,win5_16_result4;

wire 				[15:0]	win5_out1_1_16 ;
wire 				[15:0]	win5_out2_1_16 ,win5_out3_1_16;
wire 				[15:0]	win5_out4_1_16 ;

wire 				[127:0] win5_out1;
wire 				[127:0] win5_out2;
wire 				[127:0] win5_out3;
wire 				[127:0] win5_out4;
wire					    win5_end1 ,win5_end2 ,win5_end3 ,win5_end4 ;

win33 inst_win5_1(clk,rst_n,(enable&&enable_5),act[575:512],act[479:416],act[383:320],act[287:224],
								kernel_5[399:352],kernel_5[319:272],kernel_5[239:192],win5_out1,win5_end1);
win33 inst_win5_2(clk,rst_n,(enable&&enable_5),act[383:320],act[287:224],act[191:128],act[ 95: 32],
								48'h0		   ,kernel_5[159:112],kernel_5[ 79: 32],win5_out2,win5_end2);
win33 inst_win5_3(clk,rst_n,(enable&&enable_5),act[543:480],act[447:384],act[351:288],act[255:192],
								{16'h0,kernel_5[351:320]},{16'h0,kernel_5[271:240]},{16'h0,kernel_5[191:160]},win5_out3,win5_end3);
win33 inst_win5_4(clk,rst_n,(enable&&enable_5),act[351:288],act[255:192],act[159: 96],act[ 63:  0],
								48'h0 ,{16'h0,kernel_5[111:80]},{16'h0,kernel_5[31:0]},win5_out4,win5_end4);

assign win5_result4 = $signed(win5_out1[127:96]) + $signed(win5_out2[127:96]) + $signed(win5_out3[127:96]) + $signed(win5_out4[127:96]) + $signed(psum_in_5[127:96]); 
assign win5_result3 = $signed(win5_out1[ 95:64]) + $signed(win5_out2[ 95:64]) + $signed(win5_out3[ 95:64]) + $signed(win5_out4[ 95:64]) + $signed(psum_in_5[ 95:64]); 
assign win5_result2 = $signed(win5_out1[ 63:32]) + $signed(win5_out2[ 63:32]) + $signed(win5_out3[ 63:32]) + $signed(win5_out4[ 63:32]) + $signed(psum_in_5[ 63:32]); 
assign win5_result1 = $signed(win5_out1[ 31: 0]) + $signed(win5_out2[ 31: 0]) + $signed(win5_out3[ 31: 0]) + $signed(win5_out4[ 31: 0]) + $signed(psum_in_5[ 31: 0]); 

assign win5_16_result1 	= 	{win5_result1[31],win5_result1[29:15]};
assign win5_16_result2 	= 	{win5_result2[31],win5_result2[29:15]};
assign win5_16_result3 	= 	{win5_result3[31],win5_result3[29:15]};
assign win5_16_result4 	= 	{win5_result4[31],win5_result4[29:15]};

assign win5_out1_1_16[15:0] 	= 	{win5_out1[31],win5_out1[29:15]};
assign win5_out2_1_16[15:0] 	= 	{win5_out2[31],win5_out2[29:15]};
assign win5_out3_1_16[15:0] 	= 	{win5_out3[31],win5_out3[29:15]};
assign win5_out4_1_16[15:0] 	= 	{win5_out4[31],win5_out4[29:15]};

assign result_5   = {win5_16_result4,win5_16_result3,win5_16_result2,win5_16_result1};
assign end_signal_5 = {win5_end1 && win5_end2 && win5_end3 && win5_end4};

wire 				[31:0]	win6_result1 ,win6_result2;
wire 				[31:0]	win6_result3 ,win6_result4;

wire 				[15:0]	win6_16_result1 ,win6_16_result2;
wire 				[15:0]	win6_16_result3 ,win6_16_result4;

wire 				[15:0]	win6_out1_1_16 ;
wire 				[15:0]	win6_out2_1_16 ,win6_out3_1_16;
wire 				[15:0]	win6_out4_1_16 ;

wire 				[127:0] win6_out1;
wire 				[127:0] win6_out2;
wire 				[127:0] win6_out3;
wire 				[127:0] win6_out4;
wire					    win6_end1 ,win6_end2 ,win6_end3 ,win6_end4 ;

win33 inst_win6_1(clk,rst_n,(enable&&enable_6),act[575:512],act[479:416],act[383:320],act[287:224],
								kernel_6[399:352],kernel_6[319:272],kernel_6[239:192],win6_out1,win6_end1);
win33 inst_win6_2(clk,rst_n,(enable&&enable_6),act[383:320],act[287:224],act[191:128],act[ 95: 32],
								48'h0		   ,kernel_6[159:112],kernel_6[ 79: 32],win6_out2,win6_end2);
win33 inst_win6_3(clk,rst_n,(enable&&enable_6),act[543:480],act[447:384],act[351:288],act[255:192],
								{16'h0,kernel_6[351:320]},{16'h0,kernel_6[271:240]},{16'h0,kernel_6[191:160]},win6_out3,win6_end3);
win33 inst_win6_4(clk,rst_n,(enable&&enable_6),act[351:288],act[255:192],act[159: 96],act[ 63:  0],
								48'h0 ,{16'h0,kernel_6[111:80]},{16'h0,kernel_6[31:0]},win6_out4,win6_end4);

/*
assign win6_result4 = $signed(win6_out1[127:96]) + $signed(win6_out2[127:96]) + $signed(win6_out3[127:96]) + $signed(win6_out4[127:96]) + $signed(psum_in_6[127:96]); 
assign win6_result3 = $signed(win6_out1[ 95:64]) + $signed(win6_out2[ 95:64]) + $signed(win6_out3[ 95:64]) + $signed(win6_out4[ 95:64]) + $signed(psum_in_6[ 95:64]); 
assign win6_result2 = $signed(win6_out1[ 63:32]) + $signed(win6_out2[ 63:32]) + $signed(win6_out3[ 63:32]) + $signed(win6_out4[ 63:32]) + $signed(psum_in_6[ 63:32]); 
assign win6_result1 = $signed(win6_out1[ 31: 0]) + $signed(win6_out2[ 31: 0]) + $signed(win6_out3[ 31: 0]) + $signed(win6_out4[ 31: 0]) + $signed(psum_in_6[ 31: 0]); 

assign win6_16_result1 	= 	{win6_result1[31],win6_result1[29:15]};
assign win6_16_result2 	= 	{win6_result2[31],win6_result2[29:15]};
assign win6_16_result3 	= 	{win6_result3[31],win6_result3[29:15]};
assign win6_16_result4 	= 	{win6_result4[31],win6_result4[29:15]};

assign win6_out1_1_16[15:0] 	= 	{win6_out1[31],win6_out1[29:15]};
assign win6_out2_1_16[15:0] 	= 	{win6_out2[31],win6_out2[29:15]};
assign win6_out3_1_16[15:0] 	= 	{win6_out3[31],win6_out3[29:15]};
assign win6_out4_1_16[15:0] 	= 	{win6_out4[31],win6_out4[29:15]};

assign result_6   = {win6_16_result4,win6_16_result3,win6_16_result2,win6_16_result1};
assign end_signal_6 = {win6_end1 && win6_end2 && win6_end3 && win6_end4};

assign data1_1_max 		= ($signed(result_1[63:48])>=$signed(result_1[47:32]))?result_1[63:48]:result_1[47:32];
assign data1_2_max 		= ($signed(result_1[31:16])>=$signed(result_1[15: 0]))?result_1[31:16]:result_1[15: 0];
assign data1_pool_max   = ($signed(data1_1_max)>=$signed(data1_2_max))?data1_1_max:data1_2_max;

assign data2_1_max 		= ($signed(result_2[63:48])>=$signed(result_2[47:32]))?result_2[63:48]:result_2[47:32];
assign data2_2_max 		= ($signed(result_2[31:16])>=$signed(result_2[15: 0]))?result_2[31:16]:result_2[15: 0];
assign data2_pool_max   = ($signed(data2_1_max)>=$signed(data2_2_max))?data2_1_max:data2_2_max;

assign data3_1_max 		= ($signed(result_3[63:48])>=$signed(result_3[47:32]))?result_3[63:48]:result_3[47:32];
assign data3_2_max 		= ($signed(result_3[31:16])>=$signed(result_3[15: 0]))?result_3[31:16]:result_3[15: 0];
assign data3_pool_max   = ($signed(data3_1_max)>=$signed(data3_2_max))?data3_1_max:data3_2_max;

assign data4_1_max 		= ($signed(result_4[63:48])>=$signed(result_4[47:32]))?result_4[63:48]:result_4[47:32];
assign data4_2_max 		= ($signed(result_4[31:16])>=$signed(result_4[15: 0]))?result_4[31:16]:result_4[15: 0];
assign data4_pool_max   = ($signed(data4_1_max)>=$signed(data4_2_max))?data4_1_max:data4_2_max;

assign data5_1_max 		= ($signed(result_5[63:48])>=$signed(result_5[47:32]))?result_5[63:48]:result_5[47:32];
assign data5_2_max 		= ($signed(result_5[31:16])>=$signed(result_5[15: 0]))?result_5[31:16]:result_5[15: 0];
assign data5_pool_max   = ($signed(data5_1_max)>=$signed(data5_2_max))?data5_1_max:data5_2_max;

assign data6_1_max 		= ($signed(result_6[63:48])>=$signed(result_6[47:32]))?result_6[63:48]:result_6[47:32];
assign data6_2_max 		= ($signed(result_6[31:16])>=$signed(result_6[15: 0]))?result_6[31:16]:result_6[15: 0];
assign data6_pool_max   = ($signed(data6_1_max)>=$signed(data6_2_max))?data6_1_max:data6_2_max;


assign dout1_relu = (data1_pool_max[15] == 1'b0)? data1_pool_max[15:0] : 16'h0000;
assign dout2_relu = (data2_pool_max[15] == 1'b0)? data2_pool_max[15:0] : 16'h0000;
assign dout3_relu = (data3_pool_max[15] == 1'b0)? data3_pool_max[15:0] : 16'h0000;
assign dout4_relu = (data4_pool_max[15] == 1'b0)? data4_pool_max[15:0] : 16'h0000;
assign dout5_relu = (data5_pool_max[15] == 1'b0)? data5_pool_max[15:0] : 16'h0000;
assign dout6_relu = (data6_pool_max[15] == 1'b0)? data6_pool_max[15:0] : 16'h0000;
*/
endmodule

