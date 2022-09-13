`timescale 1ns/1ps
module Mux_4to1_tb();

reg[3:0] X;
reg[1:0] S;

wire Y;

Mux_4to1 uut (.X(X), .S(S), .Y(Y));

initial begin
	#10 X=4'b1010;
	#10 S=2'b00;
	#10 S=2'b01;
	#10 S=2'b10;
	#10 S=2'b11;
	#10 $stop;
	end
endmodule
