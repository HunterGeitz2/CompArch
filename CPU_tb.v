module CPU_tb (clk, rst, funct_out);
output reg clk, rst;
output [31:0] funct_out;

CPU dut (clk, rst, funct_out);

//set up clock
initial begin
clk = 1'b0;
forever #5 clk = ~clk;
end

initial begin
rst = 1'b1;
#10 rst = 1'b0;
end

endmodule
