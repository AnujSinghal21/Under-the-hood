module Sum(
    input a,b,c,d,
    output r
    );
    assign r = ( a | (~b) | d) & ( b | (~d) );
endmodule
module one_bit_adder(
    input b1,b2,b3,c_in,
    output r,c_out
    );
    Sum Sum0(b1,b2,b3,c_in,r);
    Sum Sum1(c_in,b1,b2,b3,c_out);
endmodule
module calculate(
    input wire [7:0] a,b,c,
    input wire [1:0] op,
    output wire [7:0] r, output wire c_out
    );
    wire [7:0] car,A,B,C;
    wire d;
    assign A = a^(op[0] & ~op[1]);
    assign B = b^(~op[0] & op[1]);
    assign C = c^(op[0] & op[1]);
    assign d = op[0] | op[1]; 
    one_bit_adder add0(A[0],B[0],C[0],d,r[0],car[0]);
    one_bit_adder add1(A[1],B[1],C[1],car[0],r[1],car[1]);
    one_bit_adder add2(A[2],B[2],C[2],car[1],r[2],car[2]);
    one_bit_adder add3(A[3],B[3],C[3],car[2],r[3],car[3]);
    one_bit_adder add4(A[4],B[4],C[4],car[3],r[4],car[4]);
    one_bit_adder add5(A[5],B[5],C[5],car[4],r[5],car[5]);
    one_bit_adder add6(A[6],B[6],C[6],car[5],r[6],car[6]);
    one_bit_adder add7(A[7],B[7],C[7],car[6],r[7],car[7]);
    assign c_out = c[7];    
endmodule