module lab2_6(CLOCK_50, KEY, HEX0, HEX1, HEX2);
input CLOCK_50;
input[0: 0] KEY;
output[6: 0] HEX0, HEX1, HEX2;
wire clk, reset;
wire[3: 0] d0, d1, d2;
wire[2:0] f;
assign reset = KEY[0];
delay_1s(CLOCK_50,clk);
modNCounter digit0(clk, reset, 1'b1, f[0], d0);
modNCounter digit1(clk, reset, f[0], f[1], d1);
modNCounter digit2(clk, reset, f[0]&f[1], f[2], d2);
BCDDecoder segment0(HEX0, d0);
BCDDecoder segment1(HEX1, d1);
BCDDecoder segment2(HEX2, d2);
endmodule

module delay_1s(clk,delay);
output reg delay;
input clk;
reg [25:0] count;
always @(posedge clk)
begin
if(count==26'd49_999_999)
begin
count<=26'd0;
delay<=1;
end
else
begin
count<=count+1;
delay<=0;
end
end
endmodule

module BCDDecoder(Display, v);
input[3: 0] v;
output reg[6: 0] Display;
always @(v) begin
case(v)
4'b0000: Display = 7'b1000000;
4'b0001: Display = 7'b1111001;
4'b0010: Display = 7'b0100100;
4'b0011: Display = 7'b0110000;
4'b0100: Display = 7'b0011001;
4'b0101: Display = 7'b0010010;
4'b0110: Display = 7'b0000010;
4'b0111: Display = 7'b1011000;
4'b1000: Display = 7'b0000000;
4'b1001: Display = 7'b0010000;
default: Display = 7'b1111111;
endcase
end
endmodule

module modNCounter(clk, reset, enable, full, q);
input clk, reset, enable;
wire[3: 0] n;
output reg[3: 0] q;
output reg full;
assign n = 4'b1000;
initial begin
q <= 0;
full <= 0;
end

always @(posedge clk or negedge reset) begin
if(!reset) begin 
q <= 0;
full <= 0;
end
else if(enable) 
begin
if(q == n) begin
full <= 0;
q <= 0;
end
else if(q+1 == n) begin
full <= 1;
q <= q+1;
end
else
q <= q+1;
end
end
endmodule
