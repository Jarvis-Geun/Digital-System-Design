// the module which represents clock division - 12.5MHz, 100kHz, 10kHz, 1kHz, ...
module clk_div(
    input clk_25M, reset,
    output reg clk_12_5M, clk_100k, clk_10k, clk_1k, clk_1s, clk_h, clk_step, clk_led, clk_500
);

reg [7:0] c1 = 0;
reg [11:0] c2 = 0;
reg [14:0] c3 = 0;
reg [24:0] c4 = 0;
reg [17:0] c5 = 0;
reg [16:0] c6 = 0;
reg [23:0] c7 = 0;
reg [14:0] c8 = 0;

always @(posedge clk_25M or negedge reset) begin
       if(reset == 1'b0)
          begin
               c1 <= 0;
               c2 <= 0;
               c3 <= 0;
               c4 <= 0;
               c5 <= 0;
               c6 <= 0;
			   c8 <= 0;
          end
        else begin


             // 12.5MHz
                   clk_12_5M <= ~clk_12_5M;


             // 100KHz
             if(c1 >= 8'd124)
                begin
                    clk_100k <= ~clk_100k;
                    c1 <= 0;
             end
             else c1 <= c1 + 1'b1;


             // 10KHz
             if(c2 >= 12'd1249)
                begin
                    clk_10k <= ~clk_10k;
                    c2 <= 0;
             end
             else c2 <= c2 + 1'b1;


             // 1KHz 12500
             if(c3 >= 15'd12499)
                begin
                    clk_1k <= ~clk_1k;
                    c3 <= 0;
             end
             else c3 <= c3 + 1'b1;


             // 500Hz
             if(c8 >= 15'd24999)
                begin
                    clk_500 <= ~clk_500;
                    c8 <= 0;
             end
             else c8 <= c8 + 1'b1;


             // 1sec
             if(c4 >= 25'd12499999)
                begin
                    clk_1s <= ~clk_1s;
                    c4 <= 0;
             end
             else c4 <= c4 + 1'b1;


             // clk_h
             if(c5 >= 18'd124999)
                begin
                    clk_h <= ~clk_h;
                    c5 <= 0;
             end
             else c5 <= c5 + 1'b1;


             // clk_step
             if(c6 >= 17'd62499)
                begin
                    clk_step <= ~clk_step;
                    c6 <= 0;
             end
             else c6 <= c6 + 1'b1;


             // clk_led
             if(c7 >= 24'd6249999)
                begin
                    clk_led <= ~clk_led;
                    c7 <= 0;
             end
             else c7 <= c7 + 1'b1;
       end
    end
endmodule