module lab6_2(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, 
HEX5);
input[9: 9] SW;
input[2: 0] KEY;
output[9: 0] LEDR;
output[6: 0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
wire PClock, MClock, resetN, run, done;
wire[7: 0] dIn, bus, r0, r1;
wire[4: 0] addr;
assign PClock = KEY[2];
assign MClock = KEY[1];
assign resetN = KEY[0];
assign run = SW[9];
assign LEDR[9] = done;
assign LEDR[7: 0] = bus;
programCounter pc(MClock, resetN, addr);
myrom instructionMemory(addr, MClock, dIn);
processor p0(PClock, resetN, run, dIn, bus, done, r0, r1);
segmentDecoder d0(HEX0, r1[3: 0]);
segmentDecoder d1(HEX1, r1[7: 4]);
segmentDecoder d2(HEX2, r0[3: 0]);
segmentDecoder d3(HEX3, r0[7: 4]);
segmentDecoder d4(HEX4, dIn[3: 0]);
segmentDecoder d5(HEX5, dIn[7: 4]);
endmodule
module programCounter(clk, reset, n);
input clk, reset;
output reg[4: 0] n;
always @(posedge clk or negedge reset) begin
if(!reset)
n <= 0;
else
n <= n+1;
end
endmodule
module processor(clk, resetN, run, dIn, bus, done, register0, register1);
input clk, resetN, run;
input[7: 0] dIn;
output done;
output[7: 0] bus, register0, register1;
wire[7: 0] q0, q1, q2, q3, q4, q5, q6, q7, aq, gd, gq, irq;
wire[7: 0] rIn, rOut;
wire[1: 0] step;
wire clear, irin, gOut, dInOut, aIn, gIn, addOrSub;
wire resetN, clk, run, done;
reg8bit r0(clk, rIn[0], bus, q0);
reg8bit r1(clk, rIn[1], bus, q1);
reg8bit r2(clk, rIn[2], bus, q2);
reg8bit r3(clk, rIn[3], bus, q3);
reg8bit r4(clk, rIn[4], bus, q4);
reg8bit r5(clk, rIn[5], bus, q5);
reg8bit r6(clk, rIn[6], bus, q6);
reg8bit r7(clk, rIn[7], bus, q7);
reg8bit a(clk, aIn, bus, aq);
reg8bit g(clk, gIn, gd, gq);
addSub alu(addOrSub, aq, bus, gd);
multiplexer m(rOut, gOut, dInOut, dIn, q0, q1, q2, q3, q4, q5, q6, q7, gq, 
bus);
reg8bit ir(clk, irin, dIn, irq);
upCount c(clk, clear, step);
controlUnit cu(irq, run, resetN, step, clear, irin, rOut, gOut, dInOut, rIn, aIn, 
gIn, addOrSub, done);
assign register0 = q0;
assign register1 = q1;
endmodule
module controlUnit(ir, run, resetN, step, clear, irin, rOut, gOut, dInOut, rIn, aIn, 
gIn, addOrSub, done);
input[7: 0] ir;
input run, resetN;
input[1: 0] step;
output clear, irin, gOut, dInOut, aIn, gIn, addOrSub, done;
output[7: 0] rOut, rIn;
wire[7: 0] x, y, rXOut, rYOut;
wire[1: 0] op;
assign op = ir[7: 6];
dec3to8 xIndex(ir[5: 3], x);
dec3to8 yIndex(ir[2: 0], y);
assign rXOut = {8{step==1}}&{8{op[1]}} & x;
assign rYOut = ({8{step==1}}&{8{op==2'b00}}&y) | 
({8{step==2}}&{8{op[1]}}&y);
assign clear = resetN&(~((step==0)&(~run)))&(~done);
assign irin = ((step==0)&run) & resetN;
assign gOut = ((step==3)&(op[1])) & resetN;
assign dInOut = ((step==1)&(op==2'b01)) & resetN;
assign aIn = ((step==1)&(op[1])) & resetN;
assign gIn = ((step==2)&(op[1])) &resetN;
assign addOrSub = (step==2)&(op==2'b11);
assign done = ((~op[1])&(step==1)) | ((op[1])&(step==3));
assign rOut = (rXOut | rYOut) & {8{resetN}};
assign rIn = (({8{step==1}}&{8{~op[1]}}&x) | 
({8{step==3}}&{8{op[1]}}&x)) & {8{resetN}};
endmodule
module dec3to8(w, y);
input[2: 0] w;
output reg[7: 0] y;
always @(w) begin
case(w)
3'b000: y=8'b00000001;
3'b001: y=8'b00000010;
3'b010: y=8'b00000100;
3'b011: y=8'b00001000;
3'b100: y=8'b00010000;
3'b101: y=8'b00100000;
3'b110: y=8'b01000000;
3'b111: y=8'b10000000;
endcase
end
endmodule
module addSub(addOrSub, a, b, g);
input addOrSub;
input[7: 0] a, b;
output[7: 0] g;
assign g = ({8{addOrSub}}&(a-b)) | ({8{~addOrSub}}&(a+b));
endmodule
module multiplexer(rOut, gOut, dInOut, dIn, r0, r1, r2, r3, r4, r5, r6, r7, g, bus);
input[7: 0] rOut, dIn, r0, r1, r2, r3, r4, r5, r6, r7, g;
input gOut, dInOut;
output reg[7: 0] bus;
always @(*) begin
if(gOut) bus <= g;
else if(dInOut) bus <= dIn;
else if(rOut[0]) bus <= r0;
else if(rOut[1]) bus <= r1;
else if(rOut[2]) bus <= r2;
else if(rOut[3]) bus <= r3;
else if(rOut[4]) bus <= r4;
else if(rOut[5]) bus <= r5;
else if(rOut[6]) bus <= r6;
else if(rOut[7]) bus <= r7;
else bus <= 8'bzzzzzzzz;
end
endmodule
module upCount(clk, clear, q);
input clk, clear;
output reg[1: 0] q;
always @(posedge clk) begin
if(!clear)
q <= 0;
else
q <= q+1;
end
endmodule
module reg8bit(clk, enable, d, q);
input clk, enable;
input[7: 0] d;
output reg[7: 0] q;
always @(posedge clk) begin
if(enable)
q <= d;
else
q <= q;
end
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