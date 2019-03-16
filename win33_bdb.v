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

module win33_bdb(
    input  					clk, 
    input 					rst_n,
    input					enable,
    input  		[63:0]		act1,
    input  		[63:0]		act2,
    input  		[63:0]		act3,
    input  		[63:0]		act4,
    input 		[ 1:0]		bitwidth,
    //input  		[31:0] 		psum_in,
    
    output 	reg	[63:0] 		v_tmp1,
    output	reg	[63:0] 		v_tmp2,
    output	reg	[63:0] 		v_tmp3,
    output	reg	[63:0] 		v_tmp4,
    output	reg		 		end_signal
    );

	wire [15:0] d1_1,d1_2,d1_3,d1_4;
	wire [15:0] d2_1,d2_2,d2_3,d2_4;
	wire [15:0] d3_1,d3_2,d3_3,d3_4;
	wire [15:0] d4_1,d4_2,d4_3,d4_4;

	reg [15:0] b1_1,b1_2,b1_3,b1_4;
	reg [15:0] b2_1,b2_2,b2_3,b2_4;
	reg [15:0] b3_1,b3_2,b3_3,b3_4;
	reg [15:0] b4_1,b4_2,b4_3,b4_4;

	reg [15:0] v1_1,v1_2,v1_3,v1_4;
	reg [15:0] v2_1,v2_2,v2_3,v2_4;
	reg [15:0] v3_1,v3_2,v3_3,v3_4;
	reg [15:0] v4_1,v4_2,v4_3,v4_4;

	assign {d4_4,d4_3,d4_2,d4_1} = act1;
	assign {d3_4,d3_3,d3_2,d3_1} = act2;
	assign {d2_4,d2_3,d2_2,d2_1} = act3;
	assign {d1_4,d1_3,d1_2,d1_1} = act4;

	reg 		[3:0] state;
	reg 		[3:0] next_state;

	localparam 	[3:0]
		INITAL 	= 4'b0000,
		RUN_1 	= 4'b0001,//16*16
		RUN_2 	= 4'b0010,
		RUN2_1 	= 4'b0011,//8*16
		RUN2_2 	= 4'b0100,
		RUN3_1 	= 4'b0101,//16*8
		RUN3_2 	= 4'b0110,
		RUN4_1 	= 4'b0111,//8*8
		RUN4_2 	= 4'b1000,
		SAVE    = 4'b1111,
		SAVE2   = 4'b1001,
		SAVE3   = 4'b1010,
		SAVE4   = 4'b1011;

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
			b1_4 <= 0;

			b2_1 <= 0;
			b2_2 <= 0;
			b2_3 <= 0;
			b2_4 <= 0;

			b3_1 <= 0;
			b3_2 <= 0;
			b3_3 <= 0;
			b3_4 <= 0;

			b4_1 <= 0;
			b4_2 <= 0;
			b4_3 <= 0;
			b4_4 <= 0;


			v1_1 <= 0;
			v1_2 <= 0;
			v1_3 <= 0;
			v1_4 <= 0;

			v2_1 <= 0;
			v2_2 <= 0;
			v2_3 <= 0;
			v2_4 <= 0;

			v3_1 <= 0;
			v3_2 <= 0;
			v3_3 <= 0;
			v3_4 <= 0;

			v4_1 <= 0;
			v4_2 <= 0;
			v4_3 <= 0;
			v4_4 <= 0;

            {v_tmp1,v_tmp2,v_tmp3,v_tmp4} <= {64'h00,64'h00,64'h00,64'h00};
			end_signal	<= `UnFinish;
		end 
		RUN_1: begin
			b1_1 <= $signed(d1_1) - $signed(d3_1);
			b1_2 <= $signed(d1_2) - $signed(d3_2);
			b1_3 <= $signed(d1_3) - $signed(d3_3);
			b1_4 <= $signed(d1_4) - $signed(d3_4);

			b2_1 <= $signed(d2_1) + $signed(d3_1);
			b2_2 <= $signed(d2_2) + $signed(d3_2);
			b2_3 <= $signed(d2_3) + $signed(d3_3);
			b2_4 <= $signed(d2_4) + $signed(d3_4);

			b3_1 <= $signed(d3_1) - $signed(d2_1);
			b3_2 <= $signed(d3_2) - $signed(d2_2);
			b3_3 <= $signed(d3_3) - $signed(d2_3);
			b3_4 <= $signed(d3_4) - $signed(d2_4);

			b4_1 <= $signed(d2_1) - $signed(d4_1);
			b4_2 <= $signed(d2_2) - $signed(d4_2);
			b4_3 <= $signed(d2_3) - $signed(d4_3);
			b4_4 <= $signed(d2_4) - $signed(d4_4);
		end

		RUN_2:begin 
			v1_1 <= $signed(b1_1) - $signed(b1_3);
			v2_1 <= $signed(b2_1) - $signed(b2_3);
			v3_1 <= $signed(b3_1) - $signed(b3_3);
			v4_1 <= $signed(b4_1) - $signed(b4_3);

			v1_2 <= $signed(b1_2) + $signed(b1_3);
			v2_2 <= $signed(b2_2) + $signed(b2_3);
			v3_2 <= $signed(b3_2) + $signed(b3_3);
			v4_2 <= $signed(b4_2) + $signed(b4_3);

			v1_3 <= $signed(b1_3) - $signed(b1_2);
			v2_3 <= $signed(b2_3) - $signed(b2_2);
			v3_3 <= $signed(b3_3) - $signed(b3_2);
			v4_3 <= $signed(b4_3) - $signed(b4_2);

			v1_4 <= $signed(b1_2) - $signed(b1_4);
			v2_4 <= $signed(b2_2) - $signed(b2_4);
			v3_4 <= $signed(b3_2) - $signed(b3_4);
			v4_4 <= $signed(b4_2) - $signed(b4_4);
			end_signal	<= `Finish;
		end 
		RUN2_1: begin
			b1_1 <= $signed(d1_1) - $signed(d3_1);
			b1_2 <= $signed(d1_2) - $signed(d3_2);
			b1_3 <= $signed(d1_3) - $signed(d3_3);
			b1_4 <= $signed(d1_4) - $signed(d3_4);

			b2_1 <= $signed(d2_1) + $signed(d3_1);
			b2_2 <= $signed(d2_2) + $signed(d3_2);
			b2_3 <= $signed(d2_3) + $signed(d3_3);
			b2_4 <= $signed(d2_4) + $signed(d3_4);

			b3_1 <= $signed(d3_1) - $signed(d2_1);
			b3_2 <= $signed(d3_2) - $signed(d2_2);
			b3_3 <= $signed(d3_3) - $signed(d2_3);
			b3_4 <= $signed(d3_4) - $signed(d2_4);

			b4_1 <= $signed(d2_1) - $signed(d4_1);
			b4_2 <= $signed(d2_2) - $signed(d4_2);
			b4_3 <= $signed(d2_3) - $signed(d4_3);
			b4_4 <= $signed(d2_4) - $signed(d4_4);
		end

		RUN2_2:begin 
			v1_1 <= $signed(b1_1) - $signed(b1_3);
			v2_1 <= $signed(b2_1) - $signed(b2_3);
			v3_1 <= $signed(b3_1) - $signed(b3_3);
			v4_1 <= $signed(b4_1) - $signed(b4_3);

			v1_2 <= $signed(b1_2) + $signed(b1_3);
			v2_2 <= $signed(b2_2) + $signed(b2_3);
			v3_2 <= $signed(b3_2) + $signed(b3_3);
			v4_2 <= $signed(b4_2) + $signed(b4_3);

			v1_3 <= $signed(b1_3) - $signed(b1_2);
			v2_3 <= $signed(b2_3) - $signed(b2_2);
			v3_3 <= $signed(b3_3) - $signed(b3_2);
			v4_3 <= $signed(b4_3) - $signed(b4_2);

			v1_4 <= $signed(b1_2) - $signed(b1_4);
			v2_4 <= $signed(b2_2) - $signed(b2_4);
			v3_4 <= $signed(b3_2) - $signed(b3_4);
			v4_4 <= $signed(b4_2) - $signed(b4_4);
			end_signal	<= `Finish;
		end
		RUN3_1: begin
			b1_1 <= $signed(d1_1) - $signed(d3_1);
			b1_2 <= $signed(d1_2) - $signed(d3_2);
			b1_3 <= $signed(d1_3) - $signed(d3_3);
			b1_4 <= $signed(d1_4) - $signed(d3_4);

			b2_1 <= $signed(d2_1) + $signed(d3_1);
			b2_2 <= $signed(d2_2) + $signed(d3_2);
			b2_3 <= $signed(d2_3) + $signed(d3_3);
			b2_4 <= $signed(d2_4) + $signed(d3_4);

			b3_1 <= $signed(d3_1) - $signed(d2_1);
			b3_2 <= $signed(d3_2) - $signed(d2_2);
			b3_3 <= $signed(d3_3) - $signed(d2_3);
			b3_4 <= $signed(d3_4) - $signed(d2_4);

			b4_1 <= $signed(d2_1) - $signed(d4_1);
			b4_2 <= $signed(d2_2) - $signed(d4_2);
			b4_3 <= $signed(d2_3) - $signed(d4_3);
			b4_4 <= $signed(d2_4) - $signed(d4_4);
		end

		RUN3_2:begin 
			v1_1 <= $signed(b1_1) - $signed(b1_3);
			v2_1 <= $signed(b2_1) - $signed(b2_3);
			v3_1 <= $signed(b3_1) - $signed(b3_3);
			v4_1 <= $signed(b4_1) - $signed(b4_3);

			v1_2 <= $signed(b1_2) + $signed(b1_3);
			v2_2 <= $signed(b2_2) + $signed(b2_3);
			v3_2 <= $signed(b3_2) + $signed(b3_3);
			v4_2 <= $signed(b4_2) + $signed(b4_3);

			v1_3 <= $signed(b1_3) - $signed(b1_2);
			v2_3 <= $signed(b2_3) - $signed(b2_2);
			v3_3 <= $signed(b3_3) - $signed(b3_2);
			v4_3 <= $signed(b4_3) - $signed(b4_2);

			v1_4 <= $signed(b1_2) - $signed(b1_4);
			v2_4 <= $signed(b2_2) - $signed(b2_4);
			v3_4 <= $signed(b3_2) - $signed(b3_4);
			v4_4 <= $signed(b4_2) - $signed(b4_4);
			end_signal	<= `Finish;
		end

		RUN4_1: begin
			b1_1[ 7:0] <= $signed(d1_1[ 7:0]) - $signed(d2_1[ 7:0]);
			b1_1[15:8] <= $signed(d1_1[15:8]) - $signed(d2_1[15:8]);
			b1_2[ 7:0] <= $signed(d1_2[ 7:0]) - $signed(d2_2[ 7:0]);
			b1_2[15:8] <= $signed(d1_2[15:8]) - $signed(d2_2[15:8]);

			b1_3[ 7:0] <= $signed(d1_3[ 7:0]) + $signed(d2_1[ 7:0]);
			b1_3[15:8] <= $signed(d1_3[15:8]) + $signed(d2_1[15:8]);
			b1_4[ 7:0] <= $signed(d1_4[ 7:0]) + $signed(d2_2[ 7:0]);
			b1_4[15:8] <= $signed(d1_4[15:8]) + $signed(d2_2[15:8]);

			b2_1[ 7:0] <= $signed(d2_1[ 7:0]) - $signed(d1_3[ 7:0]);
			b2_1[15:8] <= $signed(d2_1[15:8]) - $signed(d1_3[15:8]);
			b2_2[ 7:0] <= $signed(d2_2[ 7:0]) - $signed(d1_4[ 7:0]);
			b2_2[15:8] <= $signed(d2_2[15:8]) - $signed(d1_4[15:8]);

			b2_3[ 7:0] <= $signed(d1_3[ 7:0]) - $signed(d2_3[ 7:0]);
			b2_3[15:8] <= $signed(d1_3[15:8]) - $signed(d2_3[15:8]);
			b2_4[ 7:0] <= $signed(d1_4[ 7:0]) - $signed(d2_4[ 7:0]);
			b2_4[15:8] <= $signed(d1_4[15:8]) - $signed(d2_4[15:8]);


			b3_1[ 7:0] <= $signed(d3_1[ 7:0]) - $signed(d4_1[ 7:0]);
			b3_1[15:8] <= $signed(d3_1[15:8]) - $signed(d4_1[15:8]);
			b3_2[ 7:0] <= $signed(d3_2[ 7:0]) - $signed(d4_2[ 7:0]);
			b3_2[15:8] <= $signed(d3_2[15:8]) - $signed(d4_2[15:8]);

			b3_3[ 7:0] <= $signed(d3_3[ 7:0]) + $signed(d4_1[ 7:0]);
			b3_3[15:8] <= $signed(d3_3[15:8]) + $signed(d4_1[15:8]);
			b3_4[ 7:0] <= $signed(d3_4[ 7:0]) + $signed(d4_2[ 7:0]);
			b3_4[15:8] <= $signed(d3_4[15:8]) + $signed(d4_2[15:8]);

			b4_1[ 7:0] <= $signed(d4_1[ 7:0]) - $signed(d3_3[ 7:0]);
			b4_1[15:8] <= $signed(d4_1[15:8]) - $signed(d3_3[15:8]);
			b4_2[ 7:0] <= $signed(d4_2[ 7:0]) - $signed(d3_4[ 7:0]);
			b4_2[15:8] <= $signed(d4_2[15:8]) - $signed(d3_4[15:8]);

			b4_3[ 7:0] <= $signed(d3_3[ 7:0]) - $signed(d4_3[ 7:0]);
			b4_3[15:8] <= $signed(d3_3[15:8]) - $signed(d4_3[15:8]);
			b4_4[ 7:0] <= $signed(d3_4[ 7:0]) - $signed(d4_4[ 7:0]);
			b4_4[15:8] <= $signed(d3_4[15:8]) - $signed(d4_4[15:8]);

		end

		RUN4_2:begin 
			v1_1[ 7:0] <= $signed(b1_1[ 7:0]) - $signed(b1_2[ 7:0]);
			v1_1[15:8] <= $signed(b1_3[ 7:0]) - $signed(b1_4[ 7:0]);
			v1_2[ 7:0] <= $signed(b2_1[ 7:0]) - $signed(b2_2[ 7:0]);
			v1_2[15:8] <= $signed(b2_3[ 7:0]) - $signed(b2_4[ 7:0]);

			v1_3[ 7:0] <= $signed(b1_1[15:8]) + $signed(b1_2[ 7:0]);
			v1_3[15:8] <= $signed(b1_3[15:8]) + $signed(b1_4[ 7:0]);
			v1_4[ 7:0] <= $signed(b2_1[15:8]) + $signed(b2_2[ 7:0]);
			v1_4[15:8] <= $signed(b2_3[15:8]) + $signed(b2_4[ 7:0]);

			v2_1[ 7:0] <= $signed(b1_2[ 7:0]) - $signed(b1_1[15:8]);
			v2_1[15:8] <= $signed(b1_4[ 7:0]) - $signed(b1_3[15:8]);
			v2_2[ 7:0] <= $signed(b2_2[ 7:0]) - $signed(b2_1[15:8]);
			v2_2[15:8] <= $signed(b2_4[ 7:0]) - $signed(b2_3[15:8]);

			v2_3[ 7:0] <= $signed(b1_1[15:8]) - $signed(b1_2[15:8]);
			v2_3[15:8] <= $signed(b1_3[15:8]) - $signed(b1_4[15:8]);
			v2_4[ 7:0] <= $signed(b2_1[15:8]) - $signed(b2_2[15:8]);
			v2_4[15:8] <= $signed(b2_3[15:8]) - $signed(b2_4[15:8]);


			v3_1[ 7:0] <= $signed(b3_1[ 7:0]) - $signed(b3_2[ 7:0]);
			v3_1[15:8] <= $signed(b3_3[ 7:0]) - $signed(b3_4[ 7:0]);
			v3_2[ 7:0] <= $signed(b4_1[ 7:0]) - $signed(b4_2[ 7:0]);
			v3_2[15:8] <= $signed(b4_3[ 7:0]) - $signed(b4_4[ 7:0]);

			v3_3[ 7:0] <= $signed(b3_1[15:8]) + $signed(b3_2[ 7:0]);
			v3_3[15:8] <= $signed(b3_3[15:8]) + $signed(b3_4[ 7:0]);
			v3_4[ 7:0] <= $signed(b4_1[15:8]) + $signed(b4_2[ 7:0]);
			v3_4[15:8] <= $signed(b4_3[15:8]) + $signed(b4_4[ 7:0]);

			v4_1[ 7:0] <= $signed(b3_2[ 7:0]) - $signed(b3_1[15:8]);
			v4_1[15:8] <= $signed(b3_4[ 7:0]) - $signed(b3_3[15:8]);
			v4_2[ 7:0] <= $signed(b4_2[ 7:0]) - $signed(b4_1[15:8]);
			v4_2[15:8] <= $signed(b4_4[ 7:0]) - $signed(b4_3[15:8]);

			v4_3[ 7:0] <= $signed(b3_1[15:8]) - $signed(b3_2[15:8]);
			v4_3[15:8] <= $signed(b3_3[15:8]) - $signed(b3_4[15:8]);
			v4_4[ 7:0] <= $signed(b4_1[15:8]) - $signed(b4_2[15:8]);
			v4_4[15:8] <= $signed(b4_3[15:8]) - $signed(b4_4[15:8]);			
			end_signal	<= `Finish;
		end
		SAVE2:begin 
			v_tmp1 <= {v1_1,v1_2,v1_3,v1_4};
			v_tmp2 <= {v2_1,v2_2,v2_3,v2_4};
			v_tmp3 <= {v3_1,v3_2,v3_3,v3_4};
			v_tmp4 <= {v4_1,v4_2,v4_3,v4_4};			
			end_signal	<= `UnFinish;
		end
		SAVE3:begin 
			v_tmp1 <= {v1_1,v1_2,v1_3,v1_4};
			v_tmp2 <= {v2_1,v2_2,v2_3,v2_4};
			v_tmp3 <= {v3_1,v3_2,v3_3,v3_4};
			v_tmp4 <= {v4_1,v4_2,v4_3,v4_4};			
			end_signal	<= `UnFinish;
		end
		SAVE:begin 
			v_tmp1 <= {v1_1,v1_2,v1_3,v1_4};
			v_tmp2 <= {v2_1,v2_2,v2_3,v2_4};
			v_tmp3 <= {v3_1,v3_2,v3_3,v3_4};
			v_tmp4 <= {v4_1,v4_2,v4_3,v4_4};			
			end_signal	<= `UnFinish;
		end
		SAVE4:begin 
			v_tmp1 <= {v1_1[7:0],v1_3[7:0],v2_1[7:0],v2_3[7:0],v1_1[15:8],v1_3[15:8],v2_1[15:8],v2_3[15:8]};
			v_tmp2 <= {v1_2[7:0],v1_4[7:0],v2_2[7:0],v2_4[7:0],v1_2[15:8],v1_4[15:8],v2_2[15:8],v2_4[15:8]};
			v_tmp3 <= {v3_1[7:0],v3_3[7:0],v4_1[7:0],v4_3[7:0],v3_1[15:8],v3_3[15:8],v4_1[15:8],v4_3[15:8]};
			v_tmp4 <= {v3_2[7:0],v3_4[7:0],v4_2[7:0],v4_4[7:0],v3_2[15:8],v3_4[15:8],v4_2[15:8],v4_4[15:8]};	
			end_signal	<= `UnFinish;
		end
		endcase
	end
endmodule
