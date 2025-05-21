package com.fooddelivery.model;

import java.util.UUID;

public class MenuItem {
    private int id;
    private String name;
    private int restaurantId;
    private double price;
    private String description;
    private String imagePath;

    public MenuItem(int id, String name, int restaurantId, double price, String description, String imagePath) {
        this.id = id;
        this.name = name;
        this.restaurantId = restaurantId;
        this.price = price;
        this.description = description;
        this.imagePath = imagePath;
    }

    public String toCsv() {
        return id + "," + name + "," + restaurantId + "," + price + "," + description + "," + imagePath;
    }

    public static String generateUniqueImagePath(String originalFileName) {
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        return "images/" + UUID.randomUUID().toString() + extension;
    }
}