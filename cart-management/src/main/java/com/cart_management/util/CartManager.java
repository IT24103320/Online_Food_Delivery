package com.cart_management.util;

import com.cart_management.model.Cart;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class CartManager {
    // Session attribute name for the cart
    private static final String CART_SESSION_ATTR = "userCart";
    
    // Static store to simulate cart persistence (would typically be a database or Redis in production)
    private static final Map<String, Cart> cartStore = new HashMap<>();
    
    // Get cart from session, creating one if it doesn't exist
    public static Cart getCart(HttpSession session, String userId) {
        // First check the session
        Cart cart = (Cart) session.getAttribute(CART_SESSION_ATTR);
        
        // If not in session, check the store
        if (cart == null) {
            cart = cartStore.get(userId);
            
            // If still not found, create a new cart
            if (cart == null) {
                cart = new Cart(userId);
            }
            
            // Store in session
            session.setAttribute(CART_SESSION_ATTR, cart);
        }
        
        return cart;
    }
    
    // Save cart to session and store
    public static void saveCart(HttpSession session, Cart cart) {
        session.setAttribute(CART_SESSION_ATTR, cart);
        cartStore.put(cart.getUserId(), cart);
    }
    
    // Clear a user's cart from both session and store
    public static void clearCart(HttpSession session, String userId) {
        session.removeAttribute(CART_SESSION_ATTR);
        cartStore.remove(userId);
    }
    
    // Generate a unique identifier for cart items
    public static int generateCartItemId() {
        return (int) (System.currentTimeMillis() % Integer.MAX_VALUE);
    }
    
    // Calculate estimated delivery time (30-45 minutes)
    public static String calculateEstimatedDeliveryTime() {
        // In a real system, this would consider factors like distance, restaurant load, etc.
        return "30-45 minutes";
    }
}
