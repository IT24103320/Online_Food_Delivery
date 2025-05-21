package com.fooddelivery.servlet;

import com.fooddelivery.model.Restaurant;
import com.fooddelivery.util.FileManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/restaurant")
public class RestaurantServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(RestaurantServlet.class.getName());
    private FileManager restaurantFileManager;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/resources/restaurants.txt");
        restaurantFileManager = new FileManager(filePath);
        LOGGER.info("Initialized RestaurantServlet with file path: " + filePath);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("admin");
            return;
        }

        String action = req.getParameter("action");
        if ("list".equals(action)) {
            try {
                List<String> restaurants = restaurantFileManager.readAllRecords();
                req.setAttribute("restaurants", restaurants);
                req.getRequestDispatcher("/restaurant/list.jsp").forward(req, resp);
            } catch (Exception e) {
                LOGGER.severe("Error listing restaurants: " + e.getMessage());
                req.setAttribute("error", "Failed to load restaurants: " + e.getMessage());
                req.getRequestDispatcher("/restaurant/list.jsp").forward(req, resp);
            }
        } else if ("update".equals(action)) {
            try {
                int restaurantId = Integer.parseInt(req.getParameter("id"));
                List<String> restaurants = restaurantFileManager.readAllRecords();
                for (String restaurant : restaurants) {
                    if (Integer.parseInt(restaurant.split(",")[0]) == restaurantId) {
                        req.setAttribute("restaurant", restaurant);
                        break;
                    }
                }
                req.getRequestDispatcher("/restaurant/update.jsp").forward(req, resp);
            } catch (Exception e) {
                LOGGER.severe("Error loading restaurant for update: " + e.getMessage());
                req.setAttribute("error", "Failed to load restaurant: " + e.getMessage());
                req.getRequestDispatcher("/restaurant/list.jsp").forward(req, resp);
            }
        } else if ("delete".equals(action)) {
            try {
                int idToDelete = Integer.parseInt(req.getParameter("id"));
                List<String> records = restaurantFileManager.readAllRecords();
                List<String> updatedRecords = new ArrayList<>();
                for (String record : records) {
                    if (Integer.parseInt(record.split(",")[0]) != idToDelete) {
                        updatedRecords.add(record);
                    }
                }
                restaurantFileManager.writeAllRecords(updatedRecords);
                resp.sendRedirect("restaurant?action=list");
            } catch (Exception e) {
                LOGGER.severe("Error deleting restaurant: " + e.getMessage());
                req.setAttribute("error", "Failed to delete restaurant: " + e.getMessage());
                req.getRequestDispatcher("/restaurant/list.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("/restaurant/add.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("admin");
            return;
        }

        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String cuisine = req.getParameter("cuisine");
                String ownerId = req.getParameter("ownerId");

                List<String> existingRecords = restaurantFileManager.readAllRecords();
                for (String record : existingRecords) {
                    if (Integer.parseInt(record.split(",")[0]) == id) {
                        req.setAttribute("error", "Restaurant with ID " + id + " already exists.");
                        req.getRequestDispatcher("/restaurant/add.jsp").forward(req, resp);
                        return;
                    }
                }

                Restaurant restaurant = new Restaurant(id, name, address, cuisine, ownerId);
                existingRecords.add(restaurant.toCsv());
                restaurantFileManager.writeAllRecords(existingRecords);
                LOGGER.info("Added new restaurant: ID=" + id + ", Name=" + name);
                resp.sendRedirect("restaurant?action=list");
            } else if ("update".equals(action)) {
                int idToUpdate = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String cuisine = req.getParameter("cuisine");
                String ownerId = req.getParameter("ownerId");

                List<String> records = restaurantFileManager.readAllRecords();
                List<String> updatedRecords = new ArrayList<>();
                for (String record : records) {
                    if (Integer.parseInt(record.split(",")[0]) == idToUpdate) {
                        updatedRecords.add(new Restaurant(idToUpdate, name, address, cuisine, ownerId).toCsv());
                    } else {
                        updatedRecords.add(record);
                    }
                }
                restaurantFileManager.writeAllRecords(updatedRecords);
                LOGGER.info("Updated restaurant: ID=" + idToUpdate);
                resp.sendRedirect("restaurant?action=list");
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing restaurant action: " + action + " - " + e.getMessage());
            req.setAttribute("error", "Failed to process restaurant: " + e.getMessage());
            req.getRequestDispatcher("/restaurant/" + ("add".equals(action) ? "add.jsp" : "update.jsp")).forward(req, resp);
        }
    }
}