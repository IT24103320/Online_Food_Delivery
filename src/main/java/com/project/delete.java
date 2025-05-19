package com.project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.UserService;

@WebServlet("/delete")
public class delete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public delete() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the email from the current session
        HttpSession session = request.getSession();
        String email = ((String) session.getAttribute("email")); // assuming the email is stored in session

        if (email != null) {
            UserService service = new UserService();
            service.deleteUserByEmail(email); // delete the user by email

            // Invalidate session after deletion
            session.invalidate();

            // Redirect to login page after deletion
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("profile.jsp"); // Redirect to profile if email not found in session
        }
    }
}

