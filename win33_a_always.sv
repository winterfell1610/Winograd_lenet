	always @(posedge clk or negedge rst_n)
		if(~rst_n) begin
			v1_1 = 0;
			v1_2 = 0;
			v1_3 = 0;
			v1_4 = 0;

			v2_1 = 0;
			v2_2 = 0;
			v2_3 = 0;
			v2_4 = 0;
		end 
		else if(enable) begin
			v1_1 = $signed(m1_1) + $signed(m2_1) + $signed(m3_1);
			v1_2 = $signed(m1_2) + $signed(m2_2) + $signed(m3_2);
			v1_3 = $signed(m1_3) + $signed(m2_3) + $signed(m3_3);
			v1_4 = $signed(m1_4) + $signed(m2_4) + $signed(m3_4);

			v2_1 = $signed(m2_1) + $signed(m3_1) + $signed(m4_1);
			v2_2 = $signed(m2_2) + $signed(m3_1) + $signed(m4_2);
			v2_3 = $signed(m2_3) + $signed(m3_1) + $signed(m4_3);
			v2_4 = $signed(m2_4) + $signed(m3_1) + $signed(m4_4);
		end
	end