module LAB1_6(SW,LEDR);
input [9:0]SW;
output [9:0]LEDR;
wire c0,c1,c2,c3;
assign c0 = SW[9];
full_adder(c0, SW[0], SW[4], LEDR[0], c1);
full_adder(c1, SW[1], SW[5], LEDR[1], c2);
full_adder(c2, SW[2], SW[6], LEDR[2], c3);
full_adder(c3, SW[3], SW[7], LEDR[3], LEDR[4]);
endmodule

module full_adder(cin,a,b,s,cout);
input cin,a,b;
output s,cout;
assign s = cin^a^b;
assign cout = (b&~(a^b))|(cin&(a^b));
endmodule
