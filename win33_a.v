`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
`include "defines.v"


module win33_a(
    input  					clk, 
    input 					rst_n,
    input					enable,

    input  		[127:0]		m_tmp1,
    input  		[127:0]		m_tmp2,
    input  		[127:0]		m_tmp3,
    input  		[127:0]		m_tmp4,

    output  reg [127:0]     f_tmp,
    output	reg		 		end_signal
    );

	wire [31:0] m1_1,m1_2,m1_3,m1_4;
	wire [31:0] m2_1,m2_2,m2_3,m2_4;
	wire [31:0] m3_1,m3_2,m3_3,m3_4;
	wire [31:0] m4_1,m4_2,m4_3,m4_4;

	reg [31:0] v1_1,v1_2,v1_3,v1_4;
	reg [31:0] v2_1,v2_2,v2_3,v2_4;

    reg [31:0] f1_1,f1_2;
    reg [31:0] f2_1,f2_2;

	assign {m1_1,m1_2,m1_3,m1_4} = m_tmp1;
	assign {m2_1,m2_2,m2_3,m2_4} = m_tmp2;
	assign {m3_1,m3_2,m3_3,m3_4} = m_tmp3;
	assign {m4_1,m4_2,m4_3,m4_4} = m_tmp4;

	reg 		[1:0] state;
	reg 		[1:0] next_state;

	localparam 	[1:0]
		INITAL 	= 2'b00,
		RUN_1 	= 2'b01,
		RUN_2 	= 2'b10,
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
				if(enable == 1)
					next_state = RUN_1;
				else
					next_state = INITAL;
			end

			RUN_1:begin 
				next_state = RUN_2;
			end

			RUN_2:begin 
				next_state = SAVE;
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
			v1_1 <= 0;
			v1_2 <= 0;
			v1_3 <= 0;
			v1_4 <= 0;

			v2_1 <= 0;
			v2_2 <= 0;
			v2_3 <= 0;
			v2_4 <= 0;

			f1_1 <= 0; 
			f2_1 <= 0; 
			f1_2 <= 0; 
			f2_2 <= 0; 
			//f_tmp <= {127'h00};
			end_signal	<= `UnFinish;
		end
		RUN_1: begin
			v1_1 <= $signed(m1_1) + $signed(m2_1) + $signed(m3_1);
			v1_2 <= $signed(m1_2) + $signed(m2_2) + $signed(m3_2);
			v1_3 <= $signed(m1_3) + $signed(m2_3) + $signed(m3_3);
			v1_4 <= $signed(m1_4) + $signed(m2_4) + $signed(m3_4);

			v2_1 <= $signed(m2_1) - $signed(m3_1) - $signed(m4_1);
			v2_2 <= $signed(m2_2) - $signed(m3_2) - $signed(m4_2);
			v2_3 <= $signed(m2_3) - $signed(m3_3) - $signed(m4_3);
			v2_4 <= $signed(m2_4) - $signed(m3_4) - $signed(m4_4);
		end

		RUN_2:begin 
			f1_1 <= $signed(v1_1) + $signed(v1_2) + $signed(v1_3);
			f2_1 <= $signed(v2_1) + $signed(v2_2) + $signed(v2_3);

			f1_2 <= $signed(v1_2) - $signed(v1_3) - $signed(v1_4);
			f2_2 <= $signed(v2_2) - $signed(v2_3) - $signed(v2_4);
		end
		SAVE:begin 
			f_tmp  <= {f2_2,f2_1,f1_2,f1_1};
			end_signal	<= `Finish;		
		end

	endcase
	end



endmodule
