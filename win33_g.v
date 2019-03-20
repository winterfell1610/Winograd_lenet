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
`include "defines.v"


module win33_g(
    input                   clk, 
    input                   rst_n,
    input                   enable,
    input       [47:0]      kernel1,
    input       [47:0]      kernel2,
    input       [47:0]      kernel3,
    input       [ 1:0]      bitwidth,
    //input         [31:0]      psum_in,
    
    //output    reg             end_signal,
    output reg    [63:0]      u_tmp1,
    output reg    [63:0]      u_tmp2,
    output reg    [63:0]      u_tmp3,
    output reg    [63:0]      u_tmp4,
    output reg             end_signal
    );

    wire [15:0] g1_1,g1_2,g1_3;
    wire [15:0] g2_1,g2_2,g2_3;
    wire [15:0] g3_1,g3_2,g3_3;

    reg [15:0] b1_1,b1_2,b1_3;
    reg [15:0] b2_1,b2_2,b2_3;
    reg [15:0] b3_1,b3_2,b3_3;
    reg [15:0] b4_1,b4_2,b4_3;

    reg [15:0] u1_1,u1_2,u1_3,u1_4;
    reg [15:0] u2_1,u2_2,u2_3,u2_4;
    reg [15:0] u3_1,u3_2,u3_3,u3_4;
    reg [15:0] u4_1,u4_2,u4_3,u4_4;

    assign {g3_3,g3_2,g3_1} = kernel1;
    assign {g2_3,g2_2,g2_1} = kernel2;
    assign {g1_3,g1_2,g1_1} = kernel3;

    reg         [3:0] state;
    reg         [3:0] next_state;

    localparam  [3:0]
        INITAL  = 4'b0000,
        RUN_1   = 4'b0001,//16*16
        RUN_2   = 4'b0010,
        RUN2_1  = 4'b0011,//8*16
        RUN2_2  = 4'b0100,
        RUN3_1  = 4'b0101,//16*8
        RUN3_2  = 4'b0110,
        RUN4_1  = 4'b0111,//8*8
        RUN4_2  = 4'b1000,//dec 8
        SAVE    = 4'b1111,
        SAVE2   = 4'b1001,
        SAVE3   = 4'b1010,
        SAVE4   = 4'b1011;//b

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
                if(enable == 1)begin
                    if(bitwidth == 2'b00) next_state = RUN_1;
                    else if(bitwidth == 2'b01) next_state = RUN2_1;
                    else if(bitwidth == 2'b10) next_state = RUN3_1;
                    else next_state = RUN4_1;
                end
                else
                    next_state = INITAL;
            end
            RUN_1:begin 
                next_state = RUN_2;
            end
            RUN_2:begin 
                next_state = SAVE;
            end
            RUN2_1:begin 
                next_state = RUN2_2;
            end
            RUN2_2:begin 
                next_state = SAVE2;
            end
            RUN3_1:begin 
                next_state = RUN3_2;
            end
            RUN3_2:begin 
                next_state = SAVE3;
            end
            RUN4_1:begin 
                next_state = RUN4_2;
            end
            RUN4_2:begin 
                next_state = SAVE4;
            end
            SAVE2:begin 
                next_state = INITAL;
            end
            SAVE3:begin 
                next_state = INITAL;
            end
            SAVE4:begin 
                next_state = INITAL;
            end
            SAVE:begin 
                next_state = INITAL;
            end
            default : next_state = INITAL;
        endcase
    end

    always @(*) begin
        case(state)
        INITAL: begin
            b1_1 <= 0;
            b1_2 <= 0;
            b1_3 <= 0;
            
            b2_1 <= 0;
            b2_2 <= 0;
            b2_3 <= 0;

            b3_1 <= 0;
            b3_2 <= 0;
            b3_3 <= 0;

            b4_1 <= 0;
            b4_2 <= 0;
            b4_3 <= 0;


            u1_1 <= 0;
            u1_2 <= 0;
            u1_3 <= 0;
            u1_4 <= 0;

            u2_1 <= 0;
            u2_2 <= 0;
            u2_3 <= 0;
            u2_4 <= 0;

            u3_1 <= 0;
            u3_2 <= 0;
            u3_3 <= 0;
            u3_4 <= 0;

            u4_1 <= 0;
            u4_2 <= 0;
            u4_3 <= 0;
            u4_4 <= 0;

            u_tmp1 <= 64'h0;
            u_tmp2 <= 64'h0;
            u_tmp3 <= 64'h0;
            u_tmp4 <= 64'h0;
            end_signal  <= `UnFinish;
        end 
        RUN_1: begin 
            {b1_1,b1_2,b1_3} <= {g1_1,g1_2,g1_3};
            
            b2_1 <= (($signed(g1_1) + $signed(g2_1) + $signed(g3_1))/2);
            b2_2 <= (($signed(g1_2) + $signed(g2_2) + $signed(g3_2))/2);
            b2_3 <= (($signed(g1_3) + $signed(g2_3) + $signed(g3_3))/2);

            b3_1 <= (($signed(g1_1) - $signed(g2_1) + $signed(g3_1))/2);
            b3_2 <= (($signed(g1_2) - $signed(g2_2) + $signed(g3_2))/2);
            b3_3 <= (($signed(g1_3) - $signed(g2_3) + $signed(g3_3))/2);

            {b4_1,b4_2,b4_3} <= {g3_1,g3_2,g3_3};
        end
        RUN_2:begin 
           {u1_1,u2_1,u3_1,u4_1} <= {b1_1,b2_1,b3_1,b4_1};

            u1_2 <= (($signed(b1_1) + $signed(b1_2) + $signed(b1_3))/2);
            u2_2 <= (($signed(b2_1) + $signed(b2_2) + $signed(b2_3))/2);
            u3_2 <= (($signed(b3_1) + $signed(b3_2) + $signed(b3_3))/2);
            u4_2 <= (($signed(b4_1) + $signed(b4_2) + $signed(b4_3))/2);

            u1_3 <= (($signed(b1_1) - $signed(b1_2) + $signed(b1_3))/2);
            u2_3 <= (($signed(b2_1) - $signed(b2_2) + $signed(b2_3))/2);
            u3_3 <= (($signed(b3_1) - $signed(b3_2) + $signed(b3_3))/2);
            u4_3 <= (($signed(b4_1) - $signed(b4_2) + $signed(b4_3))/2);

            {u1_4,u2_4,u3_4,u4_4} <= {b1_3,b2_3,b3_3,b4_3};
            end_signal  <= `Finish;
        end
        RUN2_1: begin 
            {b1_1,b1_2,b1_3} <= {g1_1,g1_2,g1_3};
            
            b2_1 <= (($signed(g1_1) + $signed(g2_1) + $signed(g3_1))/2);
            b2_2 <= (($signed(g1_2) + $signed(g2_2) + $signed(g3_2))/2);
            b2_3 <= (($signed(g1_3) + $signed(g2_3) + $signed(g3_3))/2);

            b3_1 <= (($signed(g1_1) - $signed(g2_1) + $signed(g3_1))/2);
            b3_2 <= (($signed(g1_2) - $signed(g2_2) + $signed(g3_2))/2);
            b3_3 <= (($signed(g1_3) - $signed(g2_3) + $signed(g3_3))/2);

            {b4_1,b4_2,b4_3} <= {g3_1,g3_2,g3_3};
        end
        RUN2_2:begin 
           {u1_1,u2_1,u3_1,u4_1} <= {b1_1,b2_1,b3_1,b4_1};

            u1_2 <= (($signed(b1_1) + $signed(b1_2) + $signed(b1_3))/2);
            u2_2 <= (($signed(b2_1) + $signed(b2_2) + $signed(b2_3))/2);
            u3_2 <= (($signed(b3_1) + $signed(b3_2) + $signed(b3_3))/2);
            u4_2 <= (($signed(b4_1) + $signed(b4_2) + $signed(b4_3))/2);

            u1_3 <= (($signed(b1_1) - $signed(b1_2) + $signed(b1_3))/2);
            u2_3 <= (($signed(b2_1) - $signed(b2_2) + $signed(b2_3))/2);
            u3_3 <= (($signed(b3_1) - $signed(b3_2) + $signed(b3_3))/2);
            u4_3 <= (($signed(b4_1) - $signed(b4_2) + $signed(b4_3))/2);

            {u1_4,u2_4,u3_4,u4_4} <= {b1_3,b2_3,b3_3,b4_3};
            end_signal  <= `Finish;
        end
        RUN3_1: begin 
            {b1_1,b1_2,b1_3} <= {g1_1,g1_2,g1_3};
            
            b2_1 <= (($signed(g1_1) + $signed(g2_1) + $signed(g3_1))/2);
            b2_2 <= (($signed(g1_2) + $signed(g2_2) + $signed(g3_2))/2);
            b2_3 <= (($signed(g1_3) + $signed(g2_3) + $signed(g3_3))/2);

            b3_1 <= (($signed(g1_1) - $signed(g2_1) + $signed(g3_1))/2);
            b3_2 <= (($signed(g1_2) - $signed(g2_2) + $signed(g3_2))/2);
            b3_3 <= (($signed(g1_3) - $signed(g2_3) + $signed(g3_3))/2);

            {b4_1,b4_2,b4_3} <= {g3_1,g3_2,g3_3};
        end
        RUN3_2:begin 
           {u1_1,u2_1,u3_1,u4_1} <= {b1_1,b2_1,b3_1,b4_1};

            u1_2 <= (($signed(b1_1) + $signed(b1_2) + $signed(b1_3))/2);
            u2_2 <= (($signed(b2_1) + $signed(b2_2) + $signed(b2_3))/2);
            u3_2 <= (($signed(b3_1) + $signed(b3_2) + $signed(b3_3))/2);
            u4_2 <= (($signed(b4_1) + $signed(b4_2) + $signed(b4_3))/2);

            u1_3 <= (($signed(b1_1) - $signed(b1_2) + $signed(b1_3))/2);
            u2_3 <= (($signed(b2_1) - $signed(b2_2) + $signed(b2_3))/2);
            u3_3 <= (($signed(b3_1) - $signed(b3_2) + $signed(b3_3))/2);
            u4_3 <= (($signed(b4_1) - $signed(b4_2) + $signed(b4_3))/2);

            {u1_4,u2_4,u3_4,u4_4} <= {b1_3,b2_3,b3_3,b4_3};
            end_signal  <= `Finish;
        end
        RUN4_1: begin 
            //{b1_1[ 7:0],b1_1[15:8],b1_2[ 7:0]} <= {g1_1[ 7:0],g1_1[15:8],g1_2[ 7:0]};
            b1_1[ 7:0] <= g1_1[ 7:0];
            b1_1[15:8] <= g1_1[15:8];
            b1_2[ 7:0] <= g1_2[ 7:0];

            b1_2[15:8] <= (($signed(g1_1[ 7:0]) + $signed(g1_2[15:8]) + $signed(g2_1[ 7:0]))/2);
            b1_3[ 7:0] <= (($signed(g1_1[15:8]) + $signed(g1_3[ 7:0]) + $signed(g2_1[15:8]))/2);
            b1_3[15:8] <= (($signed(g1_2[ 7:0]) + $signed(g1_3[15:8]) + $signed(g2_2[ 7:0]))/2);

            b2_1[ 7:0] <= (($signed(g1_1[ 7:0]) - $signed(g1_2[15:8]) + $signed(g2_1[ 7:0]))/2);
            b2_1[15:8] <= (($signed(g1_1[15:8]) - $signed(g1_3[ 7:0]) + $signed(g2_1[15:8]))/2);
            b2_2[ 7:0] <= (($signed(g1_2[ 7:0]) - $signed(g1_3[15:8]) + $signed(g2_2[ 7:0]))/2);

            //{b2_2[15:8],b2_3[ 7:0],b2_3[15:8]} <= {g2_1[ 7:0],g2_1[15:8],g2_2[ 7:0]};
            b2_2[15:8] <= g2_1[ 7:0];
            b2_3[ 7:0] <= g2_1[15:8];
            b2_3[15:8] <= g2_2[ 7:0];

            //{b3_1[ 7:0],b3_1[15:8],b3_2[ 7:0]} <= {g2_2[15:8],g2_3[ 7:0],g2_3[15:8]};
            b3_1[ 7:0] <= g2_2[15:8];
            b3_1[15:8] <= g2_3[ 7:0];
            b3_2[ 7:0] <= g2_3[15:8];    
            
            b3_2[15:8] <= $signed(($signed(g2_2[15:8]) + $signed(g3_1[ 7:0]) + $signed(g3_2[15:8]))/2);
            b3_3[ 7:0] <= $signed(($signed(g2_3[ 7:0]) + $signed(g3_1[15:8]) + $signed(g3_3[ 7:0]))/2);
            b3_3[15:8] <= $signed(($signed(g2_3[15:8]) + $signed(g3_2[ 7:0]) + $signed(g3_3[15:8]))/2);

            b4_1[ 7:0] <= $signed(($signed(g2_2[15:8]) - $signed(g3_1[ 7:0]) + $signed(g3_2[15:8]))/2);
            b4_1[15:8] <= $signed(($signed(g2_3[ 7:0]) - $signed(g3_1[15:8]) + $signed(g3_3[ 7:0]))/2);
            b4_2[ 7:0] <= $signed(($signed(g2_3[15:8]) - $signed(g3_2[ 7:0]) + $signed(g3_3[15:8]))/2);

            //{b4_2[15:8],b4_3[ 7:0],b4_3[15:8]} <= {g3_2[15:8],g3_3[ 7:0],g3_3[15:8]};
            b4_2[15:8] <= g3_2[15:8];
            b4_3[ 7:0] <= g3_3[ 7:0];
            b4_3[15:8] <= g3_3[15:8];
        end
        RUN4_2:begin 
            
           //{u1_1[ 7:0],u1_3[ 7:0],u2_1[ 7:0],u2_3[ 7:0]} <= {b1_1[ 7:0],b1_2[15:8],b2_1[ 7:0],b1_2[15:8]};
            /**/
            u1_1[ 7:0] <= b1_1[ 7:0];
            u1_3[ 7:0] <= b1_2[15:8];
            u2_1[ 7:0] <= b2_1[ 7:0];
            u2_3[ 7:0] <= b2_2[15:8];

            u1_1[15:8] <= $signed(($signed(b1_1[ 7:0]) + $signed(b1_1[15:8]) + $signed(b1_2[ 7:0]))/2);
            u1_3[15:8] <= $signed(($signed(b1_2[15:8]) + $signed(b1_3[ 7:0]) + $signed(b1_3[15:8]))/2);
            u2_1[15:8] <= $signed(($signed(b2_1[ 7:0]) + $signed(b2_1[15:8]) + $signed(b2_2[ 7:0]))/2);
            u2_3[15:8] <= $signed(($signed(b2_2[15:8]) + $signed(b2_3[ 7:0]) + $signed(b2_3[15:8]))/2);

            u1_2[ 7:0] <= $signed(($signed(b1_1[ 7:0]) - $signed(b1_1[15:8]) + $signed(b1_2[ 7:0]))/2);
            u1_4[ 7:0] <= $signed(($signed(b1_2[15:8]) - $signed(b1_3[ 7:0]) + $signed(b1_3[15:8]))/2);
            u2_2[ 7:0] <= $signed(($signed(b2_1[ 7:0]) - $signed(b2_1[15:8]) + $signed(b2_2[ 7:0]))/2);
            u2_4[ 7:0] <= $signed(($signed(b2_2[15:8]) - $signed(b2_3[ 7:0]) + $signed(b2_3[15:8]))/2);

            //{u1_2[15:8],u1_4[15:8],u2_2[15:8],u2_4[15:8]} <= {b1_3[ 7:0],b2_3[15:8],b3_3[ 7:0],b4_3[15:8]};
            u1_2[15:8] <= b1_2[ 7:0];
            u1_4[15:8] <= b1_3[15:8];
            u2_2[15:8] <= b2_2[ 7:0];
            u2_4[15:8] <= b2_3[15:8];
            
            //{u3_1[ 7:0],u3_3[ 7:0],u4_1[ 7:0],u4_3[ 7:0]} <= {b3_1[ 7:0],b3_2[15:8],b4_1[ 7:0],b3_2[15:8]};
            u3_1[ 7:0] <= b3_1[ 7:0];
            u3_3[ 7:0] <= b3_2[15:8];
            u4_1[ 7:0] <= b4_1[ 7:0];
            u4_3[ 7:0] <= b4_2[15:8];

            u3_1[15:8] <= $signed(($signed(b3_1[ 7:0]) + $signed(b3_1[15:8]) + $signed(b3_2[ 7:0]))/2);
            u3_3[15:8] <= $signed(($signed(b3_2[15:8]) + $signed(b3_3[ 7:0]) + $signed(b3_3[15:8]))/2);
            u4_1[15:8] <= $signed(($signed(b4_1[ 7:0]) + $signed(b4_1[15:8]) + $signed(b4_2[ 7:0]))/2);
            u4_3[15:8] <= $signed(($signed(b4_2[15:8]) + $signed(b4_3[ 7:0]) + $signed(b4_3[15:8]))/2);
            
            u3_2[ 7:0] <= $signed(($signed(b3_1[ 7:0]) - $signed(b3_1[15:8]) + $signed(b3_2[ 7:0]))/2);
            u3_4[ 7:0] <= $signed(($signed(b3_2[15:8]) - $signed(b3_3[ 7:0]) + $signed(b3_3[15:8]))/2);
            u4_2[ 7:0] <= $signed(($signed(b4_1[ 7:0]) - $signed(b4_1[15:8]) + $signed(b4_2[ 7:0]))/2);
            u4_4[ 7:0] <= $signed(($signed(b4_2[15:8]) - $signed(b4_3[ 7:0]) + $signed(b4_3[15:8]))/2);
            
            //{u3_2[15:8],u3_4[15:8],u4_2[15:8],u4_4[15:8]} <= {b3_3[ 7:0],b4_3[15:8],b3_3[ 7:0],b4_3[15:8]};
            u3_2[15:8] <= b3_2[ 7:0];
            u3_4[15:8] <= b3_3[15:8];
            u4_2[15:8] <= b4_2[ 7:0];
            u4_4[15:8] <= b4_3[15:8];
            

            end_signal  <= `Finish;
        end

        SAVE:begin 
            u_tmp1 <= {u1_1,u1_2,u1_3,u1_4};
            u_tmp2 <= {u2_1,u2_2,u2_3,u2_4};
            u_tmp3 <= {u3_1,u3_2,u3_3,u3_4};
            u_tmp4 <= {u4_1,u4_2,u4_3,u4_4};
            end_signal  <= `UnFinish;
        end
        SAVE2:begin 
            u_tmp1 <= {u1_1,u1_2,u1_3,u1_4};
            u_tmp2 <= {u2_1,u2_2,u2_3,u2_4};
            u_tmp3 <= {u3_1,u3_2,u3_3,u3_4};
            u_tmp4 <= {u4_1,u4_2,u4_3,u4_4};
            end_signal  <= `UnFinish;
        end
        SAVE3:begin 
            u_tmp1 <= {u1_1,u1_2,u1_3,u1_4};
            u_tmp2 <= {u2_1,u2_2,u2_3,u2_4};
            u_tmp3 <= {u3_1,u3_2,u3_3,u3_4};
            u_tmp4 <= {u4_1,u4_2,u4_3,u4_4};
            end_signal  <= `UnFinish;
        end
        SAVE4:begin 
            u_tmp1 <= {u1_1[ 7:0],u1_1[15:8],u1_2[ 7:0],u1_2[15:8],u1_3[ 7:0],u1_3[15:8],u1_4[ 7:0],u1_4[15:8]};
            u_tmp2 <= {u2_1[ 7:0],u2_1[15:8],u2_2[ 7:0],u2_2[15:8],u2_3[ 7:0],u2_3[15:8],u2_4[ 7:0],u2_4[15:8]};
            u_tmp3 <= {u3_1[ 7:0],u3_1[15:8],u3_2[ 7:0],u3_2[15:8],u3_3[ 7:0],u3_3[15:8],u3_4[ 7:0],u3_4[15:8]};
            u_tmp4 <= {u4_1[ 7:0],u4_1[15:8],u4_2[ 7:0],u4_2[15:8],u4_3[ 7:0],u4_3[15:8],u4_4[ 7:0],u4_4[15:8]};
            /*
            u_tmp1 <= {u1_1[ 7:0],u1_3[ 7:0],u2_1[ 7:0],u2_3[ 7:0],u1_1[15:8],u1_3[15:8],u2_1[15:8],u2_3[15:8]};
            u_tmp2 <= {u1_2[ 7:0],u1_4[ 7:0],u2_2[ 7:0],u2_4[ 7:0],u1_2[15:8],u1_4[15:8],u2_2[15:8],u2_4[15:8]};
            u_tmp3 <= {u3_1[ 7:0],u3_3[ 7:0],u4_1[ 7:0],u4_3[ 7:0],u3_1[15:8],u3_3[15:8],u4_1[15:8],u4_3[15:8]};
            u_tmp4 <= {u3_2[ 7:0],u3_4[ 7:0],u4_2[ 7:0],u4_4[ 7:0],u3_2[15:8],u3_4[15:8],u4_2[15:8],u4_4[15:8]};
            */
            end_signal  <= `UnFinish;
        end
            
        
        endcase
    end



endmodule
