package com.cart_management.util;

import com.cart_management.model.Payment;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentFileHandler {
    private static String paymentsFilePath;
    
    // Set file path
    public static void initFilePath(String contextPath) {
        paymentsFilePath = contextPath + "/WEB-INF/data/payments.txt";
        
        // Ensure data directory exists
        File dataDir = new File(contextPath + "/WEB-INF/data");
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }
        
        // Ensure file exists
        try {
            File paymentsFile = new File(paymentsFilePath);
            if (!paymentsFile.exists()) {
                paymentsFile.createNewFile();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // Save a new payment
    public static boolean savePayment(Payment payment) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(paymentsFilePath, true))) {
            writer.write(payment.toDataString());
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all payments
    public static List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(paymentsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Payment payment = Payment.fromDataString(line);
                if (payment != null) {
                    payments.add(payment);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return payments;
    }
    
    // Get payment by ID
    public static Payment getPaymentById(String paymentId) {
        List<Payment> allPayments = getAllPayments();
        
        for (Payment payment : allPayments) {
            if (payment.getPaymentId().equals(paymentId)) {
                return payment;
            }
        }
        
        return null;
    }
    
    // Get payments for a specific order
    public static Payment getPaymentByOrderId(String orderId) {
        List<Payment> allPayments = getAllPayments();
        
        for (Payment payment : allPayments) {
            if (payment.getOrderId().equals(orderId)) {
                return payment;
            }
        }
        
        return null;
    }
    
    // Get payments for a specific user
    public static List<Payment> getUserPayments(String userId) {
        List<Payment> allPayments = getAllPayments();
        List<Payment> userPayments = new ArrayList<>();
        
        for (Payment payment : allPayments) {
            if (payment.getUserId().equals(userId)) {
                userPayments.add(payment);
            }
        }
        
        return userPayments;
    }
    
    // Update payment status
    public static boolean updatePaymentStatus(String paymentId, String newStatus) {
        List<Payment> allPayments = getAllPayments();
        List<String> updatedPayments = new ArrayList<>();
        boolean found = false;
        
        for (Payment payment : allPayments) {
            if (payment.getPaymentId().equals(paymentId)) {
                payment.setStatus(newStatus);
                found = true;
            }
            updatedPayments.add(payment.toDataString());
        }
        
        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(paymentsFilePath))) {
                for (String paymentData : updatedPayments) {
                    writer.write(paymentData);
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
