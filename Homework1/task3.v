module one_bit_adder(
    input a,b,c_in, output r,c_out
);
assign r = (a ^ b ^ c_in);
assign c_out = (a&b) | (b&c_in) | (a&c_in);

endmodule

module four_bit_adder(
    input wire [3:0] a,b,
    output wire [3:0] r, output wire c_out
);
    wire [3:0] c;
    one_bit_adder adder0 (a[0],b[0],1'b0,r[0],c[0]);
    one_bit_adder adder1 (a[1],b[1],c[0],r[1],c[1]);
    one_bit_adder adder2 (a[2],b[2],c[1],r[2],c[2]);
    one_bit_adder adder3 (a[3],b[3],c[2],r[3],c[3]);
    assign c_out = c[3];
endmodule

module two_complement(input wire [3:0] a, output wire [3:0] b, output wire Carry);
    wire [3:0] com = ~a;
    four_bit_adder add (com, 4'b0001, b , Carry);
endmodule

module four_bit_subtracter(input wire[3:0] a,b, output wire[3:0] r, output wire c_out);
    wire [3:0] b2;
    wire car;
    two_complement twocomp0 (b,b2,car);
    four_bit_adder add0(a,b2,r,c_out);
endmodule

module eight_bit_subtracter(input wire[7:0] a, input wire [7:0] b, output wire [7:0] r, output wire c_out);
    wire [3:0] a1, b1, r1;
    wire c1;
    assign a1[0] = a[0];
    assign a1[1] = a[1];
    assign a1[2] = a[2];
    assign a1[3] = a[3];
    assign b1[0] = b[0];
    assign b1[1] = b[1];
    assign b1[2] = b[2];
    assign b1[3] = b[3];
    four_bit_subtracter sub0 (a1,b1,r1,c1);
    wire [3:0] a2, b2, r2;
    wire c2;
    assign a2[0] = a[4];
    assign a2[1] = a[5];
    assign a2[2] = a[6];
    assign a2[3] = a[7];
    assign b2[0] = b[4];
    assign b2[1] = b[5];
    assign b2[2] = b[6];
    assign b2[3] = b[7];
    four_bit_subtracter sub1 (a2,b2,r2,c2);
    assign r[0] = r1[0];
    assign r[1] = r1[1];
    assign r[2] = r1[2];
    assign r[3] = r1[3];
    assign r[4] = r2[0];
    assign r[5] = r2[1];
    assign r[6] = r2[2];
    assign r[7] = r2[3];
    assign c_out = c2;


endmodule