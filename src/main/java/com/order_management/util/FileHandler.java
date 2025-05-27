package com.order_management.util;

import com.order_management.model.Order;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {

    private static String filePath;
    private static OrderQueue orderQueue = new OrderQueue();

    // Setter to configure the file path, call this once from servlet init()
    public static void setFilePath(String path) {
        filePath = path;
        // Initialize queue by loading existing orders from file
        orderQueue.initialize(readOrders());
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
        orderQueue.enqueue(order); // Add to queue
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(getFilePath(), true))) {
            writer.write(order.toDataString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void deleteOrder(String orderId) {
        orderQueue.remove(orderId); // Remove from queue
        List<Order> orders = orderQueue.getAllOrders();
        writeOrders(orders);
    }

    public static void updateOrder(Order updatedOrder) {
        orderQueue.update(updatedOrder); // Update in queue
        List<Order> orders = orderQueue.getAllOrders();
        writeOrders(orders);
    }

    public static Order getOrderById(String orderId) {
        return orderQueue.getOrderById(orderId);
    }

    public static List<Order> getAllOrders() {
        return orderQueue.getAllOrders();
    }

    // Get the next order for delivery without removing it
    public static Order getNextOrder() {
        return orderQueue.peek();
    }

    // Remove and return the next order for delivery
    public static Order processNextOrder() {
        Order nextOrder = orderQueue.dequeue();
        if (nextOrder != null) {
            // Update file by rewriting all remaining orders
            writeOrders(orderQueue.getAllOrders());
        }
        return nextOrder;
    }
}