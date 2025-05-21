package com.cart_management.model;

public class CartItem {
    private int id;
    private int menuItemId;
    private String name;
    private double price;
    private int quantity;
    private String specialInstructions;
    private int restaurantId;
    private String restaurantName;
    private String imagePath;

    public CartItem() {
    }

    public CartItem(int id, int menuItemId, String name, double price, int quantity, String specialInstructions, 
                  int restaurantId, String restaurantName, String imagePath) {
        this.id = id;
        this.menuItemId = menuItemId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.specialInstructions = specialInstructions;
        this.restaurantId = restaurantId;
        this.restaurantName = restaurantName;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMenuItemId() {
        return menuItemId;
    }

    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSpecialInstructions() {
        return specialInstructions;
    }

    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
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
    
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public double getSubtotal() {
        return price * quantity;
    }

    // Convert to string for file storage
    public String toDataString() {
        return id + "," + menuItemId + "," + name + "," + price + "," + quantity + "," + 
               specialInstructions + "," + restaurantId + "," + restaurantName + "," + imagePath;
    }

    // Create CartItem from a data string
    public static CartItem fromDataString(String dataLine) {
        String[] parts = dataLine.split(",", -1);
        if (parts.length != 9) return null;

        try {
            int id = Integer.parseInt(parts[0]);
            int menuItemId = Integer.parseInt(parts[1]);
            String name = parts[2];
            double price = Double.parseDouble(parts[3]);
            int quantity = Integer.parseInt(parts[4]);
            String specialInstructions = parts[5];
            int restaurantId = Integer.parseInt(parts[6]);
            String restaurantName = parts[7];
            String imagePath = parts[8];

            return new CartItem(id, menuItemId, name, price, quantity, specialInstructions, 
                              restaurantId, restaurantName, imagePath);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
