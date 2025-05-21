package com.cart_management.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
    private String userId;
    private List<CartItem> items;
    private String promoCode;
    private double discount;
    
    // Constants for tax and delivery fee calculation
    private static final double TAX_RATE = 0.05; // 5% tax
    private static final double DELIVERY_FEE = 2.50; // $2.50 delivery fee
    
    public Cart(String userId) {
        this.userId = userId;
        this.items = new ArrayList<>();
        this.promoCode = "";
        this.discount = 0.0;
    }
    
    // Add a new item to the cart
    public void addItem(CartItem item) {
        // Check if we already have items from a different restaurant
        if (!items.isEmpty() && items.get(0).getRestaurantId() != item.getRestaurantId()) {
            throw new IllegalStateException("Cannot add items from multiple restaurants to the same cart");
        }
        
        // Check if this item already exists in the cart
        for (CartItem existingItem : items) {
            if (existingItem.getMenuItemId() == item.getMenuItemId() && 
                (existingItem.getSpecialInstructions() == null ? item.getSpecialInstructions() == null : 
                existingItem.getSpecialInstructions().equals(item.getSpecialInstructions()))) {
                // Update quantity instead of adding a new item
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        
        // If item doesn't exist yet, add it to the cart
        items.add(item);
    }
    
    // Update an item quantity
    public void updateItemQuantity(int cartItemId, int newQuantity) {
        for (CartItem item : items) {
            if (item.getId() == cartItemId) {
                if (newQuantity <= 0) {
                    // Remove the item if quantity is 0 or less
                    items.remove(item);
                } else {
                    item.setQuantity(newQuantity);
                }
                return;
            }
        }
    }
    
    // Update item special instructions
    public void updateItemInstructions(int cartItemId, String instructions) {
        for (CartItem item : items) {
            if (item.getId() == cartItemId) {
                item.setSpecialInstructions(instructions);
                return;
            }
        }
    }
    
    // Remove an item from the cart
    public void removeItem(int cartItemId) {
        items.removeIf(item -> item.getId() == cartItemId);
    }
    
    // Clear all items from the cart
    public void clearCart() {
        items.clear();
        promoCode = "";
        discount = 0.0;
    }
    
    // Apply a promo code to the cart
    public boolean applyPromoCode(String code) {
        // Simple promo code implementation
        Map<String, Double> validCodes = new HashMap<>();
        validCodes.put("WELCOME10", 0.10); // 10% off
        validCodes.put("SUMMER20", 0.20); // 20% off
        validCodes.put("FREESHIP", DELIVERY_FEE); // Free shipping
        
        if (validCodes.containsKey(code)) {
            this.promoCode = code;
            this.discount = validCodes.get(code);
            return true;
        }
        return false;
    }
    
    // Remove promo code
    public void removePromoCode() {
        this.promoCode = "";
        this.discount = 0.0;
    }
    
    // Calculate subtotal (before tax and delivery fee)
    public double getSubtotal() {
        double subtotal = 0.0;
        for (CartItem item : items) {
            subtotal += item.getSubtotal();
        }
        return subtotal;
    }
    
    // Calculate discount amount
    public double getDiscountAmount() {
        if (promoCode.equals("FREESHIP")) {
            return DELIVERY_FEE;
        }
        return getSubtotal() * discount;
    }
    
    // Calculate tax amount
    public double getTaxAmount() {
        return (getSubtotal() - getDiscountAmount()) * TAX_RATE;
    }
    
    // Calculate delivery fee
    public double getDeliveryFee() {
        if (promoCode.equals("FREESHIP")) {
            return 0.0;
        }
        return DELIVERY_FEE;
    }
    
    // Calculate total amount
    public double getTotalAmount() {
        return getSubtotal() - getDiscountAmount() + getTaxAmount() + getDeliveryFee();
    }
    
    // Getters and Setters
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public List<CartItem> getItems() {
        return items;
    }
    
    public void setItems(List<CartItem> items) {
        this.items = items;
    }
    
    public String getPromoCode() {
        return promoCode;
    }
    
    public double getDiscount() {
        return discount;
    }
    
    public String getRestaurantName() {
        if (items.isEmpty()) {
            return "";
        }
        return items.get(0).getRestaurantName();
    }
    
    public int getRestaurantId() {
        if (items.isEmpty()) {
            return -1;
        }
        return items.get(0).getRestaurantId();
    }
    
    public int getItemCount() {
        return items.size();
    }
    
    public int getTotalQuantity() {
        int totalQuantity = 0;
        for (CartItem item : items) {
            totalQuantity += item.getQuantity();
        }
        return totalQuantity;
    }
}
