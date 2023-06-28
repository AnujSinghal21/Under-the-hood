`timescale 1ns/1ns 

module andMod(A, B, C);
    input A;
    input B;
    output C;
    assign C = A&B;
endmodule


module tb;

    reg A, B;
    wire C;
    andMod ans(A, B, C);

    initial begin
        A = 1;
        B = 1;
        #2;
        $display("A = %b, B = %b, C = %b", A, B, C);
        #15;
        A = 0;
        B = 1;
        #2;
        $display("A = %b, B = %b, C = %b", A, B, C);
        #20;
        A=1;
        B=0;
        #2;
        $display("A = %b, B = %b, C = %b", A, B, C);
        #15;
        A = 0;
        B = 0;
        #2;
        $display("A = %b, B = %b, C = %b", A, B, C);
    end
endmodule

//* & == and, | == or, ^ == xor, ~ == not, >> == right, << == left