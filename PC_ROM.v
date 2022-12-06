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
		8'h0:  instr = 32'h00000000;
		8'h4:  instr = 32'h00450693;
		8'h8:  instr = 32'h00100713;
		8'hc:  instr = 32'h00b76463;
		8'h10: instr = 32'h0006a803;
		8'h14: instr = 32'h00008067;
		8'h18: instr = 32'h00068613;
		8'h1c: instr = 32'h00070793;
		8'h20: instr = 32'hffc62883;
		8'h24: instr = 32'h01185a63;
		8'h28: instr = 32'h01162023;
		8'h2c: instr = 32'hfff78793;
		8'h30: instr = 32'hffc60613;
		8'h34: instr = 32'hfe0796e3;
		8'h38: instr = 32'h00279793;
		8'h3c: instr = 32'h00f50763;
		8'h40: instr = 32'h0107a023;
		8'h44: instr = 32'h00170713;
		8'h48: instr = 32'h00468693;
		8'h4c: instr = 32'hfc1ff06f;
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
