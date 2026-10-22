module lab6_1(SW,KEY,LEDR,HEX0, HEX1, HEX2, HEX3, HEX4, 
HEX5);
input [9:0] SW;
input [1:0] KEY;
output[6: 0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output [9:0] LEDR;
wire [7:0] DIN,bus;
wire resetn,clk,done,run;
assign DIN = SW[7:0];
assign run = SW[9];
assign resetn = KEY[0];
assign clk = KEY[1];
assign LEDR[7:0] = bus;
assign LEDR[9] = done;
processor PRO(DIN,resetn,clk,run,done,bus);
segmentDecoder d0(HEX0, bus[3: 0]);
segmentDecoder d1(HEX1, bus[7: 4]);
/*
segmentDecoder d2(HEX2, q0[3: 0]);
segmentDecoder d3(HEX3, q0[7: 4]);
segmentDecoder d4(HEX4, dIn[3: 0]);
segmentDecoder d5(HEX5, dIn[7: 4]);
*/
endmodule

module processor(DIN,resetn,clk,run,done,bus);
input [7:0] DIN;
input resetn,clk,run;
output [7:0] bus;
output done;
wire [7:0] IR_out,R_out,R_in,R0,R1,R2,R3,R4,R5,R6,R7,A,G,g;
wire [1:0] Tstep_Q;
wire IR_in, G_out, G_in, DIN_out, A_in, AddSub, done;
wire clear;
regn r_IR(DIN,IR_in,clk,IR_out);
regn r_R0(bus,R_in[7],clk,R0);
regn r_R1(bus,R_in[6],clk,R1);
regn r_R2(bus,R_in[5],clk,R2);
regn r_R3(bus,R_in[4],clk,R3);
regn r_R4(bus,R_in[3],clk,R4);
regn r_R5(bus,R_in[2],clk,R5);
regn r_R6(bus,R_in[1],clk,R6);
regn r_R7(bus,R_in[0],clk,R7);
regn r_A(bus,A_in,clk,A);
regn r_G(g,G_in,clk,G);
mux _m(R_out,G_out,DIN_out,R0,R1,R2,R3,R4,R5,R6,R7,G,DIN,bus);
addsub as(AddSub, A, bus, g);
counter step(clk, clear|done, Tstep_Q);
control_unit CU(IR_out,Tstep_Q,run,resetn,R_out,IR_in, G_out, 
						  DIN_out, R_in, A_in, G_in, AddSub, clear, done);
endmodule
module control_unit(IR_out,Tstep_Q,run,resetn,R_out,IR_in, G_out, 
						  DIN_out, R_in, A_in, G_in, AddSub, clear, done);
input [7:0] IR_out;
input [1:0] Tstep_Q;
input run,resetn;
output reg [7:0] R_out,R_in;
output reg IR_in, G_out, G_in, DIN_out, A_in, AddSub, done;
output clear;
wire [1:0] II;
wire [2:0] XXX,YYY;
wire [7:0] RX,RY;
assign II = IR_out[7:6];
assign XXX = IR_out[5:3];
assign YYY = IR_out[2:0];
assign clear = ~resetn;
dec3to8 _RX(XXX,1'b1,RX);
dec3to8 _RY(YYY,1'b1,RY);
always@(Tstep_Q,II,RY,RX)
begin
case(Tstep_Q)
	2'b00:
	begin
	IR_in = 1'b1;
	end
	2'b01:
	begin
		if(II==2'b00)
			begin
			R_out = RY;
			R_in = RX;
			done = 1'b1;
			end
		else if(II==2'b01)
			begin
			DIN_out = 1'b1;
			R_in = RX;
			done = 1'b1;
			end
		else
			begin
			R_out = RX;
			A_in = 1'b1;
			end	
	end
	2'b10:
	begin
		if(II==2'b10)
			begin
			R_out = RY;
			G_in = 1'b1;
			end
		else if(II==2'b11)
			begin
			R_out = RY;
			G_in = 1'b1;
			AddSub = 1'b1;
			end
	end
	2'b11:
	begin
		if(II==2'b10)
			begin
			G_out = 1'b1;
			R_in = RX;
			done = 1'b1;
			end
		if(II==2'b11)
			begin
			G_out = 1'b1;
			R_in = RX;
			done = 1'b1;
			end
	end
endcase
end

endmodule

module mux(R_out,G_out,DIN_out,R0,R1,R2,R3,R4,R5,R6,R7,G,DIN,bus);
input [7:0] R_out;
input G_out,DIN_out;
input [7:0] R0,R1,R2,R3,R4,R5,R6,R7,G,DIN;
output reg[7:0] bus;
always@(*)begin
if(DIN_out) bus = DIN;
else if(G_out) bus = G;
else if(R_out[7]) bus = R0;
else if(R_out[6]) bus = R1;
else if(R_out[5]) bus = R2;
else if(R_out[4]) bus = R3;
else if(R_out[3]) bus = R4;
else if(R_out[2]) bus = R5;
else if(R_out[1]) bus = R6;
else if(R_out[0]) bus = R7;
else bus = 8'bzzzzzzzz;
end
endmodule

module counter(clk, clear, Q);
input clk, clear;
output reg[1: 0] Q;
always @(posedge clk) 
begin
if(clear)
Q <= 0;
else
Q <= Q+1;
end
endmodule

module dec3to8(W,En,Y);
input[2: 0] W;
input En;
output reg[7: 0] Y;
always @(En or W) begin
if(En==1'b1)
case(W)
	3'b000: Y=8'b10000000;
	3'b001: Y=8'b01000000;
	3'b010: Y=8'b00100000;
	3'b011: Y=8'b00010000;
	3'b100: Y=8'b00001000;
	3'b101: Y=8'b00000100;
	3'b110: Y=8'b00000010;
	3'b111: Y=8'b00000001;
endcase
else
			  Y=8'b00000000;
end
endmodule

module regn(R,Rin,clk,Q);
parameter n = 8;
input [n-1:0] R;
input Rin,clk;
output reg [n-1:0]Q;
always@(posedge clk)
begin
if(Rin)
	Q<=R;
else
	Q<=Q;
end
endmodule	

module addsub(M, a, b, g);
input M;
input[7: 0] a, b;
output[7: 0] g;
assign g = ({8{M}}&(a-b)) | ({8{~M}}&(a+b));
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