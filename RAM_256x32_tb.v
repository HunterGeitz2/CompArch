module RAM_256x32_tb();

reg [31:0] DataIn;
reg [7:0] Addr;
reg CLK, RW;
wire [31:0] DataOut;

RAM_256x32 dut (Addr, DataIn, RW, CLK, DataOut);

initial
CLK = 1'b0;

initial
Addr <= 8'b00000000;

always begin
	#5 CLK = ~CLK;
end

initial begin
	RW = 1'b1;
	#2560 RW = 1'b0;
end

always @(negedge CLK) begin
	DataIn = {$random, $random};
	Addr = Addr+8'b00000001;
end

initial begin
#5120 $stop;
end
endmodule
