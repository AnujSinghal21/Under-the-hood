`include "task1B.v"
module tb;
    reg [7:0] A, B,C;
    reg [1:0] op;
    wire [7:0] R;
    wire C_out;
    calculate calc0(A, B, C, op, R, C_out);
    initial begin
        $monitor("A=%d, B=%d, C=%d, op=%b, Result= %d", A, B, C,op, R);
        repeat(10) begin
            A = $random;
            B = $random;
            C = $random;
            op = $random; 
            #25;
        end
    end
endmodule