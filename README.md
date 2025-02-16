# 🛒 Sales and Inventory Management System with Verilog 🛍️

This project implements a simple sales and inventory management system using **Verilog** hardware description language. The system can calculate the total price, apply discounts, compute the remaining amount, and manage product inventory. It also detects low stock levels and issues alerts. 🚨

---

## ✨ Features

- **📦 Inventory Management**: Manages initial and final stock levels for each product.
- **💰 Price Calculation**: Calculates the total price based on the quantity of products purchased.
- **🎁 Discounts**: Applies discounts when a specific quantity of products is purchased.
- **💸 Remaining Amount**: Computes the remaining amount after payment.
- **🚨 Low Stock Alert**: Issues alerts when stock levels are low.

---

## 🧩 Project Structure

The project includes the following modules:

- **DFF.v**: D Flip-Flop module.
- **FMS.v**: Finite State Machine module.
- **Remaining.v**: Remaining amount calculation module.
- **Register.v**: Register module.
- **decoder_3to8.v**: 3-to-8 decoder module.
- **Comparator.v**: Comparator module.
- **DiscountCalculator.v**: Discount calculation module.
- **ProductCounter.v**: Product counter module.
- **InventoryCounter.v**: Inventory counter module.
- **LowStockAlert.v**: Low stock alert module.
- **SalesRegister.v**: Sales register module.

---

## 🚀 How to Run

To run the project, follow these steps:

1. **Simulation**: Use a Verilog simulator like **ModelSim** or **Icarus Verilog**.
2. **Compile**: Compile the Verilog files.
3. **Run**: Execute the testbench to view the simulation results.

```bash
iverilog -o output MainModule.v testbench.v
vvp output
```

---

## 📊 Testbench Outputs

The testbench automatically displays the following outputs:

- **🆔 Product ID**: Product identifier.
- **💵 Price**: Unit price of the product.
- **💳 Total Price**: Total price without discount.
- **🎉 Discounted Price**: Total price after applying the discount.
- **💸 Amount Paid**: Amount paid by the customer.
- **🔄 Remaining Amount**: Remaining amount after payment.
- **📦 Quantity**: Quantity of products purchased.
- **📥 Initial Inventory Counts**: Initial stock levels for each product.
- **📤 Final Inventory Counts**: Final stock levels for each product after purchase.
- **🚨 Alerts**: Low stock alerts for each product.

---

## 📦 Dependencies

- **Icarus Verilog**: For simulating and running Verilog code.
- **GTKWave**: For viewing simulation waveforms (optional).

---

## 🤝 Contributing

If you'd like to contribute to this project, please follow these steps:

1. Fork the project. 🍴
2. Create a new branch (`git checkout -b feature/YourFeatureName`). 🌿
3. Commit your changes (`git commit -m 'Add some feature'`). 💾
4. Push your changes to your repository (`git push origin feature/YourFeatureName`). 🚀
5. Open a pull request. 📥

---
