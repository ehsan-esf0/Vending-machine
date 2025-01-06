`include "./Logical_modules/DFF.v"
`include "./Logical_modules/FMS.v"
`include "./Logical_modules/Remaining.v"
`include "./Logical_modules/Register.v"
`include "./Logical_modules/decoder_3to8.v"
`include "./Logical_modules/Comparator.v"
`include "./Logical_modules/DiscountCalculator.v"
`include "./Logical_modules/ProductCounter.v"
`include "./Logical_modules/InventoryCounter.v"
`include "./Logical_modules/LowStockAlert.v"
`include "./Logical_modules/SalesRegister.v"

module MainModule (
    input [2:0] product_id,
    input [7:0] price0, price1, price2, price3, price4, price5, price6, price7,
    input [3:0] quantity, 
    input [15:0] amount_paid,
    input clk,
    input reset,
    output [7:0] price,
    output [15:0] total_price,
    output [15:0] discounted_price, 
    output [15:0] remaining_amount, 
    output [3:0] initial_inventory_count0, initial_inventory_count1, initial_inventory_count2, initial_inventory_count3, initial_inventory_count4, initial_inventory_count5, initial_inventory_count6, initial_inventory_count7, // موجودی اولیه برای هر محصول
    output [3:0] final_inventory_count0, final_inventory_count1, final_inventory_count2, final_inventory_count3, final_inventory_count4, final_inventory_count5, final_inventory_count6, final_inventory_count7, // موجودی پس از خرید برای هر محصول
    output [1:0] alert0, alert1, alert2, alert3, alert4, alert5, alert6, alert7 
);

    wire [7:0] prices [0:7]; 
    wire discount;
    reg [3:0] inventory_counts [0:7]; 
    wire local_alerts [0:7]; 


    assign prices[0] = price0;
    assign prices[1] = price1;
    assign prices[2] = price2;
    assign prices[3] = price3;
    assign prices[4] = price4;
    assign prices[5] = price5;
    assign prices[6] = price6;
    assign prices[7] = price7;


    assign price = prices[product_id];

 
    assign total_price = price * quantity;


    Comparator comparator (
        .count(quantity),
        .discount(discount)
    );


    DiscountCalculator discount_calculator (
        .total_amount(total_price),
        .discount(discount),
        .discounted_amount(discounted_price)
    );

    Remaining change_calculator (
        .price(discounted_price),
        .amount_paid(amount_paid),
        .remaining(remaining_amount)
    );

    
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : inventory_loop
            always @(posedge clk or posedge reset) begin
                if (reset) begin
                    inventory_counts[i] <= 4'b1111; 
                end else if (product_id == i && quantity > 0) begin
                    inventory_counts[i] <= inventory_counts[i] - quantity; 
                end
            end

            LowStockAlert low_stock_alert (
                .inventory_count(inventory_counts[i]),
                .alert(local_alerts[i])
            );
        end
    endgenerate


    assign initial_inventory_count0 = 4'b1111;
    assign initial_inventory_count1 = 4'b1111;
    assign initial_inventory_count2 = 4'b1111;
    assign initial_inventory_count3 = 4'b1111;
    assign initial_inventory_count4 = 4'b1111;
    assign initial_inventory_count5 = 4'b1111;
    assign initial_inventory_count6 = 4'b1111;
    assign initial_inventory_count7 = 4'b1111;

    assign final_inventory_count0 = inventory_counts[0];
    assign final_inventory_count1 = inventory_counts[1];
    assign final_inventory_count2 = inventory_counts[2];
    assign final_inventory_count3 = inventory_counts[3];
    assign final_inventory_count4 = inventory_counts[4];
    assign final_inventory_count5 = inventory_counts[5];
    assign final_inventory_count6 = inventory_counts[6];
    assign final_inventory_count7 = inventory_counts[7];

   
    assign alert0 = local_alerts[0];
    assign alert1 = local_alerts[1];
    assign alert2 = local_alerts[2];
    assign alert3 = local_alerts[3];
    assign alert4 = local_alerts[4];
    assign alert5 = local_alerts[5];
    assign alert6 = local_alerts[6];
    assign alert7 = local_alerts[7];

endmodule


module testbench;
    reg [2:0] product_id;
    reg [7:0] price0, price1, price2, price3, price4, price5, price6, price7;
    reg [3:0] quantity; 
    reg [15:0] amount_paid; 
    reg clk, reset;
    wire [7:0] price;
    wire [15:0] total_price; 
    wire [15:0] discounted_price; 
    wire [15:0] remaining_amount; 
    wire [3:0] initial_inventory_count0, initial_inventory_count1, initial_inventory_count2, initial_inventory_count3, initial_inventory_count4, initial_inventory_count5, initial_inventory_count6, initial_inventory_count7; // موجودی اولیه برای هر محصول
    wire [3:0] final_inventory_count0, final_inventory_count1, final_inventory_count2, final_inventory_count3, final_inventory_count4, final_inventory_count5, final_inventory_count6, final_inventory_count7; // موجودی پس از خرید برای هر محصول
    wire [1:0] alert0, alert1, alert2, alert3, alert4, alert5, alert6, alert7; 

    MainModule main (
        .product_id(product_id),
        .price0(price0), .price1(price1), .price2(price2), .price3(price3),
        .price4(price4), .price5(price5), .price6(price6), .price7(price7),
        .quantity(quantity),
        .amount_paid(amount_paid),
        .clk(clk),
        .reset(reset),
        .price(price),
        .total_price(total_price),
        .discounted_price(discounted_price),
        .remaining_amount(remaining_amount),
        .initial_inventory_count0(initial_inventory_count0), .initial_inventory_count1(initial_inventory_count1), .initial_inventory_count2(initial_inventory_count2), .initial_inventory_count3(initial_inventory_count3), .initial_inventory_count4(initial_inventory_count4), .initial_inventory_count5(initial_inventory_count5), .initial_inventory_count6(initial_inventory_count6), .initial_inventory_count7(initial_inventory_count7),
        .final_inventory_count0(final_inventory_count0), .final_inventory_count1(final_inventory_count1), .final_inventory_count2(final_inventory_count2), .final_inventory_count3(final_inventory_count3), .final_inventory_count4(final_inventory_count4), .final_inventory_count5(final_inventory_count5), .final_inventory_count6(final_inventory_count6), .final_inventory_count7(final_inventory_count7),
        .alert0(alert0), .alert1(alert1), .alert2(alert2), .alert3(alert3), .alert4(alert4), .alert5(alert5), .alert6(alert6), .alert7(alert7)
    );

    initial begin

        price0 = 8'd10;
        price1 = 8'd20;
        price2 = 8'd30;
        price3 = 8'd40;
        price4 = 8'd50;
        price5 = 8'd60;
        price6 = 8'd70;
        price7 = 8'd80;


        product_id = 3'b000; clk = 0; reset = 0; amount_paid = 16'd0; quantity = 4'd0;


        #5 reset = 1;
        #5 reset = 0;


        #10 product_id = 3'b001; amount_paid = 16'd250; quantity = 4'd5;
        #10 product_id = 3'b010; amount_paid = 16'd350; quantity = 4'd10;
                #10 product_id = 3'b010; amount_paid = 16'd350; quantity = 4'd10;
        #10 product_id = 3'b011; amount_paid = 16'd450; quantity = 4'd12;
        #10 product_id = 3'b100; amount_paid = 16'd550; quantity = 4'd15;

        #20 $finish;
    end

    always #5 clk = ~clk; 

    initial begin
        $monitor("At time %t, Product ID = %b, Price = %d, Total Price = %d, Discounted Price = %d, Amount Paid = %d, Remaining Amount = %d, Quantity = %d, Initial Inventory Counts = %d%d%d%d%d%d%d%d, Final Inventory Counts = %d%d%d%d%d%d%d%d, Alerts = %b%b%b%b%b%b%b%b", 
            $time, product_id, price, total_price, discounted_price, amount_paid, remaining_amount, quantity, 
            initial_inventory_count0, initial_inventory_count1, initial_inventory_count2, initial_inventory_count3, 
            initial_inventory_count4, initial_inventory_count5, initial_inventory_count6, initial_inventory_count7, 
            final_inventory_count0, final_inventory_count1, final_inventory_count2, final_inventory_count3, 
            final_inventory_count4, final_inventory_count5, final_inventory_count6, final_inventory_count7,
            alert0, alert1, alert2, alert3, alert4, alert5, alert6, alert7);
    end
endmodule

