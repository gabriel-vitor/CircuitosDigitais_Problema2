module debouncer(clk,s);
	input clk; 
	output s;
	wire Q[0:1];
	
	flipflopD(clk,~clk,Q[0]);
	flipflopD(clk,Q[0],Q[1]);

	
	and andD(s, Q[0], Q[1]);
	
endmodule 