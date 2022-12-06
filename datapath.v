module datapath (clk, rst, status, pcsrc, alusrc, aluop, memrw, wb, instr, regrw, immgen_ctrl);

input clk, rst, pcsrc, alusrc, memrw, wb, regrw;
input [3:0] aluop;
input [1:0] immgen_ctrl;
output [31:0] instr;
output [4:0] status;

wire [4:0] rd, rs1, rs2;
wire [31:0] instr_wire;

wire [31:0] pc_in, pc_out, rom_out, ram_out, alu_out;
wire [31:0] pc_addA_out, pc_addB_out;
wire [31:0] pcmux_out;

wire [1:0] z, n, o, carry, p; //(Carry = ALU's Cout)

assign p = (instr[31]^instr[30]^instr[29]^instr[28]^instr[27]^instr[26]^instr[25]^instr[24]
^instr[23]^instr[22]^instr[21]^instr[20]^instr[19]^instr[18]^instr[17]^instr[16]^instr[15]
^instr[14]^instr[13]^instr[12]^instr[11]^instr[10]^instr[9]^instr[8]^instr[7]^instr[6]
^instr[5]^instr[4]^instr[3]^instr[2]^instr[1]^instr[0]); //odd parity just to have it even though we aren't doing anything with it

assign pc_in = pcmux_out;
assign rom_in = pc_out;

wire [31:0] rf_out1, rf_out2, immgen_out, alumux_out, alurammux_out, alurammux_inA;

wire en;
assign en = 1'b1;

wire [2:0] alu_status;

	//module PC(in, out, rst, clk);
PC pctest (pc_in, pc_out, rst, clk);

	//module ROM(Addr, instr);
ROM romtest (rom_in, rom_out);

	//module instr_decoder(instruction, rd, rs1, rs2, imm, instr_out);
instr_decoder decodetest (rom_out, rd, rs1, rs2, imm_out, instr);

	//module RegFile32_32(  en, clk, rst, Data_in,       RW,    rs1, rs2, rd, Bus_A,   Bus_B);
RegFile32_32 regfile_test (en, clk, rst, alurammux_out, regrw, rs1, rs2, rd, rf_out1, rf_out2);

	//module ALU(A,     B,          Cin,  Cout,  sub, opcode, result, status);
ALU alu_test (rf_out1, alumux_out, 1'h0, carry, alumux_out[31], aluop, alu_out, alu_status);

	//module RAM_256x32 (Addr, DataIn, RW, CLK, DataOut);
RAM_256x32 ram_test (alu_out[7:0], rf_out2, memrw, clk, alurammux_inA);

	//module imm_gen(imm_in, imm_out,    instr_type);
imm_gen immgen_test (instr, immgen_out, immgen_ctrl);

	//module Adder(A,     B,     out);
Adder addA_test (pc_out, 32'h4, pc_addA_out);
Adder addB_test (pc_out, immgen_out, pc_addB_out); 

	//module mux_2x1( sel,    in0,     in1,        result);
mux_2x1 alumux_test (alusrc, rf_out2, immgen_out, alumux_out);
mux_2x1 alurammux_test (wb, alurammux_inA, alu_out, alurammux_out);
mux_2x1 pcmux_test (pcsrc, pc_addA_out, pc_addB_out, pcmux_out);


//assign status to be p, o, Cout, n, z combined in some way

assign status = {p, alu_status[0], alu_status[1], alu_status[2], carry};

endmodule

module Adder(A, B, out);
input [31:0] A, B;
output [31:0] out;

assign out = A + B;
endmodule

module imm_gen(imm_in, imm_out, instr_type);
input [31:0] imm_in;
input [1:0] instr_type;
output [31:0] imm_out;
reg [31:0] imm_out_reg;

assign imm_out = imm_out_reg;

always @(imm_in) begin
	case (instr_type)
		2'b01: imm_out_reg <= {{21{imm_in[31]}}, imm_in[30:20]}; //I-Type
		2'b10: imm_out_reg <= {{21{imm_in[31]}}, imm_in[30:25], imm_in[11:7]}; //S-Type
		2'b11: imm_out_reg <= {{20{imm_in[7]}}, imm_in[30:25], imm_in[11:8], {1{1'b0}}}; //B-Type
		default: imm_out_reg <= 32'bx;
		endcase
end
endmodule

module mux_2x1(sel, in0, in1, result);
input sel;
input [31:0] in0, in1;
output reg [31:0] result;
always @ (in0 or in1) begin
	case (sel)
	1'b0: result <= in0;
	1'b1: result <= in1;
	default: result <= 32'bz;
	endcase
end
endmodule
