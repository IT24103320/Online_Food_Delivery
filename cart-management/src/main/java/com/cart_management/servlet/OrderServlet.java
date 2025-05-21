package com.cart_management.servlet;

import com.cart_management.model.Cart;
import com.cart_management.model.Order;
import com.cart_management.util.CartManager;
import com.cart_management.util.OrdersFileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/order/*")
public class OrderServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        // Initialize file handlers
        String contextPath = getServletContext().getRealPath("/");
        OrdersFileHandler.initFilePaths(contextPath);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        // If no userId in session, use session ID as temporary user ID
        if (userId == null) {
            userId = session.getId();
        }
        
        String pathInfo = request.getPathInfo();
        
        // View order history
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/history")) {
            List<Order> userOrders = OrdersFileHandler.getUserOrders(userId);
            request.setAttribute("orders", userOrders);
            request.getRequestDispatcher("/order-history.jsp").forward(request, response);
        }
        // View order details
        else if (pathInfo.startsWith("/details/")) {
            String orderId = pathInfo.substring(9);
            Order order = OrdersFileHandler.getOrderById(orderId);
            
            if (order != null && order.getUserId().equals(userId)) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/order-details.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            }
        }
        // Checkout page
        else if (pathInfo.equals("/checkout")) {
            Cart cart = CartManager.getCart(session, userId);
            
            if (cart.getItems().isEmpty()) {
                // Redirect to cart if empty
                response.sendRedirect(request.getContextPath() + "/cart/view");
                return;
            }
            
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
        // Unknown action
        else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action required");
            return;
        }
        
        switch (action) {
            case "confirm" -> {
                // Get cart
                Cart cart = CartManager.getCart(session, userId);
                if (cart == null || cart.getItems().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/cart/view");
                    return;
                }
                
                // Get delivery information
                String deliveryAddress = request.getParameter("deliveryAddress");
                String customerName = request.getParameter("customerName");
                String customerPhone = request.getParameter("customerPhone");
                
                // Validate inputs
                if (deliveryAddress == null || deliveryAddress.trim().isEmpty() ||
                    customerName == null || customerName.trim().isEmpty() ||
                    customerPhone == null || customerPhone.trim().isEmpty()) {
                    
                    request.setAttribute("error", "Please fill in all required fields");
                    request.setAttribute("cart", cart);
                    request.getRequestDispatcher("/checkout.jsp").forward(request, response);
                    return;
                }
                
                // Create order from cart
                Order order = new Order();
                order.setUserId(userId);
                order.setItems(cart.getItems());
                order.setSubtotal(cart.getSubtotal());
                order.setDeliveryFee(cart.getDeliveryFee());
                order.setTax(cart.getTaxAmount());
                order.setDiscount(cart.getDiscountAmount());
                order.setTotalAmount(cart.getTotalAmount());
                order.setDeliveryAddress(deliveryAddress);
                order.setCustomerName(customerName);
                order.setCustomerPhone(customerPhone);
                if (cart.getPromoCode() != null && !cart.getPromoCode().isEmpty()) {
                    order.setPromoCode(cart.getPromoCode());
                }
                
                // Store order in session for payment processing
                session.setAttribute("pendingOrder", order);
                
                // Redirect to payment page
                response.sendRedirect(request.getContextPath() + "/payment");
            }
            case "cancel" -> {
                // Remove pending order from session
                session.removeAttribute("pendingOrder");
                
                // Redirect back to cart
                response.sendRedirect(request.getContextPath() + "/cart/view");
            }
            default -> {
                // Unknown action
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
            }
        }
    }
}
