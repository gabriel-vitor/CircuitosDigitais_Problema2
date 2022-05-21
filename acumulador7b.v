module acumulador7b(sinal, b,  cin, cout, clk, Q);
	
	input [0:6] b;
	input cin, sinal;
	output cout;
	input clk;
	output [0:6] Q;
	wire [0:6] s;

	somador_subtrator_complemto7b(sinal, Q, b,  cin, s, cout);

	flipflopD(clk, s[0], Q[0]);
	flipflopD(clk, s[1], Q[1]);
	flipflopD(clk, s[2], Q[2]);
	flipflopD(clk, s[3], Q[3]);
	flipflopD(clk, s[4], Q[4]);
	flipflopD(clk, s[5], Q[5]);
	flipflopD(clk, s[6], Q[6]);



	
	endmodule
	