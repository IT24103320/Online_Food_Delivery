package com.cart_management.servlet;

import com.cart_management.model.Order;
import com.cart_management.model.Payment;
import com.cart_management.util.CartManager;
import com.cart_management.util.OrdersFileHandler;
import com.cart_management.util.PaymentFileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = "/payment/*")
public class PaymentServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        // Initialize file handlers
        String contextPath = getServletContext().getRealPath("/");
        PaymentFileHandler.initFilePath(contextPath);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Order pendingOrder = (Order) session.getAttribute("pendingOrder");
        
        String pathInfo = request.getPathInfo();
        
        // Using switch for path info handling
        switch (pathInfo == null ? "/" : pathInfo) {
            case "", "/", "/process" -> {
                // Payment process page (enter credit card details)
                if (pendingOrder == null) {
                    // No pending order, redirect to cart
                    response.sendRedirect(request.getContextPath() + "/cart/view");
                    return;
                }
                
                request.setAttribute("order", pendingOrder);
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
            }
            
            case "/success" -> {
                // Payment success page
                String orderId = request.getParameter("orderId");
                Order order = OrdersFileHandler.getOrderById(orderId);
                
                if (order != null) {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("/payment-success.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/order/history");
                }
            }
            
            default -> {
                // Unknown action
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        // If no userId in session, use session ID as temporary user ID
        if (userId == null) {
            userId = session.getId();
        }
        
        Order pendingOrder = (Order) session.getAttribute("pendingOrder");
        
        if (pendingOrder == null) {
            response.sendRedirect(request.getContextPath() + "/cart/view");
            return;
        }
        
        String action = request.getParameter("action");
        
        // Using switch for action handling
        switch (action) {
            case "process" -> {
                // Get payment details
                String cardNumber = request.getParameter("cardNumber");
                String expiryDate = request.getParameter("expiryDate");
                String cvv = request.getParameter("cvv");
                String cardholderName = request.getParameter("cardholderName");
                
                // Validate inputs
                if (cardNumber == null || cardNumber.trim().isEmpty() ||
                    expiryDate == null || expiryDate.trim().isEmpty() ||
                    cvv == null || cvv.trim().isEmpty() ||
                    cardholderName == null || cardholderName.trim().isEmpty()) {
                    
                    request.setAttribute("error", "Please fill in all required payment fields");
                    request.setAttribute("order", pendingOrder);
                    request.getRequestDispatcher("/payment.jsp").forward(request, response);
                    return;
                }
                
                // Process payment
                Payment payment = new Payment();
                payment.setOrderId(pendingOrder.getOrderId());
                payment.setUserId(userId);
                payment.setAmount(pendingOrder.getTotalAmount());
                
                boolean paymentSuccess = payment.processCreditCardPayment(
                    cardNumber, expiryDate, cvv, cardholderName);
                
                if (paymentSuccess) {
                    // Save payment
                    PaymentFileHandler.savePayment(payment);
                    
                    // Update order with payment details
                    pendingOrder.setPaymentMethod("Credit Card");
                    pendingOrder.setPaymentId(payment.getPaymentId());
                    pendingOrder.setOrderStatus("Confirmed");
                    
                    // Save order
                    OrdersFileHandler.saveOrder(pendingOrder);
                    
                    // Clear cart and pending order
                    CartManager.clearCart(session, userId);
                    session.removeAttribute("pendingOrder");
                    
                    // Redirect to success page
                    response.sendRedirect(request.getContextPath() + "/payment/success?orderId=" + 
                                         pendingOrder.getOrderId());
                } else {
                    // Payment failed
                    request.setAttribute("error", "Payment processing failed. Please check your card details.");
                    request.setAttribute("order", pendingOrder);
                    request.getRequestDispatcher("/payment.jsp").forward(request, response);
                }
            }
            
            case "cancel" -> {
                // Remove pending order
                session.removeAttribute("pendingOrder");
                
                // Redirect back to checkout
                response.sendRedirect(request.getContextPath() + "/order/checkout");
            }
            
            default -> {
                // Unknown action
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            }
        }
    }
}
