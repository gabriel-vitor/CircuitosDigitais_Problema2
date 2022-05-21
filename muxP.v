module muxP(w, x, y, z, clky, clkz, s);

	input w, x, y, z, clky, clkz;
	output reg s;
	
	always @(clky, clkz, w, x, y, z) begin
		
		if(clky == 1'b0) begin
			if(clkz == 1'b0) begin
				s <= w;
			end
			else if(clkz == 1'b1) begin
				s <= x;
			end
		end
		else if (clky == 1'b1) begin
			if(clkz == 1'b0) begin
				s <= y;
			end
			else if(clkz == 1'b1) begin
				s <= z;
			end
		end 
		
	end
endmodule 