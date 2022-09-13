module decoder_2to4 (D3, D2, D1, D0, A, B, EN);			//FAKE ONE
		input [1:0] A, B, EN;
		output D3, D2, D1, D0;
		reg D3, D2, D1, D0;
	
	always @ (A or B or EN) begin
		if (EN == 1'b1)
		case ({A, B})
				2'b00: {D3, D2, D1, D0} = 4'b1110;
				2'b01: {D3, D2, D1, D0} = 4'b1101;
				2'b10: {D3, D2, D1, D0} = 4'b1011;
				2'b11: {D3, D2, D1, D0} = 4'b0111;
				default: {D3, D2, D1, D0} = 4'bXXXX;
			endcase
		if (EN ==0) 
			{D3, D2, D1, D0} = 4'b1111;
		end
		endmodule
