module lab5_1(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3);
input [9:0]SW;
input [0:0]KEY;
output [0:0]LEDR;
output [6:0]HEX0,HEX1,HEX2,HEX3;
wire [3:0]dataIn = SW[3:0];
wire [4:0] _address = SW[8:4];
wire enable = SW[9];
wire clk = KEY[0];
wire [3:0]dataOut;
assign LEDR[0] = enable;

ramlpm (
	.address(_address), 
	.clock(clk), 
	.data(dataIn), 
	.wren(enable), 
	.q(dataOut)
	);
segmentDecoder out(HEX0, dataOut);	
segmentDecoder in(HEX1, dataIn);
segmentDecoder address_1(HEX2, _address[3:0]);
segmentDecoder address_2(HEX3, _address[4:4]);
endmodule
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