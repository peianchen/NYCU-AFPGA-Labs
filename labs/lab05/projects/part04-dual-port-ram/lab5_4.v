module lab5_4(CLOCK_50, KEY, SW, LEDR, HEX0, HEX2, HEX3);
input CLOCK_50;
input[0: 0] KEY;
input[9: 0] SW;
output[0: 0] LEDR;
output[6: 0] HEX0, HEX2, HEX3;
wire clk, reset, we;
wire[4: 0] wAddr, rAddr;
wire[3: 0] dataIn, dataOut;
assign reset = KEY[0];
assign wAddr = SW[4: 0];
assign dataIn = SW[8: 5];
assign we = SW[9];
assign LEDR[0] = we;
assign rAddr = {3'b0,SW[1:0]};
assign wAddr = {3'b0,SW[3:2]};
delay_1s(CLOCK_50, clk);
//counter c(clk, reset, rAddr);
ram_2port(CLOCK_50, dataIn, rAddr, wAddr, we, dataOut);
segmentDecoder addr1(HEX3, (we&wAddr[4])|(~we&rAddr[4]));
segmentDecoder addr0(HEX2, ({4{we}}&wAddr[3:0])|({4{~we}}&rAddr[3: 0]));
segmentDecoder data(HEX0, dataOut);
endmodule
/*module counter(clk, reset, q);
input clk, reset;
output reg[4: 0] q;
always @(posedge clk or negedge reset) begin
if(!reset)
q <= 0;
else
q <= q+1;
end
endmodule*/

module segmentDecoder(Display, v);
input[3: 0] v;
output reg[6: 0] Display;
always begin
case(v)
0: Display = 7'b1000000;
1: Display = 7'b1111001;
2: Display = 7'b0100100;
3: Display = 7'b0110000;
4: Display = 7'b0011001;
5: Display = 7'b0010010;
6: Display = 7'b0000010;
7: Display = 7'b1011000;
8: Display = 7'b0000000;
9: Display = 7'b0010000;
10:Display = 7'b0001000;
11:Display = 7'b0000011;
12:Display = 7'b1000110;
13:Display = 7'b0100001;
14:Display = 7'b0000110;
15:Display = 7'b0001110;
default: Display = 7'b1111111;
endcase
end
endmodule 

module delay_1s(clock,delay);
input clock;
output reg delay;
reg [25:0] count;
always @(posedge clock)
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