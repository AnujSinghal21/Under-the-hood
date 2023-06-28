module one_bit_adder(
    input a,b,c_in, output r,c_out
);
assign r = (a ^ b ^ c_in);
assign c_out = (a&b) | (b&c_in) | (a&c_in);

endmodule

module eight_bit_adder(
    input wire [7:0] a,b,
    output wire [7:0] r, output wire c_out
);
    wire [7:0] c;
    one_bit_adder adder0 (a[0],b[0],1'b0,r[0],c[0]);
    one_bit_adder adder1 (a[1],b[1],c[0],r[1],c[1]);
    one_bit_adder adder2 (a[2],b[2],c[1],r[2],c[2]);
    one_bit_adder adder3 (a[3],b[3],c[2],r[3],c[3]);
    one_bit_adder adder4 (a[4],b[4],c[3],r[4],c[4]);
    one_bit_adder adder5 (a[5],b[5],c[4],r[5],c[5]);
    one_bit_adder adder6 (a[6],b[6],c[5],r[6],c[6]);
    one_bit_adder adder7 (a[7],b[7],c[6],r[7],c[7]);
    assign c_out = c[7];
endmodule