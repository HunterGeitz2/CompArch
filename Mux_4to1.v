module Mux_4to1(X,S,Y);
	input[3:0] X;
	input[1:0] S;
	output reg Y;

always@(X or S)
	begin
		case (S)
			2'b00: Y <= X[0];
			2'b01: Y <= X[1];
			2'b10: Y <= X[2];
			2'b11: Y <= X[3];
		endcase
	end
endmodule
