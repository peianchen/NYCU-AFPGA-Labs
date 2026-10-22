module LAB1_5(SW,HEX0,HEX1);
input [3:0]SW;
output [6:0]HEX0;
output [6:0]HEX1;
wire z0,ca0,ca1,ca2,m0,m1,m2,m3;
compartor(SW[0],SW[1],SW[2],SW[3],z0);
circuit_A(SW[0],SW[1],SW[2],ca0,ca1,ca2);
circuit_B(z0,HEX1);
//2-to-1 multiplexer
assign m0 = ((~z0)&SW[0])|(z0&ca0);
assign m1 = ((~z0)&SW[1])|(z0&ca1);
assign m2 = ((~z0)&SW[2])|(z0&ca2);
assign m3 = ((~z0)&SW[3])|(z0&0);
seven_segment_decoder(m0,m1,m2,m3,HEX0);
endmodule

module compartor(v0,v1,v2,v3,z0);
input v0,v1,v2,v3;
output z0;
assign z0 = (v3&v2)|(v3&v1);
endmodule

module circuit_A(v0,v1,v2,ca0,ca1,ca2);
input v0,v1,v2;
output ca0,ca1,ca2;
assign {ca2,ca1,ca0} = {v2, v1, v0}+6;
endmodule

module circuit_B(z0, display);
input z0;
output [6:0]display;
assign display[6] = 1;
assign display[5] = 1;
assign display[4] = 1;
assign display[3] = 1;
assign display[2] = ~z0;
assign display[1] = ~z0;
assign display[0] = 1;
endmodule

module seven_segment_decoder(m0,m1,m2,m3,display);
input m0,m1,m2,m3;
output [6:0] display;
assign display[6] = (~m3&~m2&~m1)|(m2&m1&m0)|(m3&m2)|(m3&m1);
assign display[5] = (~m3&~m2&m0)|(~m2&m1)|(m1&m0)|(m3&m2)|(m3&m1);
assign display[4] = (m2&~m1)|m0|(m3&m1);
assign display[3] = (m2&~m1&~m0)|(~m2&~m1&m0)|(m2&m1&m0)|(m3&m0)|(m3&m1);
assign display[2] = (~m2&m1&~m0)|(m3&m2)|(m3&m1);
assign display[1] = (m2&~m1&m0)|(m2&m1&~m0)|(m3&m2)|(m3&m1);
assign display[0] = (~m3&~m2&~m1&m0)|(m2&~m1&~m0)|(m3&m2)|(m3&m1);
endmodule

