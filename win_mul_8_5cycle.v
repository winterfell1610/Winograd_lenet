`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 15:44:33
// Design Name: 
// Module Name: win_mul_8
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


module win_mul_8(
	input  			    clk,
	input  			    rst_n,
	input  		[7:0] 	mul_a,
	input  		[7:0] 	mul_b,

	output reg 	[15:0] 	mul_out
    );

	reg [13:0] stored0;
	reg [13:0] stored1;
	reg [13:0] stored2;
	reg [13:0] stored3;
	reg [13:0] stored4;
	reg [13:0] stored5;
	reg [13:0] stored6;

	reg [7:0]  mul_reg_a;
	reg [7:0]  mul_reg_b;

	reg 	   mul_head;
	reg [14:0] mul_reg_out;//13

	reg [1:0] state,next_state;
	localparam [1:0]
		INITAL = 2'b00,
		SHITF  = 2'b01,
		ADD    = 2'b10,
		OUT    = 2'b11;

	always @(posedge clk or negedge rst_n) begin : proc_state
		if(~rst_n) begin
			state <= INITAL;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			INITAL	:next_state 	= SHITF;
			SHITF 	:next_state 	= ADD;
			ADD   	:next_state 	= OUT;
			OUT   	:next_state 	= INITAL;
			default :next_state 	= INITAL;
		endcase
	
	end
	always @(*) begin
		case (state)
	        INITAL: begin
				//mul_out 	<= 16'h00;
				stored0 	<= 14'h00;
				stored1 	<= 14'h00;
				stored2 	<= 14'h00;
				stored3 	<= 14'h00;
				stored4 	<= 14'h00;
				stored5 	<= 14'h00;
				stored6 	<= 14'h00;

				mul_reg_a 	<= 8'h00;
				mul_reg_b 	<= 8'h00;

				mul_head  	<= 1'b0;
		   end
		   SHITF:begin
				mul_reg_a 	<= (mul_a[7] == 0)? mul_a : {mul_a[7],~mul_a[6:0]+1'b1};
				mul_reg_b 	<= (mul_b[7] == 0)? mul_b : {mul_b[7],~mul_b[6:0]+1'b1};

				stored0 <= mul_reg_b[0]? {7'b0, mul_reg_a[6:0]	   	} : 14'b0;
				stored1 <= mul_reg_b[1]? {6'b0, mul_reg_a[6:0], 1'b0} : 14'b0;
				stored2 <= mul_reg_b[2]? {5'b0, mul_reg_a[6:0], 2'b0} : 14'b0;
				stored3 <= mul_reg_b[3]? {4'b0, mul_reg_a[6:0], 3'b0} : 14'b0;
				stored4 <= mul_reg_b[4]? {3'b0, mul_reg_a[6:0], 4'b0} : 14'b0;
				stored5 <= mul_reg_b[5]? {2'b0, mul_reg_a[6:0], 5'b0} : 14'b0;
				stored6 <= mul_reg_b[6]? {1'b0, mul_reg_a[6:0], 6'b0} : 14'b0;
			end
			ADD:begin 
				mul_head 	<= mul_reg_a[7] ^ mul_reg_b[7];
				mul_reg_out <= stored0+stored1+stored2+stored3+stored4+stored5+stored6;
			end
			OUT:begin 
				mul_out 	<= (mul_head == 1'b0)? {1'b0,mul_reg_out} : {1'b1,~mul_reg_out+1'b1};
			end

			//default : mul_out <= 0;
		endcase
	end
endmodule

/*
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 15:44:33
// Design Name: 
// Module Name: win_mul_8
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


module win_mul_8(
	input  			    clk,
	input  			    rst_n,
	input  		[7:0] 	mul_a,
	input  		[7:0] 	mul_b,

	output reg 	[15:0] 	mul_out
    );

	reg [13:0] stored0;
	reg [13:0] stored1;
	reg [13:0] stored2;
	reg [13:0] stored3;
	reg [13:0] stored4;
	reg [13:0] stored5;
	reg [13:0] stored6;

	reg [7:0]  mul_reg_a;
	reg [7:0]  mul_reg_b;

	reg 	   mul_head;
	reg [14:0] mul_reg_out;//13

	always @(posedge clk or negedge rst_n) begin : proc_state
		if(~rst_n) begin
			//mul_out 	<= 16'h00;
			stored0 	<= 14'h00;
			stored1 	<= 14'h00;
			stored2 	<= 14'h00;
			stored3 	<= 14'h00;
			stored4 	<= 14'h00;
			stored5 	<= 14'h00;
			stored6 	<= 14'h00;

			mul_reg_a 	<= 8'h00;
			mul_reg_b 	<= 8'h00;

			mul_head  	<= 1'b0;
	   	end
	 	else begin
			mul_reg_a 	<= (mul_a[7] == 0)? mul_a : {mul_a[7],~mul_a[6:0]+1'b1};
			mul_reg_b 	<= (mul_b[7] == 0)? mul_b : {mul_b[7],~mul_a[6:0]+1'b1};

			stored0 	<= mul_reg_b[0]? {7'b0, mul_reg_a[6:0]	   	} : 14'b0;
			stored1 	<= mul_reg_b[1]? {6'b0, mul_reg_a[6:0], 1'b0} : 14'b0;
			stored2 	<= mul_reg_b[2]? {5'b0, mul_reg_a[6:0], 2'b0} : 14'b0;
			stored3 	<= mul_reg_b[3]? {4'b0, mul_reg_a[6:0], 3'b0} : 14'b0;
			stored4 	<= mul_reg_b[4]? {3'b0, mul_reg_a[6:0], 4'b0} : 14'b0;
			stored5 	<= mul_reg_b[5]? {2'b0, mul_reg_a[6:0], 5'b0} : 14'b0;
			stored6 	<= mul_reg_b[6]? {1'b0, mul_reg_a[6:0], 6'b0} : 14'b0;

			mul_head 	<= mul_a[7] ^ mul_b[7];
			mul_reg_out <= stored0+stored1+stored2+stored3+stored4+stored5+stored6;

			mul_out 	<= (mul_head == 1'b0)? {1'b0,mul_reg_out} : {1'b1,~mul_reg_out+1'b1};
		end
	end
endmodule

*/