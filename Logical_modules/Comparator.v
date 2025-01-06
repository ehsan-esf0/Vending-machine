module Comparator (
    input [3:0] count, 
    output reg discount 
);
    always @(*) begin
        if (count >= 4'd10) 
            discount = 1;
        else 
            discount = 0;
    end
endmodule
