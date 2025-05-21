package com.fooddelivery.servlet;

import com.fooddelivery.model.Admin;
import com.fooddelivery.util.FileManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private FileManager adminFileManager;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/resources/admins.txt");
        adminFileManager = new FileManager(filePath);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect("index.jsp");
        } else {
            req.getRequestDispatcher("/admin-login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        List<String> admins = adminFileManager.readAllRecords();
        boolean authenticated = false;
        Admin authenticatedAdmin = null;

        for (String adminData : admins) {
            Admin admin = Admin.fromCsv(adminData);
            if (admin.getUsername().equals(username) && admin.getPassword().equals(password)) {
                authenticated = true;
                authenticatedAdmin = admin;
                break;
            }
        }

        if (authenticated) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", authenticatedAdmin);
            resp.sendRedirect("index.jsp");
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("/admin-login.jsp").forward(req, resp);
        }
    }
}