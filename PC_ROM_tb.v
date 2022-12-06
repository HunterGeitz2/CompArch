module PC_ROM_tb (next, current, rst, clk, rd, rs1, rs2, imm, out, instr_out);
output reg clk, rst;
output [7:0] next, current;
output [31:0] out, instr_out;
output [4:0] rd, rs1, rs2;
output [11:0] imm;
//output [31:0] instr_out;

PC_ROM dut (next, current, rst, clk, rd, rs1, rs2, imm, out, instr_out);

integer i;

initial begin
rst = 1'b1;
clk = 1'b0;
#5 clk = 1'b1;
#5 rst = 1'b0;
	for(i=0; i < 21; i=i+1) begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
	end
$stop;
end

endmodule
