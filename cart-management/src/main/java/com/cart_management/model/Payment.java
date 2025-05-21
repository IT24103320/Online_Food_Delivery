package com.cart_management.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class Payment {
    private String paymentId;
    private String orderId;
    private String userId;
    private double amount;
    private String paymentMethod;
    private String cardNumber; // Last 4 digits only
    private String cardholderName;
    private String status;
    private String timestamp;
    
    public Payment() {
        this.paymentId = generatePaymentId();
        this.status = "Pending";
        this.timestamp = getCurrentTimestamp();
    }
    
    // Generate a unique payment ID
    private String generatePaymentId() {
        return "PAY-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    
    // Get current timestamp as formatted string
    private String getCurrentTimestamp() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }
    
    // Process a credit card payment
    public boolean processCreditCardPayment(String cardNumber, String expiryDate, String cvv, String cardholderName) {
        // In a real system, this would integrate with a payment gateway
        // For this demo, we'll just simulate a successful payment
        
        // Basic validation
        if (cardNumber == null || cardNumber.length() < 13 || cardNumber.length() > 19) {
            return false;
        }
        
        if (expiryDate == null || !expiryDate.matches("\\d{2}/\\d{2}")) {
            return false;
        }
        
        if (cvv == null || !cvv.matches("\\d{3,4}")) {
            return false;
        }
        
        if (cardholderName == null || cardholderName.trim().isEmpty()) {
            return false;
        }
        
        // Store only last 4 digits of card number
        this.cardNumber = "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
        this.cardholderName = cardholderName;
        this.paymentMethod = "Credit Card";
        this.status = "Completed";
        
        return true;
    }
    
    // Convert to data string for storage
    public String toDataString() {
        return paymentId + "|" + 
               orderId + "|" + 
               userId + "|" + 
               amount + "|" + 
               paymentMethod + "|" + 
               cardNumber + "|" + 
               cardholderName + "|" + 
               status + "|" + 
               timestamp;
    }
    
    // Create from data string
    public static Payment fromDataString(String data) {
        String[] parts = data.split("\\|", -1);
        if (parts.length != 9) return null;
        
        try {
            Payment payment = new Payment();
            payment.setPaymentId(parts[0]);
            payment.setOrderId(parts[1]);
            payment.setUserId(parts[2]);
            payment.setAmount(Double.parseDouble(parts[3]));
            payment.setPaymentMethod(parts[4]);
            payment.setCardNumber(parts[5]);
            payment.setCardholderName(parts[6]);
            payment.setStatus(parts[7]);
            payment.setTimestamp(parts[8]);
            return payment;
        } catch (Exception e) {
            return null;
        }
    }
    
    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardholderName() {
        return cardholderName;
    }

    public void setCardholderName(String cardholderName) {
        this.cardholderName = cardholderName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
