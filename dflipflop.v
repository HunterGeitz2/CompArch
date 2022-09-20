 module dflipflop (q, data, clk, reset, enable);
 input data , clk, reset, enable; 
 output  reg q; 
 
 always @ ( posedge clk or negedge reset) 
  if (~reset) begin 
 q <= 1'b0; 
         end 
 else if (enable) begin 
  q <= data; 
       end
 endmodule