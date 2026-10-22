module lab4_3(SW, KEY, LEDR);
input[1: 0] SW;
input[0: 0] KEY;
output[9: 0] LEDR;
wire reset, w, clk, z;
wire[7: 0] state;
wire[3: 0] zero, one;
assign reset = SW[0];
assign w = SW[1];
assign clk = KEY[0];
assign LEDR[9] = z;
assign LEDR[7: 0] = state;
rShift w0(clk, reset&(~w), zero, 0);
rShift w1(clk, reset& (w), one, 1);
assign z = zero[0]|(~one[0]);
assign state = {one, zero};
endmodule

module rShift(clk, reset, q, d);
input clk, reset, d;
output reg[3: 0] q;
always @(posedge clk) begin
if(!reset)
q <= {4{d}};
else begin
q[0] <= q[1];
q[1] <= q[2];
q[2] <= q[3];
q[3] <= ~d;
end
end
endmodule
