# Design_and_Simulate_the_Memory_Design_using_verilog_HDL
# EXP NO:5. Design-and-Simulate the-Memory-Design-using-Verilog-HDL
# Aim 
To design and simulate a RAM,ROM,FIFO using Verilog HDL, and verify its functionality through a testbench in the Vivado 2024.2 environment. 

# Apparatus Required 
Vivado 2024.2 

# Procedure
1. Launch Vivado 2023.1 Open Vivado and create a new project.
2. Design the Verilog Code Write the Verilog code for the RAM,ROM,FIFO
3. Create the Testbench Write a testbench to simulate the memory behavior. The testbench should apply various and monitor the corresponding output.
4. Create the Verilog Files Create both the design module and the testbench in the Vivado project.
5. Run Simulation Run the behavioral simulation to verify the output.
6. Observe the Waveforms Analyze the output waveforms in the simulation window, and verify that the correct read and write operation.
7. Save and Document Results Capture screenshots of the waveform and save the simulation logs. These will be included in the lab report.

# Code
# RAM
<h3>Verilog Code</h3>

```
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

```

<h3>Test Bench</h3>

```
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
```

<h3>Output Waveform</h3>

![image](https://github.com/subhashspace/Design_and_Simulate_the_Memory_Design_using_verilog_HDL/blob/main/ram_8x8.png)

# ROM

<h3>Verilog Code</h3>

```
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
```

<h3>Test Bench</h3>

```
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
```

<h3>Output Waveform</h3>

![image](https://github.com/subhashspace/Design_and_Simulate_the_Memory_Design_using_verilog_HDL/blob/main/rom_random.png)

# FIFO
<h3>Verilog Code</h3>

```
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
```

<h3>Test Bench</h3>

```
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
```

<h3>Output Waveform</h3>

![image](https://github.com/subhashspace/Design_and_Simulate_the_Memory_Design_using_verilog_HDL/blob/main/fifo_8x8.png)

# Conclusion
The RAM, ROM, FIFO memory with read and write operations was designed and successfully simulated using Verilog HDL. The testbench verified both the write and read functionalities by simulating the memory operations and observing the output waveforms. The experiment demonstrates how to implement memory operations in Verilog, effectively modeling both the reading and writing processes.
