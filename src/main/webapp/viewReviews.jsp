<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Review" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Reviews</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #f0f8ff, #e6f7ff);
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px #ccc;
            background-color: #fff;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3399ff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        form {
            margin: 0;
        }

        input[type="submit"] {
            padding: 6px 10px;
            background-color: #ff4d4d;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #cc0000;
        }

        nav {
            text-align: center;
            margin-bottom: 20px;
        }

        nav a {
            margin: 0 15px;
            text-decoration: none;
            color: #3399ff;
            font-weight: bold;
        }

        nav a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<nav>
    <a href="index.jsp">Home</a>
    <a href="submitReview.jsp">Submit Review</a>
</nav>

<h2>All Reviews</h2>

<%
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    if (reviews == null || reviews.isEmpty()) {
%>
<p style="text-align: center; color: #777;">No reviews submitted yet.</p>
<%
} else {
%>
<table>
    <tr>
        <th>Name</th>
        <th>Rating</th>
        <th>Message</th>
        <th>Action</th>
    </tr>
    <%
        for (int i = 0; i < reviews.size(); i++) {
            Review review = reviews.get(i);
    %>
    <tr>
        <td><%= review.getName() %></td>
        <td><%= review.getRating() %></td>
        <td><%= review.getMessage() %></td>
        <td>
            <form method="post" action="deleteReview">
                <input type="hidden" name="index" value="<%= i %>">
                <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this review?');">
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>
<%
    }
%>

</body>
</html>
