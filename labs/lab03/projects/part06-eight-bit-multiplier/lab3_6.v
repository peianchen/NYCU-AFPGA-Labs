module lab3_6(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3);
input[3: 0] KEY;
input[9: 0] SW;
output[9: 9] LEDR;
output[6: 0] HEX0, HEX1, HEX2, HEX3;
wire clock, reset,enable,W_enable,select,c_dis;
wire[7: 0] value, A, B, C, D;
wire[15: 0] ab, cd, Sum, result,display;
assign reset = KEY[0];
assign clock = KEY[1];
assign select = KEY[2];
assign c_dis = KEY[3];
assign W_enable = SW[9];
assign enable = SW[8];
assign value = SW[7:0];
assign LEDR[9] = carry_out;
eight_bit_registered ebrA(value,reset,clock,A,(select)&(~enable)&(W_enable));
eight_bit_registered ebrB(value,reset,clock,B,(~select)&(~enable)&(W_enable));
eight_bit_registered ebrC(value,reset,clock,C,(select)&(enable)&(W_enable));
eight_bit_registered ebrD(value,reset,clock,D,(~select)&(enable)&(W_enable));
Change_display c_d(c_dis, enable, A, B, C, D, Sum, display);
eight_bit_Mulitiplier ebmab(A,B,ab);
eight_bit_Mulitiplier ebmcd(C,D,cd);
_16_bit_add _16badd(ab,cd,Sum,carry_out);
segmentDecoder d0(HEX0, display[3: 0]);
segmentDecoder d1(HEX1, display[7: 4]);
segmentDecoder d2(HEX2, display[11: 8]);
segmentDecoder d3(HEX3, display[15: 12]);
endmodule

module _16_bit_add(a,b,s,carry_out);
input [15:0] a,b;
output carry_out;
output [15:0]s;
wire [15:0]c;
assign c[0] = 1'b0;
ripple_carry_adder f1(c[0], a[0], b[0], s[0], c[1]);
ripple_carry_adder f2(c[1], a[1], b[1], s[1], c[2]);
ripple_carry_adder f3(c[2], a[2], b[2], s[2], c[3]);
ripple_carry_adder f4(c[3], a[3], b[3], s[3], c[4]);
ripple_carry_adder f5(c[4], a[4], b[4], s[4], c[5]);
ripple_carry_adder f6(c[5], a[5], b[5], s[5], c[6]);
ripple_carry_adder f7(c[6], a[6], b[6], s[6], c[7]);
ripple_carry_adder f8(c[7], a[7], b[7], s[7], c[8]);
ripple_carry_adder f9(c[8], a[8], b[8], s[8], c[9]);
ripple_carry_adder f10(c[9], a[9], b[9], s[9], c[10]);
ripple_carry_adder f11(c[10], a[10], b[10], s[10], c[11]);
ripple_carry_adder f12(c[11], a[11], b[11], s[11], c[12]);
ripple_carry_adder f13(c[12], a[12], b[12], s[12], c[13]);
ripple_carry_adder f14(c[13], a[13], b[13], s[13], c[14]);
ripple_carry_adder f15(c[14], a[14], b[14], s[14], c[15]);
ripple_carry_adder f16(c[15], a[15], b[15], s[15], carry_out);
endmodule

