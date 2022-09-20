`timescale 1ns/1ps
module Mux_32to1_tb();

reg[31:0] X;
reg[4:0] S;

wire Y;

Mux_32to1 uut (.X(X), .S(S), .Y(Y));

initial begin
	#10 X=32'b10101010101010101010101010101010;
	#10 S=5'b00000;
	#10 S=5'b00001;
	#10 S=5'b00010;
	#10 S=5'b00011;
	#10 S=5'b00100;
	#10 S=5'b00101;
	#10 S=5'b00110;
	#10 S=5'b00111;
	
	#10 S=5'b01000;
	#10 S=5'b01001;
	#10 S=5'b01010;
	#10 S=5'b01011;
	#10 S=5'b01100;
	#10 S=5'b01101;
	#10 S=5'b01110;
	#10 S=5'b01111;
	
	#10 S=5'b10000;
	#10 S=5'b10001;
	#10 S=5'b10010;
	#10 S=5'b10011;
	#10 S=5'b10100;
	#10 S=5'b10101;
	#10 S=5'b10110;
	#10 S=5'b10111;
	
	#10 S=5'b11000;
	#10 S=5'b11001;
	#10 S=5'b11010;
	#10 S=5'b11011;
	#10 S=5'b11100;
	#10 S=5'b11101;
	#10 S=5'b11110;
	#10 S=5'b11111;
	#10 $stop;
	end
endmodule
