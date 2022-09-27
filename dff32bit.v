module dff32bit (reset, CLK, D, Q);
input reset;
input clk;
input [31:0] D;
output [31:0] Q;
reg [31:0] Q;
always @(posedge clk)
if (reset)
Q = 0;
else
Q = D;
endmodule 
