package com.fooddelivery.servlet;

import com.fooddelivery.model.MenuItem;
import com.fooddelivery.util.FileManager;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(MenuServlet.class.getName());
    private FileManager menuFileManager;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/resources/menus.txt");
        menuFileManager = new FileManager(filePath);
        LOGGER.info("Initialized MenuServlet with file path: " + filePath);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("admin");
            return;
        }

        String action = req.getParameter("action");
        try {
            if ("list".equals(action)) {
                List<String> menuItems = menuFileManager.readAllRecords();
                req.setAttribute("menuItems", menuItems);
                req.getRequestDispatcher("/menu/list.jsp").forward(req, resp);
            } else if ("edit".equals(action)) {
                int itemId = Integer.parseInt(req.getParameter("id"));
                List<String> menuItems = menuFileManager.readAllRecords();
                for (String item : menuItems) {
                    if (Integer.parseInt(item.split(",")[0]) == itemId) {
                        req.setAttribute("menuItem", item);
                        break;
                    }
                }
                req.getRequestDispatcher("/menu/edit.jsp").forward(req, resp);
            } else if ("delete".equals(action)) {
                int idToDelete = Integer.parseInt(req.getParameter("id"));
                List<String> records = menuFileManager.readAllRecords();
                List<String> updatedRecords = new ArrayList<>();
                for (String record : records) {
                    if (Integer.parseInt(record.split(",")[0]) != idToDelete) {
                        updatedRecords.add(record);
                    }
                }
                menuFileManager.writeAllRecords(updatedRecords);
                LOGGER.info("Deleted menu item: ID=" + idToDelete);
                resp.sendRedirect("menu?action=list");
            } else {
                req.getRequestDispatcher("/menu/add.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            LOGGER.severe("Error processing menu GET action: " + action + " - " + e.getMessage());
            req.setAttribute("error", "Failed to process request: " + e.getMessage());
            req.getRequestDispatcher("/menu/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            resp.sendRedirect("admin");
            return;
        }

        String action = null;
        if (ServletFileUpload.isMultipartContent(req)) {
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(req);
                int id = -1;
                String name = "";
                int restaurantId = -1;
                double price = 0.0;
                String description = "";
                String imagePath = null;

                // Parse form fields
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String value = item.getString();
                        switch (fieldName) {
                            case "action":
                                action = value;
                                break;
                            case "id":
                                id = Integer.parseInt(value);
                                break;
                            case "name":
                                name = value;
                                break;
                            case "restaurantId":
                                restaurantId = Integer.parseInt(value);
                                break;
                            case "price":
                                price = Double.parseDouble(value);
                                break;
                            case "description":
                                description = value;
                                break;
                        }
                    } else if (!item.isFormField() && item.getName() != null && !item.getName().isEmpty()) {
                        String uniqueImagePath = MenuItem.generateUniqueImagePath(item.getName());
                        File uploadedFile = new File(getServletContext().getRealPath("/"), uniqueImagePath);
                        File parentDir = uploadedFile.getParentFile();
                        if (!parentDir.exists()) {
                            parentDir.mkdirs();
                            LOGGER.info("Created directory for image: " + parentDir);
                        }
                        item.write(uploadedFile);
                        imagePath = uniqueImagePath;
                        LOGGER.info("Uploaded image to: " + uniqueImagePath);
                    }
                }

                // Validate action
                if (action == null) {
                    throw new IllegalArgumentException("Action parameter is missing in the form data.");
                }

                if ("add".equals(action)) {
                    List<String> existingRecords = menuFileManager.readAllRecords();
                    for (String record : existingRecords) {
                        if (Integer.parseInt(record.split(",")[0]) == id) {
                            req.setAttribute("error", "Menu item with ID " + id + " already exists.");
                            req.getRequestDispatcher("/menu/add.jsp").forward(req, resp);
                            return;
                        }
                    }

                    if (imagePath == null) {
                        imagePath = "images/default.jpg";
                    }
                    MenuItem menuItem = new MenuItem(id, name, restaurantId, price, description, imagePath);
                    existingRecords.add(menuItem.toCsv());
                    menuFileManager.writeAllRecords(existingRecords);
                    LOGGER.info("Added new menu item: ID=" + id + ", Name=" + name);
                    resp.sendRedirect("menu?action=list");
                } else if ("update".equals(action)) {
                    int idToUpdate = id;
                    int restaurantIdToUpdate = restaurantId;
                    List<String> records = menuFileManager.readAllRecords();
                    List<String> updatedRecords = new ArrayList<>();
                    for (String record : records) {
                        if (Integer.parseInt(record.split(",")[0]) == idToUpdate) {
                            updatedRecords.add(new MenuItem(idToUpdate, name, restaurantIdToUpdate, price, description, imagePath != null ? imagePath : record.split(",")[5]).toCsv());
                        } else {
                            updatedRecords.add(record);
                        }
                    }
                    menuFileManager.writeAllRecords(updatedRecords);
                    LOGGER.info("Updated menu item: ID=" + idToUpdate);
                    resp.sendRedirect("menu?action=list");
                }
            } catch (Exception e) {
                LOGGER.severe("Error processing menu POST action: " + (action != null ? action : "unknown") + " - " + e.getMessage());
                req.setAttribute("error", "Failed to process menu item: " + e.getMessage());
                req.getRequestDispatcher("/menu/" + ("add".equals(action) ? "add.jsp" : "edit.jsp")).forward(req, resp);
            }
        } else {
            action = req.getParameter("action"); // Fallback for non-multipart requests
            if (action == null) {
                req.setAttribute("error", "Action parameter is missing and request is not multipart.");
                req.getRequestDispatcher("/menu/add.jsp").forward(req, resp);
            } else if ("add".equals(action) || "update".equals(action)) {
                req.setAttribute("error", "Form must be submitted with multipart/form-data for file uploads.");
                req.getRequestDispatcher("/menu/" + ("add".equals(action) ? "add.jsp" : "edit.jsp")).forward(req, resp);
            }
        }
    }
}