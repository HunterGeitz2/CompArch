module control_unit(status, instr, pcsrc, alusrc, aluop, memrw, wb, regrw, immgen_ctrl, rst, clk);
input [31:0] instr;
input [4:0] status;
input rst, clk;
output reg pcsrc, alusrc, memrw, wb, regrw;
output reg [3:0] aluop;
output reg [1:0] immgen_ctrl;


always @(instr or rst) begin
	if(rst == 0) begin
		case(instr[6:0]) 
		7'b0110011: begin // R-Type Opcode
		pcsrc = 1'b0;
		alusrc = 1'b0; // A-Sel
		memrw = 1'b0;
		wb = 1'b0;
		regrw = 1'b1;
		immgen_ctrl = 2'b00; // not used for R-Type
		aluop = {instr[30], instr[14:12]}; // same for R and I Type
		end 
		
		7'b0010011: begin //I-Type Opcode
		pcsrc = 1'b0;
		alusrc = 1'b0;
		memrw = 1'b0;
		wb = 1'b0;
		regrw = 1'b1;
		immgen_ctrl = 2'b01; // From datapath imm_gen module
		aluop = {instr[30], instr[14:12]}; // same for R and I Type
		end
		
		7'b0000011: begin //LW (I-Type but different opcode)
		pcsrc = 1'b0;
		alusrc = 1'b1;
		memrw = 1'b0;
		wb = 1'b1;
		regrw = 1'b1;
		immgen_ctrl = 2'b01; //imm_gen module for I-Type
		aluop = 4'b0000;
		end
		
		7'b0100011: begin //S-Type opcode
		pcsrc = 1'b0;
		alusrc = 1'b1;
		memrw = 1'b0;
		wb = 1'b1;
		regrw = 1'b1;
		immgen_ctrl = 2'b10; //imm_gen module for S-Type
		aluop = 4'b0000;
		end
		
		7'b1100011: begin //B-Type opcode
		//pcsrc defined in case below
		alusrc = 1'b0;
		memrw = 1'b1;
		wb = 1'b1;
		regrw = 1'b0;
		immgen_ctrl = 2'b11; //imm_gen module for B-Type
		aluop = 4'b1000;
		end
		endcase
		
		case(instr[14:12]) //For pcsrc in B-Type
		3'b000: begin
		pcsrc = status[0] ? 1'b1 : 1'b0; // carry from status
		end
		3'b100: begin
		pcsrc = status[1] ? 1'b1 : 1'b0; // negative from status
		end
		endcase
	end
	else
		case(instr[6:0])
		7'b0000000: begin
		pcsrc = 1'b0;
		alusrc = 1'b0;
		memrw = 1'b0;
		wb = 1'b0;
		regrw = 1'b0;
		immgen_ctrl = 2'b00;
		aluop = 4'b0000;
		end
		endcase
end
endmodule
