package com.project;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.customer;
import service.UserService;

@WebServlet("/delete")
public class delete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public delete() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (request.getParameter("email") != null) {
            UserService service = new UserService();
            service.deleteUserByEmail(request.getParameter("email"));

            ArrayList<customer> user = service.getAllUser();
            request.setAttribute("allUser", user);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } else {
            response.sendRedirect("profile.jsp"); // Redirect to profile if email not found in session
        }
    }
}

