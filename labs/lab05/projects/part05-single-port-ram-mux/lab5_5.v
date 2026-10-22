module lab5_5(CLOCK_50,KEY,SW,LEDR,HEX0,HEX2,HEX3);
input CLOCK_50;
input[0:0] KEY;
input [9:0] SW;
output [0:0] LEDR;
output [6:0] HEX0, HEX2, HEX3;
wire [4:0] w_address;
wire [3:0] dataIn,dataOut,data ;
wire enable;
assign enable = SW[9];
assign LEDR[0] = enable;
assign w_address = SW[4:0];
assign dataIn[3:0] = SW[8:5];
Mux data_inout(dataIn, dataOut,enable, data);
segmentDecoder out(HEX0, data);	
segmentDecoder address_1(HEX2,w_address[3:0] );
segmentDecoder address_2(HEX3,w_address[4] );

ramlpm ram_32X4(
	.address(w_address), 
	.clock(CLOCK_50), 
	.data(dataIn), 
	.wren(enable), 
	.q(dataOut)
	);
	
	
endmodule	

module Mux(dataIn, dataOut,enable, data);
input [3:0]dataIn,dataOut;
input enable;
output[3: 0] data;
assign data = {4{~enable}}&dataOut | {4{enable}}&dataIn;
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