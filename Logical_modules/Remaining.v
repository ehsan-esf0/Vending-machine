module Remaining (
    input [15:0] price,
    input [15:0] amount_paid,
    output reg [15:0] remaining
);

    always @(*) begin
        if (amount_paid >= price)
            remaining = amount_paid - price;
        else
            remaining = 16'b0; 
    end
endmodule
