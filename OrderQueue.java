package com.order_management.util;

import com.order_management.model.Order;
import java.util.ArrayList;
import java.util.List;

public class OrderQueue {
    private Order[] queue; // Circular array to store orders
    private int front; // Index of the front element
    private int rear; // Index where the next element will be added
    private int size; // Current number of elements
    private int capacity; // Maximum capacity of the queue
    private static final int DEFAULT_CAPACITY = 100; // Default capacity

    public OrderQueue() {
        this(DEFAULT_CAPACITY);
    }

    public OrderQueue(int capacity) {
        this.capacity = capacity;
        this.queue = new Order[capacity];
        this.front = 0;
        this.rear = -1;
        this.size = 0;
    }

    // Add an order to the end of the queue (enqueue)
    public void enqueue(Order order) {
        if (size == capacity) {
            resize(); // Double the capacity if full
        }
        rear = (rear + 1) % capacity; // Circular increment
        queue[rear] = order;
        size++;
    }

    // Remove and return the order at the front of the queue (dequeue)
    public Order dequeue() {
        if (size == 0) {
            return null; // Queue is empty
        }
        Order order = queue[front];
        queue[front] = null; // Clear reference
        front = (front + 1) % capacity; // Circular increment
        size--;
        return order;
    }

    // View the order at the front of the queue without removing it (peek)
    public Order peek() {
        if (size == 0) {
            return null; // Queue is empty
        }
        return queue[front];
    }

    // Remove an order by orderId
    public void remove(String orderId) {
        if (size == 0) {
            return;
        }
        // Create a temporary queue to rebuild without the specified order
        Order[] temp = new Order[capacity];
        int tempIndex = 0;
        int oldFront = front;
        for (int i = 0; i < size; i++) {
            Order order = queue[(oldFront + i) % capacity];
            if (!order.getOrderId().equals(orderId)) {
                temp[tempIndex++] = order;
            }
        }
        // Update queue
        queue = temp;
        front = 0;
        rear = tempIndex - 1;
        size = tempIndex;
    }

    // Update an order in the queue
    public void update(Order updatedOrder) {
        for (int i = 0; i < size; i++) {
            int index = (front + i) % capacity;
            if (queue[index].getOrderId().equals(updatedOrder.getOrderId())) {
                queue[index] = updatedOrder;
                break;
            }
        }
    }

    // Get an order by orderId
    public Order getOrderById(String orderId) {
        for (int i = 0; i < size; i++) {
            int index = (front + i) % capacity;
            if (queue[index].getOrderId().equals(orderId)) {
                return queue[index];
            }
        }
        return null;
    }

    // Get all orders as a list
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            orders.add(queue[(front + i) % capacity]);
        }
        return orders;
    }

    // Initialize queue with a list of orders
    public void initialize(List<Order> orders) {
        size = 0;
        front = 0;
        rear = -1;
        if (orders.size() > capacity) {
            capacity = orders.size() * 2; // Ensure enough capacity
            queue = new Order[capacity];
        }
        for (Order order : orders) {
            enqueue(order);
        }
    }

    // Resize the queue by doubling its capacity
    private void resize() {
        int newCapacity = capacity * 2;
        Order[] newQueue = new Order[newCapacity];
        for (int i = 0; i < size; i++) {
            newQueue[i] = queue[(front + i) % capacity];
        }
        queue = newQueue;
        front = 0;
        rear = size - 1;
        capacity = newCapacity;
    }
}