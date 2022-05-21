module flipflopT(clk,reset,T,Q, QB);

	input clk, reset, T; 
	output reg Q, QB;
  
	always @ (posedge clk, posedge reset) begin  
		if (reset) begin
			Q <= 0;
			QB <= 1;
		end
		else
			if(T == 1) begin
				Q <= ~Q;
				QB <= ~Q;
			end
			else 
				Q <= Q;
				QB <= ~Q;
			
	
  end  
endmodule  