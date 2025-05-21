package com.order_management.util;

import com.order_management.model.Order;

import java.io.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class FileHandler {

    private static String filePath;
    private static LinkedList<Order> orderQueue = new LinkedList<>();

    // Setter to configure the file path, call this once from servlet init()
    public static void setFilePath(String path) {
        filePath = path;
        // Initialize queue by loading existing orders from file
        orderQueue = new LinkedList<>(readOrders());
    }

    private static String getFilePath() {
        if (filePath == null) {
            throw new IllegalStateException("File path not set in FileHandler");
        }
        return filePath;
    }

    public static List<Order> readOrders() {
        List<Order> orders = new ArrayList<>();
        File file = new File(getFilePath());

        // If file does not exist, return empty list (no orders yet)
        if (!file.exists()) {
            return orders;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Order order = Order.fromDataString(line);
                if (order != null) {
                    orders.add(order);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public static void writeOrders(List<Order> orders) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(getFilePath()))) {
            for (Order order : orders) {
                writer.write(order.toDataString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void addOrder(Order order) {
        orderQueue.add(order); // Add to queue
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(getFilePath(), true))) {
            writer.write(order.toDataString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void deleteOrder(String orderId) {
        orderQueue.removeIf(order -> order.getOrderId().equals(orderId)); // Remove from queue
        List<Order> orders = new ArrayList<>(orderQueue);
        writeOrders(orders);
    }

    public static void updateOrder(Order updatedOrder) {
        // Update queue
        for (int i = 0; i < orderQueue.size(); i++) {
            if (orderQueue.get(i).getOrderId().equals(updatedOrder.getOrderId())) {
                orderQueue.set(i, updatedOrder);
                break;
            }
        }
        // Update file
        writeOrders(new ArrayList<>(orderQueue));
    }

    public static Order getOrderById(String orderId) {
        for (Order order : orderQueue) {
            if (order.getOrderId().equals(orderId)) {
                return order;
            }
        }
        return null;
    }

    public static List<Order> getAllOrders() {
        return new ArrayList<>(orderQueue);
    }
}