package com.cart_management.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class Order {
    private String orderId;
    private String userId;
    private int restaurantId;
    private String restaurantName;
    private List<CartItem> items;
    private double subtotal;
    private double discount;
    private double tax;
    private double deliveryFee;
    private double totalAmount;
    private String promoCode;
    private String deliveryAddress;
    private String customerName;
    private String customerPhone;
    private String paymentMethod;
    private String paymentId;
    private String orderStatus;
    private String orderDate;
    private String estimatedDeliveryTime;
    
    public Order() {
        this.orderId = generateOrderId();
        this.items = new ArrayList<>();
        this.orderStatus = "Pending";
        this.orderDate = getCurrentDateTime();
        this.estimatedDeliveryTime = calculateEstimatedDeliveryTime();
    }
    
    // Create order from cart
    public static Order createFromCart(Cart cart, String userId, String deliveryAddress, 
                                      String customerName, String customerPhone) {
        Order order = new Order();
        order.setUserId(userId);
        order.setRestaurantId(cart.getRestaurantId());
        order.setRestaurantName(cart.getRestaurantName());
        order.setItems(new ArrayList<>(cart.getItems()));
        order.setSubtotal(cart.getSubtotal());
        order.setDiscount(cart.getDiscountAmount());
        order.setTax(cart.getTaxAmount());
        order.setDeliveryFee(cart.getDeliveryFee());
        order.setTotalAmount(cart.getTotalAmount());
        order.setPromoCode(cart.getPromoCode());
        order.setDeliveryAddress(deliveryAddress);
        order.setCustomerName(customerName);
        order.setCustomerPhone(customerPhone);
        return order;
    }
    
    // Generate a unique order ID
    private String generateOrderId() {
        return "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    
    // Get current date and time as formatted string
    private String getCurrentDateTime() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }
    
    // Calculate estimated delivery time (30-45 minutes from now)
    private String calculateEstimatedDeliveryTime() {
        LocalDateTime estimatedTime = LocalDateTime.now().plusMinutes(30);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        return estimatedTime.format(formatter);
    }
    
    // Convert order to string representation for storage
    public String toDataString() {
        StringBuilder sb = new StringBuilder();
        sb.append(orderId).append("|");
        sb.append(userId).append("|");
        sb.append(restaurantId).append("|");
        sb.append(restaurantName).append("|");
        sb.append(subtotal).append("|");
        sb.append(discount).append("|");
        sb.append(tax).append("|");
        sb.append(deliveryFee).append("|");
        sb.append(totalAmount).append("|");
        sb.append(promoCode == null ? "" : promoCode).append("|");
        sb.append(deliveryAddress).append("|");
        sb.append(customerName).append("|");
        sb.append(customerPhone).append("|");
        sb.append(paymentMethod == null ? "" : paymentMethod).append("|");
        sb.append(paymentId == null ? "" : paymentId).append("|");
        sb.append(orderStatus).append("|");
        sb.append(orderDate).append("|");
        sb.append(estimatedDeliveryTime);
        return sb.toString();
    }
    
    // Create order from data string
    public static Order fromDataString(String data) {
        String[] parts = data.split("\\|", -1);
        if (parts.length != 18) return null;
        
        try {
            Order order = new Order();
            order.setOrderId(parts[0]);
            order.setUserId(parts[1]);
            order.setRestaurantId(Integer.parseInt(parts[2]));
            order.setRestaurantName(parts[3]);
            order.setSubtotal(Double.parseDouble(parts[4]));
            order.setDiscount(Double.parseDouble(parts[5]));
            order.setTax(Double.parseDouble(parts[6]));
            order.setDeliveryFee(Double.parseDouble(parts[7]));
            order.setTotalAmount(Double.parseDouble(parts[8]));
            order.setPromoCode(parts[9]);
            order.setDeliveryAddress(parts[10]);
            order.setCustomerName(parts[11]);
            order.setCustomerPhone(parts[12]);
            order.setPaymentMethod(parts[13]);
            order.setPaymentId(parts[14]);
            order.setOrderStatus(parts[15]);
            order.setOrderDate(parts[16]);
            order.setEstimatedDeliveryTime(parts[17]);
            return order;
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public double getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(double deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getEstimatedDeliveryTime() {
        return estimatedDeliveryTime;
    }

    public void setEstimatedDeliveryTime(String estimatedDeliveryTime) {
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }
}
