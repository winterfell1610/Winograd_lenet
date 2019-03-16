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


module win33_g(
    input                   clk, 
    input                   rst_n,
    input                   enable,
    input       [47:0]      kernel1,
    input       [47:0]      kernel2,
    input       [47:0]      kernel3,
    //input         [31:0]      psum_in,
    
    //output    reg             end_signal,
    output      [63:0]      u_tmp1,
    output      [63:0]      u_tmp2,
    output      [63:0]      u_tmp3,
    output      [63:0]      u_tmp4
    );

    wire [15:0] g1_1,g1_2,g1_3;
    wire [15:0] g2_1,g2_2,g2_3;
    wire [15:0] g3_1,g3_2,g3_3;

    wire [15:0] b1_1,b1_2,b1_3;
    wire [15:0] b2_1,b2_2,b2_3;
    wire [15:0] b3_1,b3_2,b3_3;
    wire [15:0] b4_1,b4_2,b4_3;

    wire [15:0] u1_1,u1_2,u1_3,u1_4;
    wire [15:0] u2_1,u2_2,u2_3,u2_4;
    wire [15:0] u3_1,u3_2,u3_3,u3_4;
    wire [15:0] u4_1,u4_2,u4_3,u4_4;

    assign {g1_1,g1_2,g1_3} = kernel1;
    assign {g2_1,g2_2,g2_3} = kernel2;
    assign {g3_1,g3_2,g3_3} = kernel3;

    assign {b1_1,b1_2,b1_3} = {g1_1,g1_2,g1_3};

    assign b2_1 = (($signed(g1_1) + $signed(g2_1) + $signed(g3_1))/2);
    assign b2_2 = (($signed(g1_2) + $signed(g2_2) + $signed(g3_2))/2);
    assign b2_3 = (($signed(g1_3) + $signed(g2_3) + $signed(g3_3))/2);

    assign b3_1 = (($signed(g1_1) - $signed(g2_1) + $signed(g3_1))/2);
    assign b3_2 = (($signed(g1_2) - $signed(g2_2) + $signed(g3_2))/2);
    assign b3_3 = (($signed(g1_3) - $signed(g2_3) + $signed(g3_3))/2);

    assign {b4_1,b4_2,b4_3} = {g3_1,g3_2,g3_3};


    assign {u1_1,u2_1,u3_1,u4_1} = {b1_1,b2_1,b3_1,b4_1};

    assign u1_2 = (($signed(b1_1) + $signed(b1_2) + $signed(b1_3))/2);
    assign u2_2 = (($signed(b2_1) + $signed(b2_2) + $signed(b2_3))/2);
    assign u3_2 = (($signed(b3_1) + $signed(b3_2) + $signed(b3_3))/2);
    assign u4_2 = (($signed(b4_1) + $signed(b4_2) + $signed(b4_3))/2);

    assign u1_3 = (($signed(b1_1) - $signed(b1_2) + $signed(b1_3))/2);
    assign u2_3 = (($signed(b2_1) - $signed(b2_2) + $signed(b2_3))/2);
    assign u3_3 = (($signed(b3_1) - $signed(b3_2) + $signed(b3_3))/2);
    assign u4_3 = (($signed(b4_1) - $signed(b4_2) + $signed(b4_3))/2);

    assign {u1_4,u2_4,u3_4,u4_4} = {b1_3,b2_3,b3_3,b4_3};

    assign u_tmp1 = {u1_1,u1_2,u1_3,u1_4};
    assign u_tmp2 = {u2_1,u2_2,u2_3,u2_4};
    assign u_tmp3 = {u3_1,u3_2,u3_3,u3_4};
    assign u_tmp4 = {u4_1,u4_2,u4_3,u4_4};

endmodule
