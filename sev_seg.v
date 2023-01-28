module sev_seg(
	input reset, clk_1k,
	input reg [3:0] correct, wrong, fail, success,
	output reg [7:0] seg_data, seg_com
);

reg [3:0] carry_try;
reg [3:0] c_crt, c_wrg, c_try_c, c_try_w;
reg [2:0] sel_count;

reg [3:0] c_try = 0;

always@(posedge clk_1k or negedge reset) begin
	if(~reset) begin
		seg_com <= 8'b0; 
		sel_count <= 3'd0;
	end
	else begin
		sel_count <= sel_count + 3'b001;
		case(sel_count)
			3'b000 : seg_com <= 8'b1111_1110;
			3'b001 : seg_com <= 8'b1111_1101;
			3'b010 : seg_com <= 8'b1111_1111;
			3'b011 : seg_com <= 8'b1111_0111;
			3'b100 : seg_com <= 8'b1110_1111;
			3'b101 : seg_com <= 8'b1111_1111;
			3'b110 : seg_com <= 8'b1011_1111;
			3'b111 : seg_com <= 8'b0111_1111;
			default : seg_com <= seg_com;
		endcase
	end
end

always@(posedge correct or negedge reset) begin
		if(~reset) begin
			c_crt <= 0; c_try_c <= 0;
		end
		
		
		else begin
			c_crt <= c_crt +  4'd1;
			c_try_c <= c_try_c +  4'd1;
		end
end

always@(posedge wrong or negedge reset) begin
		if(~reset) begin
			c_wrg <= 0; c_try_w <= 0;
		end
		
		else if(wrong >= 3) begin
			c_wrg <= 0; c_try_w <= 0;
		end
		
		else begin
			c_wrg <= c_wrg +  4'd1;
			c_try_w <= c_try_w +  4'd1;
		end
end

always@(posedge c_try_c or posedge c_try_w) begin
	c_try <= c_try_c + c_try_w;
end

wire [7:0] seg_data_0, seg_data_1, seg_data_2, seg_data_3, seg_data_4, seg_data_5, seg_data_6, seg_data_7;
	
	seg_decode seg_7(.clk(clk_1k), .reset(reset), .data(carry_try), .seg_data(seg_data_7));
	seg_decode seg_6(.clk(clk_1k), .reset(reset), .data(c_try), .seg_data(seg_data_6));
	seg_decode seg_4(.clk(clk_1k), .reset(reset), .data(4'b0000), .seg_data(seg_data_4));
	seg_decode seg_3(.clk(clk_1k), .reset(reset), .data(c_crt), .seg_data(seg_data_3));
	seg_decode seg_1(.clk(clk_1k), .reset(reset), .data(4'b0000), .seg_data(seg_data_1));
	seg_decode seg_0(.clk(clk_1k), .reset(reset), .data(c_wrg), .seg_data(seg_data_0));

always@(posedge clk_1k or negedge reset) begin
	if(~reset) begin
		seg_data <= 8'd0;
	end
	else begin
		case(sel_count)
			3'b000 : seg_data <= seg_data_0;
			3'b001 : seg_data <= seg_data_1;
			3'b011 : seg_data <= seg_data_3;
			3'b100 : seg_data <= seg_data_4;
			3'b110 : seg_data <= seg_data_6;
			3'b111 : seg_data <= seg_data_7;
			default : seg_data <= seg_data;
		endcase
	end
end

endmodule
