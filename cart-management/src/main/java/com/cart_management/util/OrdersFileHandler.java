package com.cart_management.util;

import com.cart_management.model.CartItem;
import com.cart_management.model.Order;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrdersFileHandler {
    private static String ordersFilePath;
    private static String orderItemsFilePath;
    
    // Set file paths
    public static void initFilePaths(String contextPath) {
        ordersFilePath = contextPath + "/WEB-INF/data/orders.txt";
        orderItemsFilePath = contextPath + "/WEB-INF/data/order_items.txt";
        
        // Ensure data directory exists
        File dataDir = new File(contextPath + "/WEB-INF/data");
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }
        
        // Ensure files exist
        try {
            File ordersFile = new File(ordersFilePath);
            if (!ordersFile.exists()) {
                ordersFile.createNewFile();
            }
            
            File orderItemsFile = new File(orderItemsFilePath);
            if (!orderItemsFile.exists()) {
                orderItemsFile.createNewFile();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // Save a new order
    public static boolean saveOrder(Order order) {
        try {
            // Save order header
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(ordersFilePath, true))) {
                writer.write(order.toDataString());
                writer.newLine();
            }
            
            // Save order items
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(orderItemsFilePath, true))) {
                for (CartItem item : order.getItems()) {
                    String itemData = order.getOrderId() + "|" + item.toDataString();
                    writer.write(itemData);
                    writer.newLine();
                }
            }
            
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all orders
    public static List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        Map<String, List<CartItem>> orderItems = new HashMap<>();
        
        // First, load all order items
        try (BufferedReader reader = new BufferedReader(new FileReader(orderItemsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|", 2);
                if (parts.length < 2) continue;
                
                String orderId = parts[0];
                CartItem item = CartItem.fromDataString(parts[1]);
                
                if (item != null) {
                    orderItems.computeIfAbsent(orderId, k -> new ArrayList<>()).add(item);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        // Then load orders and associate items
        try (BufferedReader reader = new BufferedReader(new FileReader(ordersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Order order = Order.fromDataString(line);
                if (order != null) {
                    order.setItems(orderItems.getOrDefault(order.getOrderId(), new ArrayList<>()));
                    orders.add(order);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    // Get orders for a specific user
    public static List<Order> getUserOrders(String userId) {
        List<Order> allOrders = getAllOrders();
        List<Order> userOrders = new ArrayList<>();
        
        for (Order order : allOrders) {
            if (order.getUserId().equals(userId)) {
                userOrders.add(order);
            }
        }
        
        return userOrders;
    }
    
    // Get a specific order by ID
    public static Order getOrderById(String orderId) {
        List<Order> allOrders = getAllOrders();
        
        for (Order order : allOrders) {
            if (order.getOrderId().equals(orderId)) {
                return order;
            }
        }
        
        return null;
    }
    
    // Update order status
    public static boolean updateOrderStatus(String orderId, String newStatus) {
        List<Order> allOrders = getAllOrders();
        List<String> updatedOrders = new ArrayList<>();
        boolean found = false;
        
        for (Order order : allOrders) {
            if (order.getOrderId().equals(orderId)) {
                order.setOrderStatus(newStatus);
                found = true;
            }
            updatedOrders.add(order.toDataString());
        }
        
        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(ordersFilePath))) {
                for (String orderData : updatedOrders) {
                    writer.write(orderData);
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        return false;
    }
}
