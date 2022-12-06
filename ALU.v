module ALU(A, B, Cin, sub, opcode, result, status);
	input [31:0] A, B;
	input [2:0] opcode;
	input Cin;
	input sub;
	output[31:0] result;
	output[3:0] status;
	wire z, n, o;
	wire Cout;

	wire [31:0] ADD, XOR, AND, OR, NOR, SL, SR;
	wire [31:0] W; //2’s complement → B input will handle subtraction
	assign XOR = A^B;
	assign AND = A&B;
	assign OR = A|B;
	assign NOR = ~(A|B);
	twos_complement dut1 (B, sub, W);
	FullAdder dut2 (A, W, Cin, Cout, ADD);
	shifter dut3 (A, B, SL, SR);
	mux dut4 (opcode, ADD, XOR, NOR, OR, AND, SL, SR, result);

	//Zero - Ternary Condition
	assign z = (result[31:0] == 32'b0) ? 1'b1 : 1'b0;
	//Negative
	assign n = (result[31]);
	//Overflow
	assign o = (A[31] & B[31] & ~result[31])  | (~A[31] & ~B[31] & result[31]);
	
	assign status = {o, Cout, n, z};
	
endmodule
	
	

module twos_complement(Data, S, F);
		//Data = B, S = Sub Wire, F = W
	input [31:0] Data;
	input S;
	output reg [31:0] F;

	always @(Data or S) begin
		if (S) begin
			F <= ~(Data[31:0]) + 1'b1;
		end 
		else begin
			F <= Data[31:0];
		end
	end
endmodule



module FullAdder(A, B, Cin, Cout, sum);
	input[31:0] A,B;
	input Cin;
	wire [31:0] carry;
	output Cout;
	output[31:0] sum;
	
	genvar i;
	generate
	for(i=0;i<32;i=i+1) begin:GenerateFullAdder
		if (i==0) begin
			assign carry[i] = Cin;
			assign sum[i] = (A[i]^B[i]) ^ Cin;
		end
		else begin
			assign carry[i] = (A[i]&B[i]) | (carry[i-1]&B[i]) | (carry[i-1]&A[i]);
			assign sum[i] = (A[i]^B[i]) ^ carry[i-1];
		end
	end
	endgenerate
	
	assign Cout = carry[31];
endmodule



module shifter(A, B, SL, SR);
	input [31:0] A, B;
	output [31:0] SL, SR;
	assign SL  = A <<< B;
	assign SR = A >>> B;
endmodule 



module mux(opcode, ADD, XOR, NOR, OR, AND, SL, SR, result);
	input [2:0] opcode;
	input [31:0] ADD, XOR, NOR, OR, AND, SL, SR;
	output reg [31:0] result;
		always @ (ADD or XOR or NOR or OR or AND or SL or SR or opcode) begin
			case (opcode)
			3'b000: result <= ADD;
			3'b001: result <= XOR;
			3'b010: result <= AND;
			3'b011: result <= OR;
			3'b100: result <= NOR;
			3'b101: result <= SL;
			3'b110: result <= SR;
			3'b111: result <= 32'b0;
			default: result <= 32'b0;
			endcase
		end
endmodule
