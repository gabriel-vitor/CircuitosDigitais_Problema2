module demuxP(x, clky, clkz, pd, pu, td, tu);
	input x, clky, clkz;
	output reg pd, pu, td, tu;
	

	always @(clky, clkz) begin
		if(clky == 1'b0) begin
			if(clkz == 1'b0) begin
				pd <= x;
				pu <= ~x;
				td <= ~x;
				tu <= ~x;
			end
			else if(clkz == 1'b1) begin
				pd <= ~x;
				pu <= x;
				td <= ~x;
				tu <= ~x;
			end
		end
		else if (clky == 1'b1) begin
			if(clkz == 1'b0) begin
				pd <= ~x;
				pu <= ~x;
				td <= x;
				tu <= ~x;
			end
			else if(clkz == 1'b1) begin
				pd <= ~x;
				pu <= ~x;
				td <= ~x;
				tu <= x;
			end
		end

	end
endmodule 
	