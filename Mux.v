module Mux (opcode, ADD, XOR, NOR, OR, AND, SL, SR, Sum);

	input [2:0] opcode;
	input [31:0] ADD, XOR, NOR, OR, AND, SL, SR;
	output reg [31:0] Sum;
	
	always@(opcode or ADD or XOR or NOR or OR or AND or SL or SR) begin
	case (opcode)
	3'b 000: Sum <= ADD;
	3'b 001: Sum <= XOR;
	3'b 010: Sum <= NOR;
	3'b 011: Sum <= OR;
	3'b 100: Sum <= AND;
	3'b 101: Sum <= SL;
	3'b 110: Sum <= SR;
	3'b 111: Sum <= 69; 
	
	endcase
	end
	
	
	
endmodule 