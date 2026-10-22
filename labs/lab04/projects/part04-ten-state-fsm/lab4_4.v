module lab4_4(SW, KEY, HEX0);
input[2: 0] SW;
input[0: 0] KEY;
output[6: 0] HEX0;
wire reset, clock;
wire[1: 0] w;
wire[3: 0] state, next;
assign reset = SW[0];
assign clock = KEY[0];
assign w = {SW[2], SW[1]};
change_state c_state(clock, reset, state, next);
stateTable s_table(state, w, next);
segment_Decoder H0(HEX0, state);
endmodule

module change_state(clock, reset, state, next);
input clock, reset;
input[3: 0] next;
output reg[3: 0] state;
always @(posedge clock) begin
if(!reset)
state <= 0;
else 
state <= next;
end
endmodule

module stateTable(state, w, next);
input[3: 0] state;
input[1: 0] w;
output reg[3: 0] next;
parameter A=4'b0000, B=4'b0001, C=4'b0010, D=4'b0011, 
E=4'b0100, F=4'b0101, G=4'b0110, H=4'b0111, I=4'b1000, 
J=4'b1001;
always @(state, w) begin
case(state)
A: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=B;
else if(w==2'b10) 
next=C;
else next=J;
B: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=C;
else if(w==2'b10) 
next=D;
else next=A;
C: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=D;
else if(w==2'b10) 
next=E;
else next=B;
D: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=E;
else if(w==2'b10) 
next=F;
else next=C;
E: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=F;
else if(w==2'b10) 
next=G;
else next=D;
F: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=G;
else if(w==2'b10) 
next=H;
else next=E;
G: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=H;
else if(w==2'b10) 
next=I;
else next=F;
H: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=I;
else if(w==2'b10) 
next=J;
else next=G;
I: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=J;
else if(w==2'b10) 
next=A;
else next=H;
J: 
if(w==2'b00) 
next=state;
else if(w==2'b01) 
next=A;
else if(w==2'b10) 
next=B;
else next=I;
default: next=4'bxxxx;
endcase
end
endmodule

module segment_Decoder(Display, v);
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
