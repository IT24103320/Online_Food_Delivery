package com.fooddelivery.model;

public class Admin {
    private int id;
    private String username;
    private String password;

    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }

    public String toCsv() {
        return id + "," + username + "," + password;
    }

    public static Admin fromCsv(String csv) {
        String[] parts = csv.split(",");
        return new Admin(Integer.parseInt(parts[0]), parts[1], parts[2]);
    }
}