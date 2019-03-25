`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/03 20:28:52
// Design Name: 
// Module Name: win33_mul
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
`include "defines.v"


module win33_mul(
    input  					clk, 
    input 					rst_n,
    input					enable,
    input       [ 1:0]      bitwidth,
    input  		[63:0]		v_tmp1,
    input  		[63:0]		v_tmp2,
    input  		[63:0]		v_tmp3,
    input  		[63:0]		v_tmp4,
    //input  		[31:0] 		psum_in,
    
    //output	reg		 		end_signal,
    input  		[63:0]		u_tmp1,
    input  		[63:0]		u_tmp2,
    input  		[63:0]		u_tmp3,
    input  		[63:0]		u_tmp4,
    /*
    output   reg   [127:0]      m_tmp1,
    output   reg   [127:0]      m_tmp2,
    output   reg   [127:0]      m_tmp3,
    output   reg   [127:0]      m_tmp4,
    */
    output   reg   [255:0]      m_tmp1,
    output   reg   [255:0]      m_tmp2,
    output   reg   [255:0]      m_tmp3,
    output   reg   [255:0]      m_tmp4,
    output   reg                end_signal
    );

	wire [15:0] v1_1,v1_2,v1_3,v1_4;
	wire [15:0] v2_1,v2_2,v2_3,v2_4;
	wire [15:0] v3_1,v3_2,v3_3,v3_4;
	wire [15:0] v4_1,v4_2,v4_3,v4_4;

    wire [15:0] u1_1,u1_2,u1_3,u1_4;
    wire [15:0] u2_1,u2_2,u2_3,u2_4;
    wire [15:0] u3_1,u3_2,u3_3,u3_4;
    wire [15:0] u4_1,u4_2,u4_3,u4_4;

    /*
	wire  [31:0] m1_1,m1_2,m1_3,m1_4;
	wire  [31:0] m2_1,m2_2,m2_3,m2_4;
	wire  [31:0] m3_1,m3_2,m3_3,m3_4;
	wire  [31:0] m4_1,m4_2,m4_3,m4_4;

    reg  [31:0] m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4;
    reg  [31:0] m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4;
    reg  [31:0] m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4;
    reg  [31:0] m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4;
    */
    wire  [63:0] m1_1,m1_2,m1_3,m1_4;
    wire  [63:0] m2_1,m2_2,m2_3,m2_4;
    wire  [63:0] m3_1,m3_2,m3_3,m3_4;
    wire  [63:0] m4_1,m4_2,m4_3,m4_4;

    reg  [63:0] m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4;
    reg  [63:0] m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4;
    reg  [63:0] m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4;
    reg  [63:0] m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4;

	assign {v1_1,v1_2,v1_3,v1_4} = v_tmp1;
	assign {v2_1,v2_2,v2_3,v2_4} = v_tmp2;
	assign {v3_1,v3_2,v3_3,v3_4} = v_tmp3;
	assign {v4_1,v4_2,v4_3,v4_4} = v_tmp4;

	assign {u1_1,u1_2,u1_3,u1_4} = u_tmp1;
	assign {u2_1,u2_2,u2_3,u2_4} = u_tmp2;
	assign {u3_1,u3_2,u3_3,u3_4} = u_tmp3;
	assign {u4_1,u4_2,u4_3,u4_4} = u_tmp4;

    win_mul_16_signed inst1_win_mul_16_signed (v1_1,u1_1,bitwidth,m1_1[63:32]);
    win_mul_16_signed inst2_win_mul_16_signed (v1_2,u1_2,bitwidth,m1_1[31: 0]);
    win_mul_16_signed inst3_win_mul_16_signed (v1_3,u1_3,bitwidth,m1_2[63:32]);
    win_mul_16_signed inst4_win_mul_16_signed (v1_4,u1_4,bitwidth,m1_2[31: 0]);
    
    win_mul_16_signed inst5_win_mul_16_signed (v2_1,u2_1,bitwidth,m1_3[63:32]);
    win_mul_16_signed inst6_win_mul_16_signed (v2_2,u2_2,bitwidth,m1_3[31: 0]);
    win_mul_16_signed inst7_win_mul_16_signed (v2_3,u2_3,bitwidth,m1_4[63:32]);
    win_mul_16_signed inst8_win_mul_16_signed (v2_4,u2_4,bitwidth,m1_4[31: 0]);
    
    win_mul_16_signed inst9_win_mul_16_signed (v3_1,u3_1,bitwidth,m2_1[63:32]);
    win_mul_16_signed inst10_win_mul_16_signed(v3_2,u3_2,bitwidth,m2_1[31: 0]);
    win_mul_16_signed inst11_win_mul_16_signed(v3_3,u3_3,bitwidth,m2_2[63:32]);
    win_mul_16_signed inst12_win_mul_16_signed(v3_4,u3_4,bitwidth,m2_2[31: 0]);

    win_mul_16_signed inst13_win_mul_16_signed(v4_1,u4_1,bitwidth,m2_3[63:32]);
    win_mul_16_signed inst14_win_mul_16_signed(v4_2,u4_2,bitwidth,m2_3[31: 0]);
    win_mul_16_signed inst15_win_mul_16_signed(v4_3,u4_3,bitwidth,m2_4[63:32]);
    win_mul_16_signed inst16_win_mul_16_signed(v4_4,u4_4,bitwidth,m2_4[31: 0]);


    win_mul_16_signed inst17_win_mul_16_signed(v1_1,u3_1,bitwidth,m3_1[63:32]);
    win_mul_16_signed inst18_win_mul_16_signed(v1_2,u3_2,bitwidth,m3_1[31: 0]);
    win_mul_16_signed inst19_win_mul_16_signed(v1_3,u3_3,bitwidth,m3_2[63:32]);
    win_mul_16_signed inst20_win_mul_16_signed(v1_4,u3_4,bitwidth,m3_2[31: 0]);
    
    win_mul_16_signed inst21_win_mul_16_signed(v2_1,u4_1,bitwidth,m3_3[63:32]);
    win_mul_16_signed inst22_win_mul_16_signed(v2_2,u4_2,bitwidth,m3_3[31: 0]);
    win_mul_16_signed inst23_win_mul_16_signed(v2_3,u4_3,bitwidth,m3_4[63:32]);
    win_mul_16_signed inst24_win_mul_16_signed(v2_4,u4_4,bitwidth,m3_4[31: 0]);
    
    win_mul_16_signed inst25_win_mul_16_signed(v3_1,u1_1,bitwidth,m4_1[63:32]);
    win_mul_16_signed inst26_win_mul_16_signed(v3_2,u1_2,bitwidth,m4_1[31: 0]);
    win_mul_16_signed inst27_win_mul_16_signed(v3_3,u1_3,bitwidth,m4_2[63:32]);
    win_mul_16_signed inst28_win_mul_16_signed(v3_4,u1_4,bitwidth,m4_2[31: 0]);

    win_mul_16_signed inst29_win_mul_16_signed(v4_1,u2_1,bitwidth,m4_3[63:32]);
    win_mul_16_signed inst30_win_mul_16_signed(v4_2,u2_2,bitwidth,m4_3[31: 0]);
    win_mul_16_signed inst31_win_mul_16_signed(v4_3,u2_3,bitwidth,m4_4[63:32]);
    win_mul_16_signed inst32_win_mul_16_signed(v4_4,u2_4,bitwidth,m4_4[31: 0]);


