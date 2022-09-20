module tb_dff ();

reg data;
reg clk;
reg reset;
reg enable;
wire q;

    
    dflipflop uut (
        .clk(clk), 
        .enable(enable), 
        .reset(reset), 
        .data(data), 
        .q(q)
    ); 
	 
	
    initial clk = 0;
    always #10 clk =~clk;
    
    initial begin
       
        enable = 0;
        reset = 0;
        data = 0;
        
        #100;
       
        data=1;
        reset = 1; #100;
        reset = 0; #100;
        enable = 1; #100;
        data = 0;  #100;
        enable = 0; #100;
        data = 1;  #100;
        
    end
      
endmodule
