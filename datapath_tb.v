module datapath_tb ();
reg clk, rst, pcsrc, alusrc, memrw, wb, regrw;
reg [3:0] aluop;
reg [1:0] immgen_ctrl;
wire [31:0] instr;
wire [4:0] status;

//Note: The testbench doesn't actuall work fully yet, probably just have to mess with some stuff.

datapath dut (clk, rst, status, pcsrc, alusrc, aluop, memrw, wb, instr, regrw, immgen_ctrl);


initial begin
rst = 1'b1;
clk = 1'b1;
#10 clk = 1'b0;
#5 rst = 1'b0;

//ADD
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b1;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0000;
#5 clk = 1'b1;
#5 clk = 1'b0;

//XOR
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b0;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0001;
#5 clk = 1'b1;
#5 clk = 1'b0;

//AND
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b0;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0010;
#5 clk = 1'b1;
#5 clk = 1'b0;

//OR
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b0;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0011;
#5 clk = 1'b1;
#5 clk = 1'b0;

//NOR
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b0;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0100;
#5 clk = 1'b1;
#5 clk = 1'b0;

//SL
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b0;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0101;
#5 clk = 1'b1;
#5 clk = 1'b0;

//SR
#5 regrw <= 1'b1;
alusrc <= 1'b1;
memrw <= 1'b0;
wb <= 1'b0;
pcsrc <= 1'b0;
immgen_ctrl <= 2'b00;
aluop <= 4'b0110;
#5 clk = 1'b1;
#5 clk = 1'b0;

end
endmodule