/*
    win_mul_16_signed inst1_win_mul_16_signed(v1_1,u1_1,bitwidth,m1_1);
    win_mul_16_signed inst2_win_mul_16_signed(v1_2,u1_2,bitwidth,m1_2);
    win_mul_16_signed inst3_win_mul_16_signed(v1_3,u1_3,bitwidth,m1_3);
    win_mul_16_signed inst4_win_mul_16_signed(v1_4,u1_4,bitwidth,m1_4);
    
    win_mul_16_signed inst5_win_mul_16_signed(v2_1,u2_1,bitwidth,m2_1);
    win_mul_16_signed inst6_win_mul_16_signed(v2_2,u2_2,bitwidth,m2_2);
    win_mul_16_signed inst7_win_mul_16_signed(v2_3,u2_3,bitwidth,m2_3);
    win_mul_16_signed inst8_win_mul_16_signed(v2_4,u2_4,bitwidth,m2_4);
    
    win_mul_16_signed inst9_win_mul_16_signed(v3_1,u3_1,bitwidth,m3_1);
    win_mul_16_signed inst10_win_mul_16_signed(v3_2,u3_2,bitwidth,m3_2);
    win_mul_16_signed inst11_win_mul_16_signed(v3_3,u3_3,bitwidth,m3_3);
    win_mul_16_signed inst12_win_mul_16_signed(v3_4,u3_4,bitwidth,m3_4);

    win_mul_16_signed inst13_win_mul_16_signed(v4_1,u4_1,bitwidth,m4_1);
    win_mul_16_signed inst14_win_mul_16_signed(v4_2,u4_2,bitwidth,m4_2);
    win_mul_16_signed inst15_win_mul_16_signed(v4_3,u4_3,bitwidth,m4_3);
    win_mul_16_signed inst16_win_mul_16_signed(v4_4,u4_4,bitwidth,m4_4);

    assign {m1_1,m1_2,m1_3,m1_4} = (~rst_n) ? 256'h00 : {m1_1,m1_2,m1_3,m1_4};
    assign {m2_1,m2_2,m2_3,m2_4} = (~rst_n) ? 256'h00 : {m2_1,m2_2,m2_3,m2_4};
    assign {m3_1,m3_2,m3_3,m3_4} = (~rst_n) ? 256'h00 : {m3_1,m3_2,m3_3,m3_4};
    assign {m4_1,m4_2,m4_3,m4_4} = (~rst_n) ? 256'h00 : {m4_1,m4_2,m4_3,m4_4};

    always @(posedge clk or negedge rst_n)
       begin
            if(~rst_n) begin

                {m_tmp1,m_tmp2,m_tmp3,m_tmp4} <= 512'h00;
                end_signal  <= `UnFinish;
            end 
            else begin
                m_tmp1 <= {m1_1[31:0],m1_2[31:0],m1_3[31:0],m1_4[31:0]};
                m_tmp2 <= {m2_1[31:0],m2_2[31:0],m2_3[31:0],m2_4[31:0]};
                m_tmp3 <= {m3_1[31:0],m3_2[31:0],m3_3[31:0],m3_4[31:0]};
                m_tmp4 <= {m4_1[31:0],m4_2[31:0],m4_3[31:0],m4_4[31:0]};
                end_signal  <= `Finish;
            end
        end
*/

    reg  [1:0]   state;
    reg  [1:0]   next_state;

    localparam  [1:0]
        INITAL  = 2'b00,
        RUN_1   = 2'b01,
        RUN_2   = 2'b10,
        SAVE    = 2'b11;

    always @(posedge clk or negedge rst_n)
        begin
            if(~rst_n) begin
                 state <= INITAL;
            end else begin
                 state <= next_state;
            end
        end

    always @(*) begin
        //next_state <= state;
        case(state)
            INITAL:begin 
                if(enable == 1 && bitwidth == 2'b00)
                    next_state = RUN_1;
                else if(enable == 1 && bitwidth == 2'b11)
                    next_state = RUN_2;
                else
                    next_state = INITAL;
            end
            RUN_1:begin 
                next_state = SAVE;
            end
            RUN_2:begin 
                next_state = SAVE;
            end
            SAVE:begin 
                if(enable == 1 && bitwidth == 2'b00)
                    next_state = RUN_1;
                else if(enable == 1 && bitwidth == 2'b11)
                    next_state = RUN_2;
                else
                    next_state = INITAL;                
                    //next_state = INITAL;
            end
            default : next_state = INITAL;
        endcase
    end

    always @(*) begin
        case(state)
            INITAL: begin
                /*
                {m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4} <= 128'h00;
                {m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4} <= 128'h00;
                {m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4} <= 128'h00;
                {m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4} <= 128'h00;
                {m_tmp1,m_tmp2,m_tmp3,m_tmp4} <= 512'h00;    
                */            
                {m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4} <= 256'h00;
                {m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4} <= 256'h00;
                {m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4} <= 256'h00;
                {m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4} <= 256'h00;
                {m_tmp1,m_tmp2,m_tmp3,m_tmp4} <= 1024'h00;
                end_signal  <= `UnFinish;
            end 
            RUN_1: begin 
                {m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4} <= {m1_1,m1_2,m1_3,m1_4};
                {m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4} <= {m2_1,m2_2,m2_3,m2_4};
                {m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4} <= {256'h0};
                {m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4} <= {256'h0};
                end_signal  <= `UnFinish;
            end
            RUN_2: begin 
                {m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4} <= {m1_1,m1_2,m1_3,m1_4};
                {m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4} <= {m2_1,m2_2,m2_3,m2_4};
                {m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4} <= {m3_1,m3_2,m3_3,m3_4};
                {m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4} <= {m4_1,m4_2,m4_3,m4_4};
                end_signal  <= `UnFinish;
            end
            SAVE:begin 
                m_tmp1 <= {m_reg1_1,m_reg1_2,m_reg1_3,m_reg1_4};
                m_tmp2 <= {m_reg2_1,m_reg2_2,m_reg2_3,m_reg2_4};
                m_tmp3 <= {m_reg3_1,m_reg3_2,m_reg3_3,m_reg3_4};
                m_tmp4 <= {m_reg4_1,m_reg4_2,m_reg4_3,m_reg4_4};
/*
                m_tmp1 <= {m_reg1_1[63:32],m_reg1_2[63:32],m_reg1_3[63:32],m_reg1_4[63:32],m_reg1_1[31:0],m_reg1_2[31:0],m_reg1_3[31:0],m_reg1_4[31:0]};
                m_tmp2 <= {m_reg2_1[63:32],m_reg2_2[63:32],m_reg2_3[63:32],m_reg2_4[63:32],m_reg2_1[31:0],m_reg2_2[31:0],m_reg2_3[31:0],m_reg2_4[31:0]};
                m_tmp3 <= {m_reg3_1[63:32],m_reg3_2[63:32],m_reg3_3[63:32],m_reg3_4[63:32],m_reg3_1[31:0],m_reg3_2[31:0],m_reg3_3[31:0],m_reg3_4[31:0]};
                m_tmp4 <= {m_reg4_1[63:32],m_reg4_2[63:32],m_reg4_3[63:32],m_reg4_4[63:32],m_reg4_1[31:0],m_reg4_2[31:0],m_reg4_3[31:0],m_reg4_4[31:0]};
                */
                end_signal  <= `Finish;
            end
        endcase
    end 

endmodule

/*
                m_reg2_1 <= m2_1;
                m_reg2_2 <= m2_2;
                m_reg2_3 <= m2_3;
                m_reg2_4 <= m2_4;

                m_reg3_1 <= m3_1;
                m_reg3_2 <= m3_2;
                m_reg3_3 <= m3_3;
                m_reg3_4 <= m3_4;

                m_reg4_1 <= m4_1;
                m_reg4_2 <= m4_2;
                m_reg4_3 <= m4_3;
                m_reg4_4 <= m4_4;
                */