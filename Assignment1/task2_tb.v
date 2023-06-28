`include "task2.v"
`timescale 1ns/1ns
module tb;
    reg A,B,clk=0;
    wire C;
    flip_flop flipflop0 (A,B,clk,C);
    always begin
        clk = ~clk;
        #10;
    end

    initial begin
        A=1'b0;
        B=1'b0;
        #2;
        $monitor("A = %b, B = %b, C = %b",A,B,C);
        repeat(20) begin
            A = $random;
            B = $random;
            #15;
        end
    end

endmodule
