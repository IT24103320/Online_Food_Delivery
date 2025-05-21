package com.project;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.customer;
import service.UserService;

@WebServlet("/adminSearch")
public class  adminSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public adminSearch() {
        super();
    }

    // Handle GET request to show the search form
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to admin dashboard or search form
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
        dispatcher.forward(request, response);
    }

    // Handle POST request to perform the search
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");

        // Create an instance of UserService
        UserService userService = new UserService();

        // Search for users in the file based on the query (search by name or email)
        ArrayList<customer> matchedUsers = userService.searchUsers(searchQuery);

        // Set the search results to be available on the request scope
        request.setAttribute("matchedUsers", matchedUsers);

        // Forward to admin dashboard to display the results
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
