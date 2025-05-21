package servlet;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ViewReviewsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReviewDAO dao = new ReviewDAO(); // ❌ No ServletContext needed
        List<Review> reviews = dao.getAllReviews();

        request.setAttribute("reviews", reviews);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewReviews.jsp");
        dispatcher.forward(request, response);
    }
}
