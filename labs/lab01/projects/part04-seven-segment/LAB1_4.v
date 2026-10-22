module LAB1_4(SW,HEX0);
input [3:0] SW;
output [6:0] HEX0;

seven_segment_decoder d(SW[0], SW[1], SW[2], SW[3], HEX0);

endmodule

module seven_segment_decoder(d0,d1,d2,d3,display);
input d0,d1,d2,d3;
output [6:0] display;

assign display[6] = (~d3&~d2&~d1)|(d2&d1&d0)|(d3&d2)|(d3&d1);
assign display[5] = (~d3&~d2&d0)|(~d2&d1)|(d1&d0)|(d3&d2)|(d3&d1);
assign display[4] = (d2&~d1)|d0|(d3&d1);
assign display[3] = (d2&~d1&~d0)|(~d2&~d1&d0)|(d2&d1&d0)|(d3&d0)|(d3&d1);
assign display[2] = (~d2&d1&~d0)|(d3&d2)|(d3&d1);
assign display[1] = (d2&~d1&d0)|(d2&d1&~d0)|(d3&d2)|(d3&d1);
assign display[0] = (~d3&~d2&~d1&d0)|(d2&~d1&~d0)|(d3&d2)|(d3&d1);

endmodule