module Mili

(
	input clk, rst_n, en, a, // такт, сброс, активация след. шага, входной сигнал
	output y // выходной сигнал
);

	parameter [1:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3; // состояния автомата в автокоде
	reg [1:0] state, next_state; // Регистры состояний автомата
	
	//Блок переключения и сброса состояний
	always @ (posedge clk or negedge rst_n)
		
		if (! rst_n)
			state <= S0;
		else if (en)
			state <= next_state;
	
	//Логика автомата Мили (по заданной схеме)
	always @*
		case (state)
		
			S0:
				if (a)
					next_state = S0;
				else
					next_state = S1;
			S1:
				if (a)
					next_state = S1;
				else
					next_state = S2;
			S2: 
				if (a)
					next_state = S0;
				else
					next_state = S3;
			S3:
				if (a)
					next_state = S2;
				else
					next_state = S0;
					
			default:
					next_state = S0;
		endcase
	
	assign y = (a & state == S1);

endmodule
