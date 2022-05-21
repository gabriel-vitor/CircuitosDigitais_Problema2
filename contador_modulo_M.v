module contador_modulo_M
(
	input clk, reset,
	output reg max,
	output reg [4:0] C
);

parameter M=24;

always @(posedge clk or posedge reset)
	begin
		if (reset)
			begin
				max <= 'b0;
				C <= 5'b00000;
			end
		else if (C < M-1)
			begin
				max <= 'b0;
				C <= C + 1'b1;
			end
		else
			begin
				max <= 'b1;
				C <= 5'b00000;
			end
		end

endmodule