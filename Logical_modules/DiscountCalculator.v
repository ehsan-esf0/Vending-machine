module DiscountCalculator (
    input [15:0] total_amount, 
    input discount,
    output reg [15:0] discounted_amount 
);

    always @(*) begin
        if (discount)
            discounted_amount = (total_amount * 90) / 100;
        else
            discounted_amount = total_amount;
    end
endmodule
