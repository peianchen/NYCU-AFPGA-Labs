module lab2_2(KEY, SW, HEX0, HEX1, HEX2, HEX3);
input [0:0]KEY;
input [1:0]SW;
output [6:0]HEX0, HEX1, HEX2, HEX3;
wire Reset, Clock;
wire [16:0]Q;
wire [16:0]T;
assign Q[0] = 1'b1;
assign T[0] = Enable;
assign Enable = SW[1];
assign Reset = SW[0];
assign Clock = KEY[0];
genvar n;
generate 
for (n=1; n<=16; n=n+1)
begin: genloop
assign T[n] = T[n-1]&Q[n-1];
T_flipflop TFF(T[n],Clock,Reset,Q[n]);
end
endgenerate

seven_segment_decoder s1(Q[4:1],HEX0);
seven_segment_decoder s2(Q[8:5],HEX1);
seven_segment_decoder s3(Q[12:9],HEX2);
seven_segment_decoder s4(Q[16:13],HEX3);

endmodule

module T_flipflop(T,Clock,Reset,Q);
input T;
input Clock,Reset;
output Q;
reg Q;
always@(posedge Clock or negedge Reset)
begin
if(!Reset)
begin
	Q <= 1'b0;
end
else if(T)
begin
	Q <= ~Q;
end
	else
	begin
		Q <= Q;
	end
end
			
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
