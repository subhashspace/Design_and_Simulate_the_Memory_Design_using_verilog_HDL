`timescale 1ns / 1ps
module rom_random_tb;

reg  [2:0] addr;
wire [7:0] data;
rom_random uut (addr,data);

initial
begin
    addr = 3'b000;
    #10 
    addr = 3'b001;
    #10 
    addr = 3'b010;
    #10 
    addr = 3'b011;
    #10 
    addr = 3'b100;
    #10 
    addr = 3'b101;
    #10 
    addr = 3'b110;
    #10 
    addr = 3'b111;
    #10 $stop;
end
endmodule