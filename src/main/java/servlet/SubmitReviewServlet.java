package servlet;

import dao.ReviewDAO;
import model.Review;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Handle Unicode characters

        String name = request.getParameter("name");
        String message = request.getParameter("message");
        String ratingStr = request.getParameter("rating");

        int rating = 0;
        try {
            rating = Integer.parseInt(ratingStr);
        } catch (NumberFormatException e) {
            rating = 0; // Default rating if parsing fails
        }

        // Validate and save review
        if (name != null && message != null && !name.trim().isEmpty() && !message.trim().isEmpty()) {
            Review review = new Review(name.trim(), message.trim(), rating);
            new ReviewDAO().saveReview(review); // ❌ No context passed — uses absolute path inside DAO
        }

        response.sendRedirect(request.getContextPath() + "/viewReviews");
    }
}
