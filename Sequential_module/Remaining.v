module Remaining (
    input [7:0] price,
    input [7:0] amount_paid,
    output [7:0] change
);

    assign change = (amount_paid >= price) ? (amount_paid - price) : 8'b00000000;

endmodule
