module text_lcd(
       input clk, reset,
       input reg [3:0] wrong, correct, up_down,
       output lcd_en,
       output reg lcd_rs, lcd_rw,
       output reg [7:0] lcd_data
);
  reg [9:0] count;
  reg [2:0] state;
  parameter [2:0] delay = 3'b000,
                  function_set = 3'b001,
                  disp_on_off = 3'b010,
                  entry_mode_set = 3'b011,
                  Fline = 3'b100,
                  Sline = 3'b101;
  assign lcd_en = clk;

  always @(posedge clk or negedge reset) begin
        if(reset == 1'b0) begin
           state <= delay;
           count <= 0;
        end
        else
            case(state)
                 delay :          if(count == 10'd70) begin
                                     state <= function_set;
                                     count <= 0;
                                  end
                                  else count <= count + 1;

                 function_set :   if(count == 10'd30) begin
                                     state <= disp_on_off;
                                     count <= 0;
                                  end
                                  else count <= count + 1;
                 disp_on_off :    if(count == 10'd30) begin
                                     state <= entry_mode_set;
                                     count <= 0;
                                  end
                                  else count <= count + 1;
                 entry_mode_set : if(count == 10'd30) begin
                                     state <= Fline;
                                     count <= 0;
                                  end
                                  else count <= count + 1;
                 Fline :          if(count == 10'd16) begin
                                     state <= Sline;
                                     count <= 0;
                                  end
                                  else count <= count + 1;
                 Sline :          if(count == 10'd16) begin
                                     count <= 0;
                                  end
                                  else count <= count +1;
                 default : ;
             endcase
         end

  always@(posedge clk or negedge reset) begin
        if(reset == 1'b0) begin
           lcd_rs <= 1; lcd_rw <= 1;
           lcd_data <= 8'b0000_0000;
        end
        else begin
             if((wrong == 0) && (correct == 0)) begin
                 case(state)
                      delay :          begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
                      function_set :   begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
                      disp_on_off :    begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
                      entry_mode_set : begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end
                      Fline : begin
                              lcd_rw <= 0;
                              case(count)
                                   0 : begin lcd_rs <= 0; lcd_data <= 8'd128; end
  
                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd85; end  // U
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd80; end  // P
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd38; end  // &
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd68; end  // D
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd79; end  // O
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd87; end  // W
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd78; end  // N
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd71; end  // G
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd97; end  // a
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd109; end // m
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   default : ;
                              endcase
                              end
                      Sline : begin
                              lcd_rw <= 0;
                              case(count)
                                   0 : begin lcd_rs <= 0; lcd_data <= 8'd192; end
  
                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   default : ;
                              endcase
                              end
                       endcase
                  end 
           else if(up_down == 1) begin // UP
               case(state)
                    delay :          begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
                    function_set :   begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
                    disp_on_off :    begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
                    entry_mode_set : begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end
                    Fline : begin
                            lcd_rw <= 0;
                            case(count)
                                 0 : begin lcd_rs <= 0; lcd_data <= 8'd128; end

                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd85; end  // U
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd80; end  // P
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd38; end  // &
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd68; end  // D
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd79; end  // O
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd87; end  // W
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd78; end  // N
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd71; end  // G
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd97; end  // a
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd109; end // m
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 default : ;
                            endcase
                            end
                    Sline : begin
                            lcd_rw <= 0;
                            case(count)
                                 0 : begin lcd_rs <= 0; lcd_data <= 8'd192; end

                                 1  : begin lcd_rs <= 1; lcd_data <= 8'd85; end // U
                                 2  : begin lcd_rs <= 1; lcd_data <= 8'd80; end // P
                                 3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 4  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 6  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 7  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 8  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 9  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 11 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 12 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 13 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 14 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                 default : ;
                            endcase
                            end
                     endcase
                end
                else if(up_down == 2) begin
                case(state)
                     delay :          begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
                     function_set :   begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
                     disp_on_off :    begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
                     entry_mode_set : begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end
                     Fline : begin
                             lcd_rw <= 0;
                             case(count)
                                  0 : begin lcd_rs <= 0; lcd_data <= 8'd128; end

                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd85; end  // U
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd80; end  // P
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd38; end  // &
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd68; end  // D
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd79; end  // O
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd87; end  // W
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd78; end  // N
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd71; end  // G
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd97; end  // a
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd109; end // m
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  default : ;
                             endcase
                             end
                     Sline : begin
                             lcd_rw <= 0;
                             case(count)
                                  0 : begin lcd_rs <= 0; lcd_data <= 8'd192; end
 
                                  1  : begin lcd_rs <= 1; lcd_data <= 8'd68; end // D
                                  2  : begin lcd_rs <= 1; lcd_data <= 8'd79; end // O
                                  3  : begin lcd_rs <= 1; lcd_data <= 8'd87; end // W
                                  4  : begin lcd_rs <= 1; lcd_data <= 8'd78; end // N
                                  5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  6  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  7  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  8  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  9  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  11 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  12 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  13 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  14 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                  default : ;
                             endcase
                             end
                      endcase
                 end
               else if (up_down == 5) begin
                 case(state)
                      delay :          begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
                      function_set :   begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
                      disp_on_off :    begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
                      entry_mode_set : begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end
                      Fline : begin
                              lcd_rw <= 0;
                              case(count)
                                   0 : begin lcd_rs <= 0; lcd_data <= 8'd128; end
  
                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd85; end  // U
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd80; end  // P
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd38; end  // &
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd68; end  // D
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd79; end  // O
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd87; end  // W
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd78; end  // N
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd71; end  // G
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd97; end  // a
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd109; end // m
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   default : ;
                              endcase
                              end
                      Sline : begin
                              lcd_rw <= 0;
                              case(count)
                                   0 : begin lcd_rs <= 0; lcd_data <= 8'd192; end
  
                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd71; end  // G
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd97; end  // a
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd109; end // m
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd111; end // o
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd118; end // v
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd114; end // r
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   default : ;
                              endcase
                              end
                       endcase
                  end

                 else if (correct > 0) begin
                 case(state)
                      delay :          begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0000; end
                      function_set :   begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0011_1000; end
                      disp_on_off :    begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_1111; end
                      entry_mode_set : begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b0000_0110; end
                      Fline : begin
                              lcd_rw <= 0;
                              case(count)
                                   0 : begin lcd_rs <= 0; lcd_data <= 8'd128; end
  
                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd85; end  // U
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd80; end  // P
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd38; end  // &
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd68; end  // D
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd79; end  // O
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd87; end  // W
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd78; end  // N
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd71; end  // G
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd97; end  // a
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd109; end // m
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   default : ;
                              endcase
                              end
                      Sline : begin
                              lcd_rw <= 0;
                              case(count)
                                   0 : begin lcd_rs <= 0; lcd_data <= 8'd192; end
  
                                   1  : begin lcd_rs <= 1; lcd_data <= 8'd83; end  // S
                                   2  : begin lcd_rs <= 1; lcd_data <= 8'd117; end // u
                                   3  : begin lcd_rs <= 1; lcd_data <= 8'd99; end  // c
                                   4  : begin lcd_rs <= 1; lcd_data <= 8'd99; end  // c
                                   5  : begin lcd_rs <= 1; lcd_data <= 8'd101; end // e
                                   6  : begin lcd_rs <= 1; lcd_data <= 8'd115; end // s
                                   7  : begin lcd_rs <= 1; lcd_data <= 8'd115; end // s
                                   8  : begin lcd_rs <= 1; lcd_data <= 8'd33; end
                                   9  : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   10 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   11 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   12 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   13 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   14 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   15 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   16 : begin lcd_rs <= 1; lcd_data <= 8'd32; end
                                   default : ;
                              endcase
                              end
                       endcase
                  end
end
end
endmodule                    