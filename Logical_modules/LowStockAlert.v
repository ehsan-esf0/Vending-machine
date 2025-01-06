module LowStockAlert (
    input [3:0] inventory_count,
    output reg alert
);

    always @(*) begin
        if (inventory_count < 5)
            alert = 1;
        else
            alert = 0;
    end
endmodule