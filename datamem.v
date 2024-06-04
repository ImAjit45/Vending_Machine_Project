module datamem(input clk,rd,wr,//clock,mem write and mem read signals
input [63:0]addr,wrdata,//address from alu and write data from registers
output reg [63:0]rddata);

reg [63:0]ram[65535:0];
always @(posedge clk)
begin
  if(rd && !wr) rddata=ram[addr];//for read 
  if(!rd && wr) ram[addr]=wrdata;//for write
end
endmodule
module tb_datamem();
  // Testbench signals
  reg clk;
  reg rd;
  reg wr;
  reg [63:0] addr;
  reg [63:0] wrdata;
  wire [63:0] rddata;
  
  // Instantiate the datamem module
  datamem uut (
    .clk(clk),
    .rd(rd),
    .wr(wr),
    .addr(addr),
    .wrdata(wrdata),
    .rddata(rddata)
  );
  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units clock period
  end
  
  // Test sequence
  initial begin
   

    // Write data to address 0
    addr = 64'h0000_0000_0000_0000;
    wrdata = 64'h0000_0000_0000_0001;
    wr = 1;
    rd = 0;
    #10;
    wr = 0;

    // Wait for write to complete
    #10;

    // Read data from address 0
    addr = 64'hEDABABBABABDDDFF;
    rd = 1;
    wr = 0;
    #10;
    rd = 0;

    // Wait for read to complete
    #10;

    // Write data to address 1
    addr = 64'h0000_0000_0000_0001;
    wrdata = 64'hABABBABABBBABABA;
    wr = 1;
    rd = 0;
    #10;
    wr = 0;

    // Wait for write to complete
    #10;

    // Read data from address 1
    addr = 64'h0000_0000_0000_0001;
    rd = 1;
    wr = 0;
    #10;
    rd = 0;

    // Wait for read to complete
    #10;

    // Stop simulation
    $stop;
  end

  // Monitor outputs
  initial begin
    $monitor("Time: %0t | addr: %0h | wrdata: %0h | rddata: %0h | rd: %b | wr: %b", 
             $time, addr, wrdata, rddata, rd, wr);
  end
endmodule
