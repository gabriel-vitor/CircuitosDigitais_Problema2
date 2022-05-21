module divisorFreq(clk, Q, QB);
	input clk;

	output [0:17] Q, QB;
	
	
	flipflopT(clk,0, 1, Q[0], QB[0]);
	flipflopT(Q[0], 0, 1, Q[1], QB[1]);
	flipflopT(Q[1], 0, 1, Q[2], QB[2]);
	flipflopT(Q[2], 0, 1, Q[3], QB[3]);
	flipflopT(Q[3], 0, 1, Q[4], QB[4]);
	flipflopT(Q[4], 0, 1, Q[5], QB[5]);
	flipflopT(Q[5], 0, 1, Q[6], QB[6]);
	flipflopT(Q[6], 0, 1, Q[7], QB[7]);
	flipflopT(Q[7], 0, 1, Q[8], QB[8]);
	flipflopT(Q[8], 0, 1, Q[9], QB[9]);
	flipflopT(Q[9], 0, 1, Q[10], QB[10]);
	flipflopT(Q[10], 0, 1, Q[11], QB[11]);
	flipflopT(Q[11], 0, 1, Q[12], QB[12]);
	flipflopT(Q[12], 0, 1, Q[13], QB[13]);
	flipflopT(Q[13], 0, 1, Q[14], QB[14]);
	flipflopT(Q[14], 0, 1, Q[15], QB[15]);
	flipflopT(Q[15], 0, 1, Q[16], QB[16]);
	flipflopT(Q[16], 0, 1, Q[17], QB[17]);
	
endmodule 