module Vending_machine(
    input clk,
    input reset,
    input quater,
    input dollar,
    input [3:0] select,
    input buy,
    input [3:0] load,
    output reg [11:0] money=0,
    output reg [3:0] product=0,
    output reg [3:0] out_of_stock=0
    );
    reg quater_prev;
    reg dollar_prev;
    reg buy_prev;
    reg [3:0]stock0=4'b1111;
    reg [3:0]stock1=4'b1111;
    reg [3:0]stock2=4'b1111;
    reg [3:0]stock3=4'b1111;
    
    
    
    always @(posedge clk)
    begin
     quater_prev<=quater_prev;
     dollar_prev<=dollar_prev;
     buy_prev<=buy;
     
     
    if (reset)
    money=0;
    else if (quater_prev==0 && quater==1)
    money<=money+25;
     else if (dollar_prev==0 && dollar==1)
    money<=money+25;
    else if(buy_prev==0 && buy==1)
    case(select)
    4'b0001:
    begin
    if(money>=12'd25 && stock0>0)
    money<=money-25;
    stock0<=(stock0)-1'b1;
    product[0]<=1;
    end
    
     4'b0010:
    begin
    if(money>=12'd50 && stock1>0)
    money<=money-50;
    stock1<=(stock1)-1'b1;
    product[1]<=1;
    end
     4'b0100:
    begin
    if(money>=12'd75 && stock2>0)
    money<=money-75;
    stock2<=(stock2)-1'b1;
    product[2]<=1;
    end
     4'b1000:
    begin
    if(money>=12'd100 && stock3>0)
    money<=money-100;
    stock3<=(stock3)-1'b1;
    product[3]<=1;
    end
    endcase
   
else if(buy_prev==1 && buy==0)
    begin 
    product[0]=0;
    product[1]=0;
    product[2]=0;
    product[3]=0;
    end 
    
 else 
    begin 
    if(stock0==0)
    out_of_stock[0]=1;
    
    else out_of_stock[0]=0;
    if(stock1==0)
    out_of_stock[1]=1;
    else out_of_stock[1]=0;
    
    if(stock2==0)
    out_of_stock[2]=1;
    else out_of_stock[2]=0;
    
    if(stock3==0)
    out_of_stock[3]=1;
    else out_of_stock[3]=0;
    
    end
    
    case(load)
    4'b0001:stock0<=4'b1111;
    4'b0010:stock1<=4'b1111;
    4'b0100:stock2<=4'b1111;
    4'b1000:stock3<=4'b1111;
    endcase 
      end  
endmodule