module ALU(A, B, Cin, Cout, sub, opcode, result, z, n, o);
	input [31:0] A, B;
	input [2:0] opcode;
	input Cin;
	input sub;
	output [31:0] result;
	output Cout, z, n, o;


	wire [31:0] ADD, XOR, AND, OR, NOR, SL, SR;
	wire W; //2’s complement → B input will handle subtraction
	assign XOR = A^B;
	assign AND = A&B;
	assign OR = A|B;
	assign NOR = ~(A|B);
	twos_complement(B, sub, W);
	FullAdder(A, W, Cin, Cout, ADD);
	shifter(A, B, SL, SR);
	mux(opcode, ADD, XOR, NOR, OR, AND, SL, SR, result);
	
	//Zero - Ternary Condition
	assign z = (result[31:0] == 32'b0) ? 1'b1 : 1'b0;
	//Negative
	assign n = (result[31]);
	//Overflow
	assign o = (A[31] & B[31] & ~result[31])  | (~A[31] & ~B[31] & result[31]);

	
endmodule
	
	
module mux(opcode, ADD, XOR, NOR, OR, AND, SL, SR, result);
	input [2:0] opcode;
	input ADD, XOR, NOR, OR, AND, SL, SR;
	output reg result;
		always @ (ADD or XOR or NOR or OR or AND or SL or SR or opcode) begin
			case (opcode)
			3'b000: result <= ADD;
			3'b001: result <= XOR;
			3'b010: result <= AND;
			3'b011: result <= OR;
			3'b100: result <= NOR;
			3'b101: result <= SL;
			3'b110: result <= SR;
			//3'b111: result <= SUB;
			endcase
		end
endmodule






module twos_complement(Data, S, F);
		//Data = B, S = Sub Wire, F = W
	input [31:0] Data;
	input S;
	output reg F;

	always @(Data or S) begin
		if (S) begin
			F <= ~(Data[31:0]) + 1'b1;
		end 
		else begin
			F <= Data[31:0];
		end
	end
endmodule






module FullAdder(A, B, Cin, Cout, result);
	input [31:0] A, B;
	input [31:0] Cin;
	output Cout;
	output [31:0] result;

   genvar i;
   generate 
   for(i=0;i<32;i=i+1)
     begin: generate_FullAdder
   if(i==0) 
  half_adder f(A[0],B[0],result[0],Cin[0]);
   else
  full_adder f(A[i],B[i],Cin[i-1],result[i],Cin[i]);
     end
  assign Cout = Cin[31];
   endgenerate
endmodule 

module half_adder(A,B,result,Cout);
   input A,B;
   output result,Cout;
   assign result=A^B;
   assign Cout=A&B;
endmodule // half adder

module full_adder(A,B,Cin,result,Cout);
   input A,B,Cin;
   output result,Cout;
 assign result = (A^B) ^ Cin;
 assign Cout = (A&B) | (Cin&B) | (Cin&A);
endmodule // full_adder
//if Cout of FullAdder31 = 1, then overflow = 1





module shifter(A, B, SL, SR);
	input [31:0] A, B;
	output [31:0] SL, SR;
	assign SL  = A <<< B;
	assign SR = A >>> B;
endmodule 