`timescale 1ns / 1ps
module fifo_8x8_tb;

reg clk,rst,wr_en,rd_en;
reg [7:0] din;
wire [7:0] dout;
wire full,empty;

fifo_8x8 uut (clk,rst,wr_en,rd_en,din,dout,full,empty);

always #5 clk = ~clk;

initial 
begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    din = 0;
    #10 
    rst = 0;
    #10 
    wr_en = 1; 
    din = 8'hA1;
    #10 
    din = 8'hB2;
    #10 
    din = 8'hC3;
    #10 
    wr_en = 0;
    #10 
    rd_en = 1;
    #30 
    rd_en = 0;

    #20 $stop;
end
endmodule