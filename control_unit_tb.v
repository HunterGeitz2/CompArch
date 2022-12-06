module control_unit_tb();
reg [31:0] instr;
reg [4:0] status;
reg rst, clk;
wire pcsrc, alusrc, memrw, wb, regrw;
wire [3:0] aluop;
wire [1:0] immgen_ctrl;

control_unit dut (status, instr, pcsrc, alusrc, aluop, memrw, wb, regrw, immgen_ctrl, rst, clk);

always begin
#10 clk = ~clk;
end

initial begin
clk = 1'b0;
rst = 1'b1;
#10 rst = 1'b0;
status = 5'b00000;
instr = 32'b00000000011100110000001010110011;
#10 status = 5'b10000;
#20 status = 5'b00000;
instr=32'b00000000101000101000001110010011;
#10 instr=32'b00000000011000111010000000100011;
#10 instr=32'b00000000000000111010111000000011;
#10 instr=32'b00000001110000111000111101100011;
#10 $stop;
end


endmodule
