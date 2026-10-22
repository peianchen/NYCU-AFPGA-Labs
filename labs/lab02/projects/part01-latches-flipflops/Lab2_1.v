module Lab2_1(D,Clock,Qa,Qb,Qc);
input D,Clock;
output Qa,Qb,Qc;

D_latch(D,Clock,Qa);

pos_flipflop(D,Clock,Qb);
neg_flipflop(D,Clock,Qc);
endmodule

module D_latch(D,Clock,Q);
input D,Clock;
output reg Q;
always@(D,Clock)
	if(Clock)
		Q <= D;
endmodule

module pos_flipflop(D,Clock,Q);
input D,Clock;
output reg Q;
always@(posedge Clock)
	Q <= D;
endmodule

module neg_flipflop(D,Clock,Q);
input D,Clock;
output reg Q;
always@(negedge Clock)
Q <= D;
endmodule
