package com.order_management.model;

public class Order {
    private String orderId;
    private String customerName;
    private String address;
    private double price;
    private String phone;

    public Order() {
    }

    public Order(String orderId, String customerName, String address, double price, String phone) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.address = address;
        this.price = price;
        this.phone = phone;
    }

    // Getters
    public String getOrderId() {
        return orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getAddress() {
        return address;
    }

    public double getPrice() {
        return price;
    }

    public String getPhone() {
        return phone;
    }

    // Setters
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Convert to comma-separated format for .txt storage
    public String toDataString() {
        return orderId + "," + customerName + "," + address + "," + price + "," + phone;
    }

    // Create Order object from a line in the .txt file
    public static Order fromDataString(String dataLine) {
        String[] parts = dataLine.split(",", -1);
        if (parts.length != 5) return null;

        try {
            double parsedPrice = Double.parseDouble(parts[3]);
            return new Order(parts[0], parts[1], parts[2], parsedPrice, parts[4]);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}