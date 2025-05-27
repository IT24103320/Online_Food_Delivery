package com.order_management.servlet;

import com.order_management.model.Order;
import com.order_management.util.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        // Set the file path for order data storage inside WEB-INF to avoid direct web access
        String filePath = getServletContext().getRealPath("/WEB-INF/orders.txt");
        FileHandler.setFilePath(filePath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equalsIgnoreCase(action)) {
            String orderId = request.getParameter("orderId");
            Order order = FileHandler.getOrderById(orderId);
            if (order != null) {
                request.setAttribute("editOrder", order);
            }
            // Also set the full list for table display
            request.setAttribute("orders", FileHandler.getAllOrders());
            request.getRequestDispatcher("/order.jsp").forward(request, response);

        } else if ("delete".equalsIgnoreCase(action)) {
            String orderId = request.getParameter("orderId");
            if (orderId != null && !orderId.trim().isEmpty()) {
                FileHandler.deleteOrder(orderId);
            }
            response.sendRedirect("orders"); // Redirect to avoid resubmission

        } else if ("view".equalsIgnoreCase(action)) {
            String orderId = request.getParameter("orderId");
            Order order = FileHandler.getOrderById(orderId);
            request.setAttribute("viewOrder", order);
            request.setAttribute("orders", FileHandler.getAllOrders());
            request.getRequestDispatcher("/order.jsp").forward(request, response);

        } else {
            // Default: show list
            List<Order> orders = FileHandler.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/order.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            Order newOrder = extractOrderFromRequest(request);
            if (newOrder != null) {
                FileHandler.addOrder(newOrder);
            }
            response.sendRedirect("orders");

        } else if ("update".equalsIgnoreCase(action)) {
            Order updatedOrder = extractOrderFromRequest(request);
            if (updatedOrder != null) {
                FileHandler.updateOrder(updatedOrder);
            }
            response.sendRedirect("orders");

        } else {
            // Unknown action or no action, redirect to list
            response.sendRedirect("orders");
        }
    }

    private Order extractOrderFromRequest(HttpServletRequest request) {
        try {
            String orderId = request.getParameter("orderId").trim();
            String customerName = request.getParameter("customerName").trim();
            String address = request.getParameter("address").trim();
            double price = Double.parseDouble(request.getParameter("price").trim());
            String phone = request.getParameter("phone").trim();

            // Basic validation
            if (orderId.isEmpty() || customerName.isEmpty() || address.isEmpty() || phone.isEmpty()) {
                return null;
            }

            return new Order(orderId, customerName, address, price, phone);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}