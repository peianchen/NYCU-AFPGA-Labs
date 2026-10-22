module lab4_1(SW,KEY,LEDR);
input [1:0] SW;
input [0:0] KEY;
output [9:0] LEDR;
wire [8:0] Q;
wire W,z,reset,CLK;
assign W = SW[1];
assign reset = SW[0];
assign LEDR[9] = z;
assign CLK = KEY[0];
assign LEDR[8:0] = Q;

register A(1'b0,1,CLK,Q[0],reset);
register B(~W&(Q[0]|Q[5]|Q[6]|Q[7]|Q[8]),reset,CLK,Q[1],1);
register C(~W&Q[1],reset,CLK,Q[2],1);
register D(~W&Q[2],reset,CLK,Q[3],1);
register E(~W&(Q[3]|Q[4]),reset,CLK,Q[4],1);
register F(W&(Q[0]|Q[1]|Q[2]|Q[3]|Q[4]),reset,CLK,Q[5],1);
register G(W&Q[5],reset,CLK,Q[6],1);
register H(W&Q[6],reset,CLK,Q[7],1);
register I(W&(Q[7]|Q[8]),reset,CLK,Q[8],1);
assign z = Q[4]|Q[8];
endmodule

module register(D,reset,clock,Q,enable);
input clock,reset,enable,D;
output reg Q;
always@(negedge clock)
begin
if(!reset)
Q <= 1'b0;
else if(!enable)
Q <= 1'b1;
else
Q <= D;;
end
endmodule

