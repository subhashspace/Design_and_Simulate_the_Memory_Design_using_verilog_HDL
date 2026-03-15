`timescale 1ns / 1ps

module fifo_8x8 (clk,rst,wr_en,rd_en,din,dout,full,empty);

    input  wire clk,rst,wr_en,rd_en;
    input  wire [7:0] din;

    output reg  [7:0] dout;

    output wire full,empty;

    reg [7:0] memory [0:7];   
    reg [2:0] wr_ptr = 0;
    reg [2:0] rd_ptr = 0;
    reg [3:0] count  = 0;    

    assign full  = (count == 8);
    assign empty = (count == 0);

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            dout   <= 0;
        end
        else begin
            if (wr_en && !full) 
            begin
                memory[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count  <= count + 1;
            end
            if (rd_en && !empty) 
            begin
                dout <= memory[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count  <= count - 1;
            end
        end
    end
endmodule