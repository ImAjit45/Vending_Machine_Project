module Top_Module(
    input clk,
    input btnU,//reset
    input btnC,//buy
    input btnR,//quater
    input btnL,//dollar
    input [7:0] sw,//first  4 for selecting item ,remaining 4  for loading
    output [7:0] led,//first 4 to show which item is selected ,next 4 to show out  of stock item.
    output  [6:0] seg,//display 
    output   [3:0] an//for chosing segments from the four available display
    
    );
    wire [11:0] money;//amount of money put in the device
    
    wire deb_btnC,deb_btnR,deb_btnL,deb_btnU;
    Debounce    dbnU(clk,btnC,deb_btnU);
    Debounce    dbnC(clk,btnC,deb_btnC);
     Debounce   dbnR(clk,btnR,deb_btnR);
    Debounce    dbnL(clk,btnL,deb_btnL); 
    wire [3:0]thos,huns,tens,ones;
    Bnary_decimal BCD(money,thos,huns,tens,one);
    
    Seven_Segment_Driver SSD(clk,deb_btnU,thos,huns,tens,ones,seg,an);
    Vending_machine(clk,deb_btnU,deb_btnR,deb_btnL,sw[3:0],deb_btnC,sw[7:4],money,led[3:0],led[7:4]);
    endmodule
