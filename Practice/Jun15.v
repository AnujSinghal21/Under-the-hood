//flip flop -> reg
module simple(
    input a,b, output reg c
);
//    wire temp ;
//    assign c = a ^ b;
    // initial begin
    //      c = temp;
    // end

    initial begin
        c = 1'b0;
    end
    always @(a or b) begin
        if (c == 1'b0) begin
            c = a ^ b;
        end else begin
            c = a & b;
        end
    end
endmodule

module tb;

    reg a,b;
    wire c;
    simple simp(a,b,c);
    initial begin
        a = 1;
        b = 1;
        $monitor("a = %b, b = %b, c = %b",a,b,c);
        #5;
        a = 0;
        b = 1;
        $monitor("a = %b, b = %b, c = %b",a,b,c);
        #5;
        a = 1;
        b = 0;
        $monitor("a = %b, b = %b, c = %b",a,b,c);
        #5;
        a = 0;
        b = 0;
        $monitor("a = %b, b = %b, c = %b",a,b,c);
        #5;
    end


endmodule