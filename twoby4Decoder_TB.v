module twoby4Decoder_TB;  
wire D3, D2, D1, D0; reg A, B; reg EN; 
// Instantiate the Decoder (named DUT {device under test}) 
decoder_2to4 DUT(D3, D2, D1, D0, A, B, EN); 
initial begin 
$timeformat (-9, 1, " ns", 6); #1; 
   A = 1'b0; // time = 0 
B = 1'b0; 
EN = 1'b0; 
#9; 
EN = 1'b1; // time = 10 
#10; 
A = 1'b0; 
B = 1'b1; // time = 20 
#10; 
A = 1'b1; 
B = 1'b0; // time = 30 
#10; 
A = 1'b1; 
B = 1'b1; // time = 40 
#5; EN = 1'b0; // time = 45
#5; end 

always @(A or B or EN) 
#1 $display("t=%t",$time," EN=%b",EN," A=%b",A," B=%b", B, "D=%b%b%b%b",D3,D2,D1,D0); 
endmodule
