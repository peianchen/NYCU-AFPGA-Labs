module lab2_4(KEY,SW,HEX0,HEX1,HEX2,HEX3);
input [0:0]KEY;
input [1:0]SW;
output [6:0]HEX0, HEX1, HEX2, HEX3;
wire Reset, Clock;
wire [15:0]Q;
assign Enable = SW[1];
assign Reset = SW[0];
assign Clock = KEY[0];
counter bit16(.clock(Clock), .cnt_en(Enable), .aclr(~Reset), .q(Q));
seven_segment_decoder s1(Q[3:0],HEX0);
seven_segment_decoder s2(Q[7:4],HEX1);
seven_segment_decoder s3(Q[11:8],HEX2);
seven_segment_decoder s4(Q[15:12],HEX3);
endmodule

module seven_segment_decoder(m,display);

input [3:0]m;
output [6:0] display;
assign display[0] = (~m[3]&~m[2]&~m[1]&m[0])|
						  (~m[3]&m[2]&~m[1]&~m[0])|
						  (m[3]&m[2]&~m[1]&m[0])|
						  (m[3]&~m[2]&m[1]&m[0]);
assign display[1] = (~m[3]&m[2]&~m[1]&m[0])|
						  (m[2]&m[1]&~m[0])|
						  (m[3]&m[1]&m[0])|
						  (m[3]&m[2]&~m[0]);
assign display[2] = (~m[3]&~m[2]&m[1]&~m[0])|
						  (m[3]&m[2]&m[1])|
						  (m[3]&m[2]&~m[0]);
assign display[3] = (~m[3]&~m[2]&~m[1]&m[0])|
						  (~m[3]&m[2]&~m[1]&~m[0])|
						  (m[3]&~m[2]&m[1]&~m[0])|
						  (m[2]&m[1]&m[0]);
assign display[4] = (~m[3]&m[0])|
						  (~m[2]&~m[1]&m[0])|
						  (~m[3]&m[2]&~m[1]);
assign display[5] = (m[3]&m[2]&~m[1]&m[0])|
						  (~m[3]&~m[2]&m[0])|
						  (~m[3]&~m[2]&m[1])|
						  (~m[3]&m[1]&m[0]);
assign display[6] = (~m[3]&m[2]&m[1]&m[0])|
						  (m[3]&m[2]&~m[1]&~m[0])|
						  (~m[3]&~m[2]&~m[1]);
endmodule