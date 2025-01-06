module InventoryCounter (
    input clk,
    input reset,
    input decrement,
    output reg [3:0] inventory_count
);

    always @ (posedge clk or posedge reset) begin
        if (reset)
            inventory_count <= 4'b1111; 
        else if (decrement && inventory_count > 0)
            inventory_count <= inventory_count - 1;
    end
endmodule
