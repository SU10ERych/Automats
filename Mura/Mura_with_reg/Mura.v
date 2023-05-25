module Mura

(
	input clk, rst_n, en, a, // такт, сброс, активация след. шага, входной сигнал
	output reg y // выходной сигнал
);

	parameter [1:0] S0 = 0, S1 = 1, S2 = 2; // сосотояния автомата
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
	
	//Выходная логика
	always @ (posedge clk or negedge rst_n)
		
		begin
			if (!rst_n)
				y <= 0;
			else if (en)
				
				begin
					y <= 1;
					
					case (state)
						S0:
							if (!a)
								y <= 0;
						S2:
							if (a)
								y <= 0;
					endcase
				end
		end		
endmodule
