module RegFile32_32(en, clk, rst, Data_in, RW, rs1, rs2, rd, Bus_A, Bus_B);
input en;
input clk;
input rst;
input [31:0] Data_in;
input RW; //writing = '1'
input [4:1] rs1;
input [4:1] rs2;
input [4:1] rd;
integer i;
output reg [31:0] Bus_A;
output reg [31:0] Bus_B;
reg[31:0] registerFile[31:0];

//Write
always @(posedge clk) begin
	if(en) begin
		if(rst) begin
			for(i = 0; i <= 31 ; i = i + 1) begin
				registerFile[i] <= 32'b0;
			end
			end
			else if (RW) begin
				registerFile[rd] <= Data_in;
			end
		end
	end
//Read
	always @(rs1 or rs2 or en) begin
		if(~RW) begin
			Bus_A <= registerFile[rs1];
			Bus_B <= registerFile[rs2];
		end
	end
endmodule
