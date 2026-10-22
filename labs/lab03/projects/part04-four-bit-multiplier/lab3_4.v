module lab3_4(SW,HEX0,HEX1,HEX4,HEX5);
input [7:0]SW;
output [6:0]HEX0,HEX1,HEX4,HEX5;
wire [7:0]P;
wire [3:0]A,B;
wire [3:0] MUout0, MUout1, MUout2, MUout3;
wire [3:0] CLA_S0, CLA_S1, CLA_S2;
wire CLA_Cout0, CLA_Cout1, CLA_Cout2,cin;
assign cin = 1'b0;
assign A = SW[7:4];
assign B = SW[3:0];
MutiplierUnit M0(A,B[0],MUout0);
MutiplierUnit M1(A,B[1],MUout1);
MutiplierUnit M2(A,B[2],MUout2);
MutiplierUnit M3(A,B[3],MUout3);
four_bit_adds(cin,{1'b0,MUout0[3:1]},MUout1,CLA_S0,CLA_Cout0);
four_bit_adds(cin,{CLA_Cout0,CLA_S0[3:1]},MUout2,CLA_S1,CLA_Cout1);
four_bit_adds(cin,{CLA_Cout1,CLA_S1[3:1]},MUout3,CLA_S2,CLA_Cout2);

assign P[0] = MUout0[0];
assign P[1] = CLA_S0[0];
assign P[2] = CLA_S1[0];
assign P[6:3] = CLA_S2;
assign P[7] = CLA_Cout2;

segmentDecoder s0(HEX0, P[3: 0]);
segmentDecoder s1(HEX1, P[7: 4]);
segmentDecoder b(HEX4, B);
segmentDecoder a(HEX5, A);

endmodule

module MutiplierUnit(A,Bi,MUout);
input [3:0] A;
input Bi;
output [3:0] MUout;
assign MUout[0] = A[0]&Bi;
assign MUout[1] = A[1]&Bi;
assign MUout[2] = A[2]&Bi;
assign MUout[3] = A[3]&Bi;
endmodule

module four_bit_adds(cin,a,b,s,cout);
input cin;
input[3:0]a,b;
output cout;
output [3:0]s;
wire [3:0]c;
assign c[0] = cin;
ripple_carry_adder fa(c[0], a[0], b[0], s[0], c[1]);
ripple_carry_adder fb(c[1], a[1], b[1], s[1], c[2]);
ripple_carry_adder fc(c[2], a[2], b[2], s[2], c[3]);
ripple_carry_adder fd(c[3], a[3], b[3], s[3], cout);
endmodule

module ripple_carry_adder(cin,a,b,s,cout);
input cin,a,b;
output s,cout;
assign s = cin^a^b;
assign cout = (b&~(a^b))|(cin&(a^b));
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
