module Mura

(
	input clk, rst_n, a0, a1, a2, a3, // такт, сброс, активация след. шага, входной сигнал
	output y0, y1 // выходной сигнал
);

	parameter [1:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3; // сосотояния автомата
	reg [1:0] state, next_state; // Регистры состояний автомата
	
	//Блок переключения и сброса состояний
	always @ (posedge clk or negedge rst_n)
		
		if (!rst_n)
			state <= S0;
		else
			state <= next_state;
	
	//Логика автомата Мура (по заданной схеме)
	always @*
	begin
		next_state = state;
		case (state)
		
			S0:
				if (a0)
					next_state = S0;
				else if (a1)
					next_state = S0;
				else if (a2)
					next_state = S1;
				else if (a3)
					next_state = S2;
					
			S1:
				if (a0)
					next_state = S2;
				else if (a2)
					next_state = S2;
				else if (a1)
					next_state = S0;
				else if (a3)
					next_state = S1;
					
			S2: 
					next_state = S1;

			S3:
					next_state = S2;
			default: next_state = S0;
		endcase
	end
		
		assign y1 = (state == S1 || state == S2);
		assign y0 = (state == S0 || state == S3);
	
	
endmodule
