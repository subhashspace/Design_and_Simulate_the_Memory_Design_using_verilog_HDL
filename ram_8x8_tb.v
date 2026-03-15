module ram_8x8_tb;
reg clk;
reg we;
reg [2:0] addr;
reg [7:0] din;
wire [7:0] dout;

ram_8x8 uut (clk,we,addr,din,dout);
always #5 clk = ~clk;

initial 
begin
    clk = 0;
    we  = 0;
    addr = 0;
    din = 0;
    #10 
    we = 1; 
    addr = 3'b000; 
    din = 8'hA1;
    
    #10 
    addr = 3'b001; 
    din = 8'hB2;
    
    #10 
    addr = 3'b010; 
    din = 8'hC3;
    
    #10
     we = 0;
    #10 
    addr = 3'b000;
    #10 
    addr = 3'b001;
    #10 
    addr = 3'b010;

    #20 $stop;
end

endmodule