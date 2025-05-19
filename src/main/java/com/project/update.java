package com.project;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.customer;
import service.UserService;

@WebServlet("/update")
public class update extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public update() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email"); // key field, readonly in form

        // First, get current user data from session or service (optional)
        HttpSession session = request.getSession();
        customer currentUser = (customer) session.getAttribute("user");

        // Create new customer object with updated values
        customer cust = new customer();
        cust.setEmail(email); // key, must remain unchanged

        cust.setName(request.getParameter("name"));
        cust.setPhone(request.getParameter("phone"));
        cust.setAddress(request.getParameter("address"));
        cust.setCity(request.getParameter("city"));

        String newPassword = request.getParameter("password");
        if (newPassword == null || newPassword.trim().isEmpty()) {
            // Keep old password if new password is empty
            cust.setPassword(currentUser != null ? currentUser.getPassword() : "");
        } else {
            cust.setPassword(newPassword);
        }

        // Role is fixed user since you don't display it in form
        cust.setRole("user");

        UserService service = new UserService();
        service.updateUser(cust);

        // Refresh session user attribute
        session.setAttribute("user", cust);
        session.setAttribute("role", cust.getRole());

        response.sendRedirect("profile.jsp");
    }
}



