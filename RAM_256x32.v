module RAM_256x32 (Addr, DataIn, RW, CLK, DataOut);
input CLK, RW;
input [31:0] DataIn;
input [7:0] Addr;
wire [3:0] CS;
output [31:0] DataOut;


wire [31:0] out0, out1, out2, out3;

assign DataOut = (CS[0]) ? out0 : 32'bz;
assign DataOut = (CS[1]) ? out1 : 32'bz;
assign DataOut = (CS[2]) ? out2 : 32'bz;
assign DataOut = (CS[3]) ? out3 : 32'bz;

decoder_2to4 dut (Addr[7:6], CS);

RAMCell_64x8 mem0(Addr[5:0], DataIn[31:24], RW, CLK, out0[31:24], CS[0]);
RAMCell_64x8 mem1(Addr[5:0], DataIn[23:16], RW, CLK, out0[23:16], CS[0]);
RAMCell_64x8 mem2(Addr[5:0], DataIn[15:8],  RW, CLK, out0[15:8], CS[0]);
RAMCell_64x8 mem3(Addr[5:0], DataIn[7:0],   RW, CLK, out0[7:0], CS[0]);

RAMCell_64x8 mem4(Addr[5:0], DataIn[31:24], RW, CLK, out1[31:24], CS[1]);
RAMCell_64x8 mem5(Addr[5:0], DataIn[23:16], RW, CLK, out1[23:16], CS[1]);
RAMCell_64x8 mem6(Addr[5:0], DataIn[15:8],  RW, CLK, out1[15:8], CS[1]);
RAMCell_64x8 mem7(Addr[5:0], DataIn[7:0],   RW, CLK, out1[7:0], CS[1]);

RAMCell_64x8 mem8(Addr[5:0], DataIn[31:24], RW, CLK, out2[31:24], CS[2]);
RAMCell_64x8 mem9(Addr[5:0], DataIn[23:16], RW, CLK, out2[23:16], CS[2]);
RAMCell_64x8 mem10(Addr[5:0], DataIn[15:8], RW, CLK, out2[15:8], CS[2]);
RAMCell_64x8 mem11(Addr[5:0], DataIn[7:0],  RW, CLK, out2[7:0], CS[2]);

RAMCell_64x8 mem12(Addr[5:0], DataIn[31:24], RW, CLK, out3[31:24], CS[3]);
RAMCell_64x8 mem13(Addr[5:0], DataIn[23:16], RW, CLK, out3[23:16], CS[3]);
RAMCell_64x8 mem14(Addr[5:0], DataIn[15:8],  RW, CLK, out3[15:8], CS[3]);
RAMCell_64x8 mem15(Addr[5:0], DataIn[7:0],   RW, CLK, out3[7:0], CS[3]);

endmodule

module RAMCell_64x8(Addr1, DataIn1, RW1, CLK1, DataOut1, CS);
input CLK1, RW1;
input [7:0] DataIn1;
input CS;
input [5:0] Addr1;
//need to add an output
output reg[7:0] DataOut1;
reg [7:0] MemOut;
reg [7:0] mem_array[5:0];

always @(posedge CLK1) begin
	if(RW1 & CS)
		mem_array[Addr1] = DataIn1;
end

always @(posedge CLK1) begin
	if (RW1 == 0) begin
		MemOut = mem_array[Addr1];
		DataOut1 = (CS) ? MemOut : 8'b0;
	end
end

endmodule


module decoder_2to4(s, m);
	input [1:0] s;
	output reg [3:0] m;
always @(s) begin
case(s)
	2'b00: m <= 4'b0001;
	2'b01: m <= 4'b0010;
	2'b10: m <= 4'b0100;
	2'b11: m <= 4'b1000;
endcase
end
endmodule
