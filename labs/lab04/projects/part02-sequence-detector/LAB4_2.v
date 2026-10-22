module LAB4_2(SW, KEY, LEDR);
input[1: 0] SW;
input[0: 0] KEY;
output[9:0] LEDR;
wire reset, w, clk, z;
reg[3: 0] state, next;
parameter A=4'b0000, B=4'b0001, C=4'b0010, D=4'b0011,
 E=4'b0100, F=4'b0101, G=4'b0110, H=4'b0111,
 I=4'b1000;
 
assign reset = SW[0];
assign w = SW[1];
assign clk = KEY[0];
assign LEDR[9] = z;
assign LEDR[3: 0] = state;
always @(w, state)
begin: state_table
case(state)
A: 
	if(!w) 
		next = B;
	else 
		next = F;
B: 
	if(!w) 
		next = C;
	else 
		next = F;
C: 
	if(!w) 
		next = D;
	else 
		next = F;
D: 
	if(!w) 
		next = E;
	else 
		next = F;
E: 
	if(!w) 
		next = E;
	else 
		next = F;
F: 
	if(!w) 
		next = B;
	else 
		next = G;
G: 
	if(!w) 
		next = B;
	else 
		next = H;
H: 
	if(!w) 
		next = B;
	else 
		next = I;
I: 
	if(!w) 
		next = B;
	else 
		next = I;
endcase
end
always @(posedge clk) 
begin: state_FFs
if(!reset)
	state <= 0;
else
	state <= next;
end
assign z = (state==E)|(state==I);
endmodule
