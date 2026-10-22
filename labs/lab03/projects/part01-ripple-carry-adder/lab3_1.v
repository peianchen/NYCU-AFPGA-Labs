module lab3_1(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [1:0]KEY;
input [8:0]SW;
output [8:0]LEDR;
output [6:0]HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
wire [7:0]cout;
wire [7:0]A,B,value,sum,sum_d;
wire clock, reset,enable,overflow,overflow_d,cin;
assign reset = KEY[0];
assign clock = KEY[1];
assign cin = 1'b0;
assign enable = SW[8];
assign value = SW[7:0];
assign LEDR[7:0] = sum_d[7:0];
assign LEDR[8] = overflow_d;

eight_bit_registered ebr_A(value,reset,clock,A,~enable);
eight_bit_registered ebr_B(value,reset,clock,B,enable);
eight_bit_registered ebr_s(sum,reset,clock,sum_d,1);

segmentDecoder s0(HEX0, sum_d[3: 0]);
segmentDecoder s1(HEX1, sum_d[7: 4]);
segmentDecoder b0(HEX2, B[3: 0]);
segmentDecoder b1(HEX3, B[7: 4]);
segmentDecoder a0(HEX4, A[3: 0]);
segmentDecoder a1(HEX5, A[7: 4]);


eight_bit_ripple_carry_adder ebrc(cin,A,B,sum,cout,overflow);

D_flipflop(overflow,clock,reset,overflow_d);
endmodule

module D_flipflop(D,clock,reset,Q);
input D,clock,reset;
output reg Q;
always@(posedge clock or negedge reset)
begin
if(!reset)
Q<= 1'b0;
	else
	Q <= D;
	end
endmodule

/*module eight_bit_ripple_carry_adder(cin,a,b,s,cout);
input cin;
input [7:0]a,b;
output [7:0]s,cout;
four_bit_ripple_carry_adder _a(cin,a[3:0],b[3:0],s[3:0],cout[3:0]);
four_bit_ripple_carry_adder _b(cout[3],a[7:4],b[7:4],s[7:4],cout[7:4]);
endmodule*/

module eight_bit_ripple_carry_adder(cin,a,b,s,cout,overflow);
input cin;
input[7:0]a,b;
output overflow;
output [7:0]s,cout;
wire [7:0]c;
wire [8:0]s;
assign c[0] = cin;
ripple_carry_adder fa(c[0], a[0], b[0], s[0], c[1]);
ripple_carry_adder fb(c[1], a[1], b[1], s[1], c[2]);
ripple_carry_adder fc(c[2], a[2], b[2], s[2], c[3]);
ripple_carry_adder fd(c[3], a[3], b[3], s[3], c[4]);
ripple_carry_adder fe(c[4], a[4], b[4], s[4], c[5]);
ripple_carry_adder ff(c[5], a[5], b[5], s[5], c[6]);
ripple_carry_adder fg(c[6], a[6], b[6], s[6], c[7]);
ripple_carry_adder fh(c[7], a[7], b[7], s[7], s[8]);
assign overflow = c[7]^s[8];
endmodule


module ripple_carry_adder(cin,a,b,s,cout);
input cin,a,b;
output s,cout;
assign s = cin^a^b;
assign cout = (b&~(a^b))|(cin&(a^b));
endmodule

module eight_bit_registered(D,reset,clock,Q,enable);
input clock,reset,enable;
input [7:0]D;
output reg [7:0]Q;

always@(posedge clock or negedge reset)
begin
if(!reset)
Q <= 8'd0;
else if(enable)
Q <= D;
else
Q <= Q;
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

