module CPU (clk, rst, funct_out);

input clk, rst;
output[31:0] funct_out;

wire pcsrc, alusrc, memrw, wb, regrw;
wire[3:0] aluop;
wire[1:0] immgen_ctrl;
	
wire[4:0] status;
wire[31:0] instr;
	
	//module control_unit(status, instr, pcsrc, alusrc, aluop, memrw, wb, regrw, immgen_ctrl, rst, clk);
control_unit cu_test(status, instr, pcsrc, alusrc, aluop, memrw, wb, regrw, immgen_ctrl, rst, clk);
	//module datapath (clk, rst, status, pcsrc, alusrc, aluop, memrw, wb, instr, regrw, immgen_ctrl);
datapath datapath_test(clk, rst, status, pcsrc, alusrc, aluop, memrw, wb, instr, regrw, immgen_ctrl);

assign funct_out = instr;
endmodule
