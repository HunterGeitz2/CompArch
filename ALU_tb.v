`timescale 1ns/1ps
module ALU_tb();
reg[2:0] opcode;
reg[31:0] A,B;
reg Cin, sub;
wire Cout;
wire [2:0] status;
wire[31:0] result;

ALU dut (A, B, Cin, Cout, sub, opcode, result, status);


initial begin
	Cin = 0;
	sub = 0;
	#10
	opcode = 3'b000; //ADD
	A = 32'b00000000000000000000000000000101; //5
	B = 32'b00000000000000000000000000001010; //10
	//result should be 5 + 10 = 15
	#10 
	Cin = 1;
	A = 32'b00000000000000000000000000000110; //6
	B = 32'b00000000000000000000000000000101; //5
	//result should be 6 +5 (+ 1) = 12
	#10 
	sub = 1;
	Cin = 0;
	//result should be 5 - 6 = 1
	
	#10 
	opcode = 3'b001; //XOR
	A = 32'b00000000000000000000000000000101; //5
	B = 32'b00000000000000000000000000001001; //9
	//result should be 0...01100 or 12
	
	#10 
	opcode = 3'b010; //AND
	A = 32'b00000000000000000000000000000110; //6
	B = 32'b00000000000000000000000000001010; //10
	//result should be 0...00010 or 2
	
	#10 
	opcode = 3'b011; //OR
	A = 32'b00000000000000000000000000000111; //7
	B = 32'b00000000000000000000000000001011; //11
	//result should be 0...01111 or 15
	
	#10
	opcode = 3'b100; //NOR
	A = 32'b00000000000000000000000000000101; //5
	B = 32'b00000000000000000000000000001001; //9
	//result should be 1...10010
	
	#10 
	opcode = 3'b101; //SL
	A = 32'b00000000000000000000000000000111; //7
	B = 32'b00000000000000000000000000001100; //12
	
	#10 
	opcode = 3'b110; //SR
	
end

initial begin
	#500 $stop;
end

endmodule
