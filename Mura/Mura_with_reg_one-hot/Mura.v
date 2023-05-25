module Mura

(
	input clk, rst_n, en, a, // такт, сброс, активация след. шага, входной сигнал
	output y // выходной сигнал
);

	parameter [2:0] S0 = 3'b001, S1 = 3'b010, S2 = 3'b100; // состояния автомата
	reg [1:0] state, next_state; // Регистры состояний автомата
	
	//Блок переключения и сброса состояний
	always @ (posedge clk or negedge rst_n)
		
		if (!rst_n)
			state <= S0;
		else if (en)
			state <= next_state;
	
	//Логика автомата Мура (по заданной схеме)
	always @*
		case (state)
		
			S0:
				if (a)
					next_state = S1;
				else
					next_state = S0;
			S1:
				if (a)
					next_state = S2;
				else
					next_state = S1;
			S2: 
				if (a)
					next_state = S0;
				else
					next_state = S2;
				
			default:
					next_state = S0;
		endcase
	
		assign y = (state == S2 || state == S1);
endmodule
