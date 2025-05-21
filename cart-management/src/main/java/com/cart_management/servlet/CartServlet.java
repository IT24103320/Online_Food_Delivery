package com.cart_management.servlet;

import com.cart_management.model.Cart;
import com.cart_management.model.CartItem;
import com.cart_management.util.CartManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = "/cart/*")
public class CartServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        // If no userId in session, use session ID as temporary user ID
        if (userId == null) {
            userId = session.getId();
        }
        
        // Get cart from session or create new one
        Cart cart = CartManager.getCart(session, userId);
        request.setAttribute("cart", cart);
        
        String pathInfo = request.getPathInfo();
        
        // View cart
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/view")) {
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
        // Clear cart
        else if (pathInfo.equals("/clear")) {
            cart.clearCart();
            CartManager.saveCart(session, cart);
            response.sendRedirect(request.getContextPath() + "/cart/view");
        }
        // Remove item
        else if (pathInfo.startsWith("/remove/")) {
            try {
                int itemId = Integer.parseInt(pathInfo.substring(8));
                cart.removeItem(itemId);
                CartManager.saveCart(session, cart);
                response.sendRedirect(request.getContextPath() + "/cart/view");
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid item ID");
            }
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
        
        // If no userId in session, use session ID as temporary user ID
        if (userId == null) {
            userId = session.getId();
        }
        
        // Get cart from session or create new one
        Cart cart = CartManager.getCart(session, userId);
        
        String action = request.getParameter("action");
        
        // Add item to cart
        if ("add".equals(action)) {
            try {
                // Get parameters
                int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String specialInstructions = request.getParameter("specialInstructions");
                int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
                String restaurantName = request.getParameter("restaurantName");
                String imagePath = request.getParameter("imagePath");
                
                // Create cart item
                CartItem item = new CartItem(
                    CartManager.generateCartItemId(),
                    menuItemId,
                    name,
                    price,
                    quantity,
                    specialInstructions,
                    restaurantId,
                    restaurantName,
                    imagePath
                );
                
                // Add to cart
                cart.addItem(item);
                CartManager.saveCart(session, cart);
                
                // Redirect to cart view
                response.sendRedirect(request.getContextPath() + "/cart/view");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
            }
        }
        // Update item quantity
        else if ("update".equals(action)) {
            try {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                
                cart.updateItemQuantity(itemId, quantity);
                CartManager.saveCart(session, cart);
                
                response.sendRedirect(request.getContextPath() + "/cart/view");
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
            }
        }
        // Update special instructions
        else if ("updateInstructions".equals(action)) {
            try {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                String instructions = request.getParameter("specialInstructions");
                
                cart.updateItemInstructions(itemId, instructions);
                CartManager.saveCart(session, cart);
                
                response.sendRedirect(request.getContextPath() + "/cart/view");
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
            }
        }
        // Apply promo code
        else if ("applyPromo".equals(action)) {
            String promoCode = request.getParameter("promoCode");
            boolean applied = cart.applyPromoCode(promoCode);
            
            if (!applied) {
                request.setAttribute("promoError", "Invalid promo code");
            }
            
            CartManager.saveCart(session, cart);
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
        // Remove promo code
        else if ("removePromo".equals(action)) {
            cart.removePromoCode();
            CartManager.saveCart(session, cart);
            response.sendRedirect(request.getContextPath() + "/cart/view");
        }
        // Unknown action
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
        }
    }
}
