`include "task1.v"
module tb;
    reg A,B;
    wire C;
    or_gate orgate0 (A,B,C);
    initial begin
        A=0;
        B=0;
        #2;
        $monitor("A = %b, B = %b, A or B = %b",A,B,C);
        repeat(20) begin
            A = $random;
            B = $random;
            #15;
        end
    end

endmodule