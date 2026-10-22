module lab2_7(CLOCK_50, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
input CLOCK_50;
input[9: 0] SW;
output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
wire clock;
wire[3: 0] Q0, Q1, Q2, Q3, Q4, Q5;
wire[5: 0] f;

delay_1s(CLOCK_50,clock);
Counter s0(clock,1,f[0],Q0,9,0,0,0,0); 
Counter s1(clock,f[0],f[1],Q1,5,0,0,0,0); 
Counter m0(clock,f[0]&f[1],f[2],Q2,9,0,0,SW[8]&(~SW[9]),SW[3:0]); 
Counter m1(clock,f[0]&f[1]&f[2],f[3],Q3,5,0,0,SW[8]&(~SW[9]),SW[7:4]); 
Counter h0(clock,f[0]&f[1]&f[2]&f[3],f[4],Q4,9,f[5],3,SW[8]&SW[9],SW[3:0]); 
Counter h1(clock,f[0]&f[1]&f[2]&f[3]&f[4],f[5],Q5,2,0,0, SW[8]&SW[9],SW[7:4]);
Seven_segment_Decoder d0(Q0,HEX0);
Seven_segment_Decoder d1(Q1,HEX1);
Seven_segment_Decoder d2(Q2,HEX2);
Seven_segment_Decoder d3(Q3,HEX3);
Seven_segment_Decoder d4(Q4,HEX4);
Seven_segment_Decoder d5(Q5,HEX5);
endmodule

module Seven_segment_Decoder(v,display);
input[3: 0] v;
output reg[6: 0] display;
always @(v) begin
case(v)
4'b0000: display = 7'b1000000;
4'b0001: display = 7'b1111001;
4'b0010: display = 7'b0100100;
4'b0011: display = 7'b0110000;
4'b0100: display = 7'b0011001;
4'b0101: display = 7'b0010010;
4'b0110: display = 7'b0000010;
4'b0111: display = 7'b1011000;
4'b1000: display = 7'b0000000;
4'b1001: display = 7'b0010000;
default: display = 7'b1111111;
endcase
end
endmodule

module Counter(clock, enable, full, Q, n, lfull, v, preset, value);
input clock, enable, lfull, preset;
input[3: 0] n, v, value;
output reg[3: 0] Q;
output full;
wire ofull, nfull,reset;
reg preset_d;
compare_full cmp(Q, n, ofull);
compare_full cmp2(Q, v, nfull);
assign reset = 1'b1;
assign full = ofull | (nfull &lfull);
always @(posedge clock) begin
preset_d <= preset;
if(!reset)
Q <= 0;
else if( preset_d == 1'b0 && preset == 1'b1)
Q <= value;
else if(enable) begin
if(full)
Q <= 0;
else
Q <= Q+1;
end
end
endmodule

module compare_full(a, b, same);
input[3: 0] a, b;
output same;
assign same = (a == b)? 1'b1: 1'b0;
endmodule

module delay_1s(clock,delay);
input clock;
output reg delay;
reg [25:0] count;
always @(posedge clock)
begin
if(count==26'd49_999_999)
begin
count<=26'd0;
delay<=1;
end
else
begin
count<=count+1;
delay<=0;
end
end
endmodule
