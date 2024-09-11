module Debounce(
    input pb,
    input clk_in,
    output led
    );
    wire clk_out;
    wire Q2,Q1,Q2_bar;
    D_FF D1(clk_out,pb,Q1);
    D_FF D2(clk_out,Q1,Q2);
    assign Q2_bar=~Q2;
    assign led =Q1&Q2_bar;
     
endmodule