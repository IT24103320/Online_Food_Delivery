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

@WebServlet("/login")
public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public login() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        customer customer = new customer();

        customer.setEmail(request.getParameter("email"));
        customer.setPassword(request.getParameter("password"));

        UserService service = new UserService();

        boolean status = service.validate(customer);

        if (status) {
            customer loggedInCustomer = service.getOne(customer);

            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInCustomer);
            session.setAttribute("role", loggedInCustomer.getRole());

            if ("admin".equalsIgnoreCase(loggedInCustomer.getRole())) {
                response.sendRedirect("home.jsp");
            } else {
                response.sendRedirect("profile.jsp");
            }

        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
