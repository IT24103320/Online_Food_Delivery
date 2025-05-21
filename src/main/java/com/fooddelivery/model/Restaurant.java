package com.fooddelivery.model;

public class Restaurant {
    private int id;
    private String name;
    private String address;
    private String cuisine;
    private String ownerId;

    public Restaurant(int id, String name, String address, String cuisine, String ownerId) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.cuisine = cuisine;
        this.ownerId = ownerId;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getCuisine() { return cuisine; }
    public String getOwnerId() { return ownerId; }

    public String toCsv() {
        return id + "," + name + "," + address + "," + cuisine + "," + ownerId;
    }

    public static Restaurant fromCsv(String csv) {
        String[] parts = csv.split(",");
        return new Restaurant(Integer.parseInt(parts[0]), parts[1], parts[2], parts[3], parts[4]);
    }
}