module eight_bit_Mulitiplier(A,B,P);
input [7:0] A,B;
output [15:0] P;
wire [7:0] MUout0, MUout1, MUout2, MUout3, MUout4, MUout5, MUout6, MUout7;
wire [7:0] CLA_S0, CLA_S1, CLA_S2, CLA_S3, CLA_S4, CLA_S5, CLA_S6;
wire CLA_Cout0, CLA_Cout1, CLA_Cout2, CLA_Cout3, CLA_Cout4, CLA_Cout5, CLA_Cout6,cin;
assign cin = 1'b0;
MutiplierUnit M0(A,B[0],MUout0);
MutiplierUnit M1(A,B[1],MUout1);
MutiplierUnit M2(A,B[2],MUout2);
MutiplierUnit M3(A,B[3],MUout3);
MutiplierUnit M4(A,B[4],MUout4);
MutiplierUnit M5(A,B[5],MUout5);
MutiplierUnit M6(A,B[6],MUout6);
MutiplierUnit M7(A,B[7],MUout7);
eight_bit_adds a1(cin,{1'b0,MUout0[7:1]},MUout1,CLA_S0,CLA_Cout0);
eight_bit_adds a2(cin,{CLA_Cout0,CLA_S0[7:1]},MUout2,CLA_S1,CLA_Cout1);
eight_bit_adds a3(cin,{CLA_Cout1,CLA_S1[7:1]},MUout3,CLA_S2,CLA_Cout2);
eight_bit_adds a4(cin,{CLA_Cout2,CLA_S2[7:1]},MUout4,CLA_S3,CLA_Cout3);
eight_bit_adds a5(cin,{CLA_Cout3,CLA_S3[7:1]},MUout5,CLA_S4,CLA_Cout4);
eight_bit_adds a6(cin,{CLA_Cout4,CLA_S4[7:1]},MUout6,CLA_S5,CLA_Cout5);
eight_bit_adds a7(cin,{CLA_Cout5,CLA_S5[7:1]},MUout7,CLA_S6,CLA_Cout6);
assign P[0] = MUout0[0];
assign P[1] = CLA_S0[0];
assign P[2] = CLA_S1[0];
assign P[3] = CLA_S2[0];
assign P[4] = CLA_S3[0];
assign P[5] = CLA_S4[0];
assign P[6] = CLA_S5[0];
assign P[14:7] = CLA_S6;
assign P[15] = CLA_Cout6;
endmodule

module MutiplierUnit(A,Bi,MUout);
input [7:0] A;
input Bi;
output [7:0] MUout;
assign MUout[0] = A[0]&Bi;
assign MUout[1] = A[1]&Bi;
assign MUout[2] = A[2]&Bi;
assign MUout[3] = A[3]&Bi;
assign MUout[4] = A[4]&Bi;
assign MUout[5] = A[5]&Bi;
assign MUout[6] = A[6]&Bi;
assign MUout[7] = A[7]&Bi;
endmodule

module eight_bit_adds(cin,a,b,s,cout);
input cin;
input[7:0]a,b;
output cout;
output [7:0]s;
wire [7:0]c;
assign c[0] = cin;
ripple_carry_adder fa(c[0], a[0], b[0], s[0], c[1]);
ripple_carry_adder fb(c[1], a[1], b[1], s[1], c[2]);
ripple_carry_adder fc(c[2], a[2], b[2], s[2], c[3]);
ripple_carry_adder fd(c[3], a[3], b[3], s[3], c[4]);
ripple_carry_adder fe(c[4], a[4], b[4], s[4], c[5]);
ripple_carry_adder ff(c[5], a[5], b[5], s[5], c[6]);
ripple_carry_adder fg(c[6], a[6], b[6], s[6], c[7]);
ripple_carry_adder fh(c[7], a[7], b[7], s[7], cout);
endmodule

module ripple_carry_adder(cin,a,b,s,cout);
input cin,a,b;
output s,cout;
assign s = cin^a^b;
assign cout = (b&~(a^b))|(cin&(a^b));
endmodule

module Change_display(c_dis, enable, A, B, C, D, result, display);
input c_dis, enable;
input[7: 0] A, B, C, D;
input[15: 0] result;
output reg[15: 0] display;
always @(*) begin
if(!c_dis)
display <= result;
else if(enable)
display <= {C, D};
else
display <= {A, B};
end
endmodule

module eight_bit_registered(D,reset,clock,Q,enable);
input clock,reset,enable;
input [7:0]D;
output reg [7:0]Q;
always@(negedge clock or negedge reset)
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
