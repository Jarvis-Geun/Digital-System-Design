module led_dir(
    output reg [15:0] led,
    input [3:0] wrong,
	input fail, reset, clk
);

reg [15:0] wrong_count;

always @(posedge wrong or negedge reset) begin 
    if (reset == 1'b0) begin 
        wrong_count <= 16'b0000_0000_0000_0000;
    end

    else begin
	wrong_count <= wrong_count + 1;
    end
end

always@(posedge clk or negedge reset) begin
        	if (reset == 1'b0) begin
		led <= 16'b0000_0000_0000_0000;
	end
	
	else begin
		case(wrong_count)
			0 : led <= 16'b0000_0000_0000_0000;
              		1 : led <= 16'b0000_0000_0000_0001;
              		2 : led <= 16'b0000_0000_0000_0011;
       	  		3 : led <= 16'b0000_0000_0000_0111;
              		4 : led <= 16'b0000_0000_0000_1111;
            			5 : led <= 16'b0000_0000_0001_1111;
             			6 : led <= 16'b0000_0000_0011_1111;
             			7 : led <= 16'b0000_0000_0111_1111;
            			8 : led <= 16'b0000_0000_1111_1111;
             			9 : led <= 16'b0000_0001_1111_1111;
             			default : led <= 16'b1111_1111_1111_1111;
		endcase
	end
end

endmodule