module SalesRegister (
    input [3:0] sales_count,
    input clk,
    input reset,
    output reg [3:0] sales_total
);

    always @ (posedge clk or posedge reset) begin
        if (reset)
            sales_total <= 4'd0;
        else
            sales_total <= sales_total + sales_count;
    end
endmodule
