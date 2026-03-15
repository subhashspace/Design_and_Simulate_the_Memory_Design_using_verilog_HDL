module ram_8x8 (clk,we,addr,din,dout);
    input  wire clk,we;        
    input  wire [2:0]  addr;      
    input  wire [7:0]  din;      
    output reg  [7:0]  dout; 
    reg [7:0] memory [0:7];       
    always @(posedge clk) begin
        if (we)
            memory[addr] <= din;
    end
    always @(*) 
    begin
        dout = memory[addr];
    end
endmodule