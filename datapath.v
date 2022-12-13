module datapath (clk, rst, status, pcsrc, alusrc, aluop, memrw, wb, instr, regrw, immgen_ctrl);

input clk, rst, pcsrc, alusrc, memrw, wb, regrw;
input [3:0] aluop;
input [1:0] immgen_ctrl;
output [31:0] instr;
output [4:0] status;
//output [31:0] out;

wire [4:0] rd, rs1, rs2;
wire [31:0] instr_wire;

wire [31:0] pc_in, pc_out, rom_out, ram_out, alu_out;
wire [31:0] pc_addA_out, pc_addB_out;
wire [31:0] pcmux_out;
wire [3:0] alu_status;

wire p;

wire[7:0] PC, PC4;
wire[31:0] PC_big;
wire[23:0] PC_extend;

assign p = (instr_wire[31]^instr_wire[30]^instr_wire[29]^instr_wire[28]^instr_wire[27]^instr_wire[26]^instr_wire[25]^instr_wire[24]
^instr_wire[23]^instr_wire[22]^instr_wire[21]^instr_wire[20]^instr_wire[19]^instr_wire[18]^instr_wire[17]^instr_wire[16]^instr_wire[15]
^instr_wire[14]^instr_wire[13]^instr_wire[12]^instr_wire[11]^instr_wire[10]^instr_wire[9]^instr_wire[8]^instr_wire[7]^instr_wire[6]
^instr_wire[5]^instr_wire[4]^instr_wire[3]^instr_wire[2]^instr_wire[1]^instr_wire[0]); //odd parity just to have it even though we aren't doing anything with it

assign pc_in = pcmux_out;

wire [31:0] rf_out1, rf_out2, immgen_out, alumux_out, alurammux_out;

//assign out = alu_out;

wire en;
assign en = 1'b1;

assign instr = instr_wire;

wire [11:0] imm_temp;


assign PC_extend = 24'b000000000000000000000000;
assign PC_big = {PC_extend, PC};

	//module PC(in, out, rst, clk);
PC pctest (pcmux_out, PC, rst, clk);

	//module ROM(Addr, instr);
ROM romtest (PC, rom_out);

	//module instr_decoder(instruction, rd, rs1, rs2, imm, instr_out);
instr_decoder decodetest (rom_out, rd, rs1, rs2, imm_temp, instr_wire);

	//module RegFile32_32(  en, clk, rst, Data_in,       RW,    rs1, rs2, rd, Bus_A,   Bus_B);
RegFile32_32 regfile_test (en, clk, rst, alurammux_out, regrw, rs1, rs2, rd, rf_out1, rf_out2);

	//module ALU(A,     B,          Cin,  sub,            opcode, result, status);
ALU alu_test (rf_out1, alumux_out, 1'h0, alumux_out[31], aluop, alu_out, alu_status);

	//module RAM_256x32 (Addr, DataIn, RW, CLK, DataOut);
RAM_256x32 ram_test (alu_out[7:0], rf_out2, memrw, clk, ram_out);

	//module imm_gen(I,           out,        S);
imm_gen immgen_test (instr_wire, immgen_out, immgen_ctrl);

	//module Adder(A,     B,     out);
Adder addA_test ({24'b000000000000000000000000, PC}, 32'h4, pc_addA_out);
Adder addB_test ({24'b000000000000000000000000, PC}, immgen_out, pc_addB_out); 

	//module mux_2x1( sel,    in0,     in1,        result);
mux_2x1 alumux_test (alusrc, immgen_out, rf_out2, alumux_out);
mux_2x1 alurammux_test (wb, ram_out, alu_out, alurammux_out);
mux_2x1 pcmux_test (pcsrc, pc_addA_out, pc_addB_out, pcmux_out);


//assign status to be p, o, Cout, n, z combined in some way
assign status = {p, alu_status[3], alu_status[2], alu_status[1], alu_status[0]};

endmodule

module Adder(A, B, out);
input [31:0] A, B;
output [31:0] out;

assign out = A + B;
endmodule

module imm_gen (I,out,S);
	input [31:0] I;
	input [1:0] S;
	output reg [31:0] out;
	
	wire [11:0] x1,x2;
	wire [12:0] x3;
	
	//imm for I type
	assign x1 = I[31:20];
	
	//imm for S type
	assign x2[11:5] = I[31:25];
	assign x2[4:0] = I[11:7];
	
	//imm for B type
	assign x3[12] = I[31];
	assign x3[10:5] = I[30:25];
	assign x3[4:1] = I[11:8];
	assign x3[11] = I[7];
	assign x3[0] = 1'b0;
	
	always @(S,x1,x2,x3,I) begin //3 to 1 mux
		case (S)
			2'b00: out[11:0] = x1;
			2'b01: out[11:0] = x2;
			2'b10: out[11:0] = x3[12:1];
		endcase
		
		if(I[11]==1) //appends 20 bits to front of imm
			out[31:12] = 20'b1;
		else
			out[31:12] = 20'b0;
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
