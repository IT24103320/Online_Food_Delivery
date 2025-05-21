package servlet;

import dao.ReviewDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int index = Integer.parseInt(request.getParameter("index"));

        ReviewDAO dao = new ReviewDAO(); // No context needed
        dao.deleteReview(index);

        response.sendRedirect(request.getContextPath() + "/viewReviews");
    }
}
