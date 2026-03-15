`timescale 1ns / 1ps
module rom_random (addr,data);
    input  wire [2:0] addr;  
    output reg  [7:0] data;   
    reg [7:0] memory [0:7];  
    integer i;

    initial
    begin
        for (i = 0; i < 8; i = i + 1) begin
            memory[i] = $random;
        end
    end
    always @(*)
    begin
        data = memory[addr];
    end
endmodule