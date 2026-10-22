module lab_1(SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
//module lab_1(SW,LEDR);
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;
//Full adder
assign S0 = SW[0]^SW[4]^SW[8];
assign C1 = (SW[4]&~(SW[0]^SW[4]))|(SW[8]&(SW[0]^SW[4]));
assign S1 = SW[1]^SW[5]^C1;
assign C2 = (SW[5]&~(SW[1]^SW[5]))|(C1&(SW[1]^SW[5]));
assign S2 = SW[2]^SW[6]^C2;
assign C3 = (SW[6]&~(SW[2]^SW[6]))|(C2&(SW[2]^SW[6]));
assign S3 = SW[3]^SW[7]^C3;
assign Cout = (SW[7]&~(SW[3]^SW[7]))|(C3&(SW[3]^SW[7]));
//Comparator
assign Z0 = (SW[3]&SW[2])|(SW[3]&SW[1]);
assign Z1 = (SW[7]&SW[6])|(SW[7]&SW[5]);
assign Z2 = (S3&S2)|(S3&S1)|Cout;
//assign Z3 = {Cout&~S3&S2&~S1&~S0};
//circuit B
assign HEX1[6] = 1;
assign HEX1[5] = 1;
assign HEX1[4] = 1;
assign HEX1[3] = 1;
assign HEX1[2] = ~Z0;
assign HEX1[1] = ~Z0;
assign HEX1[0] = 1;

assign HEX3[6] = 1;
assign HEX3[5] = 1;
assign HEX3[4] = 1;
assign HEX3[3] = 1;
assign HEX3[2] = ~Z1;
assign HEX3[1] = ~Z1;
assign HEX3[0] = 1;

assign HEX5[6] = 1;
assign HEX5[5] = Z2;
assign HEX5[4] = Z2;
assign HEX5[3] = Z2;
assign HEX5[2] = 0;
assign HEX5[1] = 0;
assign HEX5[0] = Z2;
//circuit A
assign CA0 = SW[0];
assign CA1 = ~SW[1];
assign CA2 = SW[2]&SW[1];

assign CA3 = SW[4];
assign CA4 = ~SW[5];
assign CA5 = SW[6]&SW[5];

assign CA6 = S0;
assign CA7 = ~S1;
assign CA8 = (~S2&~S1)|((S2&S1));
assign CA9 = S1;
/*assign LEDR[0] = CA6;
assign LEDR[1] = CA7;
assign LEDR[2] = CA8;
assign LEDR[3] = CA9;*/


/*assign CA6 = S0;
assign CA7 = (~S3&~S2&~S1)|(S2&~S1);
assign CA8 = (~S3&~S2&S1)|(S2&S1);
assign CA9 = (~S3&S1);*/

//2-to-1 multiplexer
assign m0 = (SW[0]&~Z0)|(Z0&CA0);
assign m1 = (SW[1]&~Z0)|(Z0&CA1);
assign m2 = (SW[2]&~Z0)|(Z0&CA2);
assign m3 = (SW[3]&~Z0)|(Z0&0);

assign m4 = (SW[4]&~Z1)|(Z1&CA3);
assign m5 = (SW[5]&~Z1)|(Z1&CA4);
assign m6 = (SW[6]&~Z1)|(Z1&CA5);
assign m7 = (SW[7]&~Z1)|(Z1&0);

assign m8 = (S0&~Z2)|(Z2&CA6)|(Cout&CA6);
assign m9 = (S1&~Z2)|(Z2&CA7)|(Cout&CA7);
assign m10 = (S2&~Z2)|(Z2&CA8)|(Cout&CA8);
assign m11 = (S3&~Z2)|(Z2&0)|(Cout&CA9);

//7-segment decoder
assign HEX0[6] = (~m3&~m2&~m1)|(m2&m1&m0)|(m3&m2)|(m3&m1);
assign HEX0[5] = (~m3&~m2&m0)|(~m2&m1)|(m1&m0)|(m3&m2)|(m3&m1);
assign HEX0[4] = (m2&~m1)|m0|(m3&m1);
assign HEX0[3] = (m2&~m1&~m0)|(~m2&~m1&m0)|(m2&m1&m0)|(m3&m0)|(m3&m1);
assign HEX0[2] = (~m2&m1&~m0)|(m3&m2)|(m3&m1);
assign HEX0[1] = (m2&~m1&m0)|(m2&m1&~m0)|(m3&m2)|(m3&m1);
assign HEX0[0] = (~m3&~m2&~m1&m0)|(m2&~m1&~m0)|(m3&m2)|(m3&m1);

assign HEX2[6] = (~m7&~m6&~m5)|(m6&m5&m4)|(m7&m6)|(m7&m5);
assign HEX2[5] = (~m7&~m6&m4)|(~m6&m5)|(m5&m4)|(m7&m6)|(m7&m5);
assign HEX2[4] = (m6&~m5)|m4|(m7&m5);
assign HEX2[3] = (m6&~m5&~m4)|(~m6&~m5&m4)|(m6&m5&m4)|(m7&m4)|(m7&m5);
assign HEX2[2] = (~m6&m5&~m4)|(m7&m6)|(m7&m5);
assign HEX2[1] = (m6&~m5&m4)|(m6&m5&~m4)|(m7&m6)|(m7&m5);
assign HEX2[0] = (~m7&~m6&~m5&m4)|(m6&~m5&~m4)|(m7&m6)|(m7&m5);

assign HEX4[6] = (~m11&~m10&~m9)|(m10&m9&m8)|(m11&m10)|(m11&m9);
assign HEX4[5] = (~m11&~m10&m8)|(~m10&m9)|(m9&m8)|(m11&m10)|(m11&m9);
assign HEX4[4] = (m10&~m9)|m8|(m11&m9);
assign HEX4[3] = (m10&~m9&~m8)|(~m10&~m9&m8)|(m10&m9&m8)|(m11&m8)|(m11&m9);
assign HEX4[2] = (~m10&m9&~m8)|(m11&m10)|(m11&m9);
assign HEX4[1] = (m10&~m9&m8)|(m10&m9&~m8)|(m11&m10)|(m11&m9);
assign HEX4[0] = (~m11&~m10&~m9&m8)|(m10&~m9&~m8)|(m11&m10)|(m11&m9);

//Error
assign LEDR[9] = (SW[3]&SW[2])|(SW[3]&SW[1])|(SW[7]&SW[6])|(SW[7]&SW[5]);

endmodule

//part 3
/*
assign LEDR[0] = (SW[0]&~SW[9])|(SW[9]&SW[4]);
assign LEDR[1] = (SW[1]&~SW[9])|(SW[9]&SW[5]);
assign LEDR[2] = (SW[2]&~SW[9])|(SW[9]&SW[6]);
assign LEDR[3] = (SW[3]&~SW[9])|(SW[9]&SW[7]);
*/

//part 4
/*
assign HEX0[6] = (~SW[3]&~SW[2]&~SW[1])|(SW[2]&SW[1]&SW[0])|(SW[3]&SW[2])|(SW[3]&SW[1]);
assign HEX0[5] = (~SW[3]&~SW[2]&SW[0])|(~SW[2]&SW[1])|(SW[1]&SW[0])|(SW[3]&SW[2])|(SW[3]&SW[1]);
assign HEX0[4] = (SW[2]&~SW[1])|SW[0]|(SW[3]&SW[1]);
assign HEX0[3] = (SW[2]&~SW[1]&~SW[0])|(~SW[2]&~SW[1]&SW[0])|(SW[2]&SW[1]&SW[0])|(SW[3]&SW[0])|(SW[3]&SW[1]);
assign HEX0[2] = (~SW[2]&SW[1]&~SW[0])|(SW[3]&SW[2])|(SW[3]&SW[1]);
assign HEX0[1] = (SW[2]&~SW[1]&SW[0])|(SW[2]&SW[1]&~SW[0])|(SW[3]&SW[2])|(SW[3]&SW[1]);
assign HEX0[0] = (~SW[3]&~SW[2]&~SW[1]&SW[0])|(SW[2]&~SW[1]&~SW[0])|(SW[3]&SW[2])|(SW[3]&SW[1]);
*/

//part 5
/*
//Comparator
assign Z0 = (SW[3]&SW[2])|(SW[3]&SW[1]);
//circuit B
assign HEX1[6] = 1;
assign HEX1[5] = 1;
assign HEX1[4] = 1;
assign HEX1[3] = 1;
assign HEX1[2] = ~Z0;
assign HEX1[1] = ~Z0;
assign HEX1[0] = 1;
//circuit A
assign CA0 = SW[0];
assign CA1 = ~SW[1];
assign CA2 = SW[2]&SW[1];
//2-to-1 multiplexer
assign m0 = (SW[0]&~Z0)|(Z0&CA0);
assign m1 = (SW[1]&~Z0)|(Z0&CA1);
assign m2 = (SW[2]&~Z0)|(Z0&CA2);
assign m3 = (SW[3]&~Z0)|(Z0&0);
//7-segment decoder
assign HEX0[6] = (~m3&~m2&~m1)|(m2&m1&m0)|(m3&m2)|(m3&m1);
assign HEX0[5] = (~m3&~m2&m0)|(~m2&m1)|(m1&m0)|(m3&m2)|(m3&m1);
assign HEX0[4] = (m2&~m1)|m0|(m3&m1);
assign HEX0[3] = (m2&~m1&~m0)|(~m2&~m1&m0)|(m2&m1&m0)|(m3&m0)|(m3&m1);
assign HEX0[2] = (~m2&m1&~m0)|(m3&m2)|(m3&m1);
assign HEX0[1] = (m2&~m1&m0)|(m2&m1&~m0)|(m3&m2)|(m3&m1);
assign HEX0[0] = (~m3&~m2&~m1&m0)|(m2&~m1&~m0)|(m3&m2)|(m3&m1);
*/

//part 6 Full adder
/*
assign LEDR[0] = SW[0]^SW[4]^SW[9];
assign C1 = (SW[4]&~(SW[0]^SW[4]))|(SW[9]&(SW[0]^SW[4]));
assign LEDR[1] = SW[1]^SW[5]^C1;
assign C2 = (SW[5]&~(SW[1]^SW[5]))|(C1&(SW[1]^SW[5]));
assign LEDR[2] = SW[2]^SW[6]^C2;
assign C3 = (SW[6]&~(SW[2]^SW[6]))|(C2&(SW[2]^SW[6]));
assign LEDR[3] = 1
assign Cout = (SW[7]&~(SW[3]^SW[7]))|(C3&(SW[3]^SW[7]));
assign LEDR[4] = Cout;
*/



