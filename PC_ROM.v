module PC_ROM(next, current, rst, clk, rd, rs1, rs2, imm, out, instr_out);
//Define IO
input rst, clk;
output [7:0] current, next;
output [4:0] rd, rs1, rs2;
output [11:0] imm;
output [31:0] out;
output [31:0] instr_out;

wire[7:0] PC; //current addr
wire[7:0] PC4; //looks @ next addr

PC pctest (PC4, PC, rst, clk);
Incr_by_4 addtest (PC, PC4); //looks @ next addr
ROM romtest (PC, out);
instr_decoder decodetest (out, rd, rs1, rs2, imm, instr_out);

assign current = PC;
assign next = PC4;

endmodule

module PC(in, out, rst, clk);
input [7:0] in;
input rst, clk;
output reg [7:0] out; 
always @(posedge clk) begin
	if (rst)
	out = 8'b00000000;
	else 
	out = in; // incremented by 4 b/c of incr_by_4 module
end
endmodule 

module Incr_by_4(in, out);
input [7:0] in;
output [7:0] out;
assign out = in + 8'b00000100;
endmodule 

module ROM(Addr, instr);
input[7:0] Addr;
output reg [31:0] instr;
	always @ (Addr) begin
		case (Addr)
		8'h00: instr = 32'h00000000;
		8'h04: instr = 32'h00f00193; //addi x3, x0, 15
		8'h08: instr = 32'h00700213; //addi x4, x0, 7
		8'h0c: instr = 32'h004182b3; //add  x5, x3, x4
		8'h10: instr = 32'h06502223; //sw   x5, 100(x0)
		8'h14: instr = 32'h05d22183; //lw   x3, 93(x4)
		8'h18: instr = 32'h00518863; //beq  x3, x5, 8
		8'h20: instr = 32'h00200113; //addi x2, x0, 2
		8'h24: instr = 32'h00221233; //sll  x4, x4, x2
		8'h28: instr = 32'h00125213; //slri x4, x4, 1
		endcase
	end
endmodule

module instr_decoder(instruction, rd, rs1, rs2, imm, instr_out);
input [31:0] instruction;
output [4:0] rd, rs1, rs2;
output [11:0] imm;
output [31:0] instr_out;
assign rd = instruction[11:7];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign imm = instruction[31:20];
assign instr_out = instruction;
endmodule 
