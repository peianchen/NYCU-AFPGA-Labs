module LAB1_1(SW,LEDR);
input [9:0] SW;
output [9:0] LEDR;

multiplexer m(SW[0],SW[1],SW[2],SW[3],SW[4],SW[5],SW[6],SW[7],SW[9],LEDR);

endmodule

module multiplexer(m0,m1,m2,m3,m4,m5,m6,m7,m9,LED);
input m0,m1,m2,m3,m4,m5,m6,m7,m9;
output [3:0]LED;

assign LED[0] = (m0&~m9)|(m9&m4);
assign LED[1] = (m1&~m9)|(m9&m5);
assign LED[2] = (m2&~m9)|(m9&m6);
assign LED[3] = (m3&~m9)|(m9&m7);

endmodule
