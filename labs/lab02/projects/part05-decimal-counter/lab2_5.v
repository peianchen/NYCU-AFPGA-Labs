module lab2_5(CLOCK_50, HEX0);
input CLOCK_50;
output [6: 0]HEX0;
wire clk;
wire [3: 0] Q;
delay_1s(CLOCK_50, clk);
tenCounter c(clk, Q);
hex_decoder d1(Q, HEX0);
endmodule

module tenCounter(clk,Q);
input clk;
output reg [3: 0]Q;
initial begin 
Q = 0;
end
always @(posedge clk)
begin
if(Q == 9)
Q <= 0;
else
Q <= Q+1;
end
endmodule
module hex_decoder(Q, Display);
input [3: 0] Q;
output [6: 0] Display;
assign Display[0] = ((~Q[3])&(~Q[2])&(~Q[1])&Q[0])|(Q[2]&(~Q[1])&(~Q[0]));
assign Display[1] = (Q[2]&(~Q[1])&Q[0])|(Q[2]&Q[1]&(~Q[0]));
assign Display[2] = (~Q[2])&Q[1]&(~Q[0]);
assign Display[3] = 
((~Q[3])&(~Q[2])&(~Q[1])&Q[0])|(Q[2]&(~Q[1])&(~Q[0]))|(Q[2]&Q[1]&Q[0]);
assign Display[4] = (Q[2]&(~Q[1]))|Q[0];
assign Display[5] = ((~Q[3])&(~Q[2])&Q[0])|((~Q[2])&Q[1])|(Q[1]&Q[0]);
assign Display[6] = ((~Q[3])&(~Q[2])&(~Q[1]))|(Q[2]&Q[1]&Q[0]);
endmodule

module delay_1s(clk,clkout);
input clk;
output reg clkout;
reg [25:0] count;
always @(posedge clk)
begin
if(count==26'd49_999_999)
begin
count<=26'd0;
clkout<=1;
end
else
begin
count<=count+1;
clkout<=0;
end
end
endmodule
