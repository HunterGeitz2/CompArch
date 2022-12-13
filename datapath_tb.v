module datapath_tb ();
reg clk, rst, pcsrc, alusrc, memrw, wb, regrw;
reg [3:0] aluop;
reg [1:0] immgen_ctrl;
wire [31:0] instr;
wire [4:0] status;
//wire [31:0] out;

//Note: The testbench doesn't actuall work fully yet, probably just have to mess with some stuff.

datapath dut (clk, rst, status, pcsrc, alusrc, aluop, memrw, wb, instr, regrw, immgen_ctrl);


initial begin
	
	clk <= 0;
	rst <= 0;
	#5
	clk <= 1;
	rst <= 1;
	#5
	clk <= 0;
	rst <= 0;
	#5
	
	//add
	regrw <= 1;
	alusrc <= 1;
	memrw <= 1;
	wb <= 0;
	pcsrc <= 0;
	immgen_ctrl <= 2'b00;
	aluop <= 4'b0010;
	#5
	clk <= 1;
	#5
	clk <= 0;
	
	
	//beq
	regrw <= 0;
	alusrc <= 0;
	memrw <= 0;
	wb <= 0;
	pcsrc <= 1;
	immgen_ctrl <= 2'b11;
	aluop <= 4'b0110;
	#5
	clk <= 1;
	#5
	clk <= 0;
	
	//lw
	regrw <= 1;
	alusrc <= 1;
	memrw <= 0;
	wb <= 0;
	pcsrc <= 0;
	immgen_ctrl <= 2'b01;
	aluop <= 4'b0010;
	#5
	clk <= 1;
	#5
	clk <= 0;
	
	//sw
	regrw <= 0;
	alusrc <= 1;
	memrw <= 1;
	wb <= 0;
	pcsrc <= 0;
	immgen_ctrl <= 2'b10;
	aluop <= 4'b0010;
	#5
	clk <= 1;
	#5
	clk <= 0;
	
	
end
	
endmodule
