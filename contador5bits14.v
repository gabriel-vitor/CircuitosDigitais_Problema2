module contador5bits14(T,clk, reset, Q, QB, buzer);
	input T,clk;
	input reset;
	output [0:4] Q, QB;
	output buzer;
	
	

	
	flipflopT(clk, limit, T, Q[0], QB[0]);
	flipflopT(Q[0], 0, T, Q[1], QB[1]);
	flipflopT(Q[1], 0, T, Q[2], QB[2]);
	flipflopT(Q[2], 0, T, Q[3], QB[3]);
	flipflopT(Q[3], limit, T, Q[4], QB[4]);
	
	wire limit, fio;
	and and0(fio, Q[0], Q[1], Q[2], Q[3], Q[4]);
	or or0(limit, fio, ~reset);
	and and1(buzer, reset, limit);


	
endmodule 