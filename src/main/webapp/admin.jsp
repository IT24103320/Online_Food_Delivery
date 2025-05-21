<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Dash - Admin Dashboard</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

<!-- Admin Dashboard Section -->
<section class="max-w-screen-xl mx-auto py-16 px-6">
    <h2 class="text-4xl font-semibold text-center text-green-700 mb-6">Admin Dashboard</h2>
    <p class="text-center text-lg text-gray-600 mb-12">Manage all users of Food Dash</p>

    <!-- Search Form -->
    <div class="flex justify-center mb-6">
        <form action="searchUsers" method="get" class="flex space-x-4">
            <input type="text" name="search" placeholder="Search by name or email" class="w-80 p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500">
            <button type="submit" class="w-24 bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-search"></i> Search
            </button>
        </form>
    </div>

    <!-- Users Table -->
    <div class="overflow-x-auto bg-white p-8 rounded-lg shadow-lg">
        <table class="table table-striped table-bordered w-full">
            <thead>
            <tr class="bg-green-700 text-white">
                <th class="px-4 py-2">#</th>
                <th class="px-4 py-2">Full Name</th>
                <th class="px-4 py-2">Email</th>
                <th class="px-4 py-2">Phone Number</th>
                <th class="px-4 py-2">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cus" items="${allUser}" varStatus="status">
            <tr>
                <td class="px-4 py-2 text-center">${status.index + 1}</td>
                <td class="px-4 py-2">${cus.name}</td>
                <td class="px-4 py-2">${cus.email}</td>
                <td class="px-4 py-2">${cus.phone}</td>
                <td class="px-4 py-2 text-center">
                <form action="delete" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                    <input type="hidden" name="email" value="${cus.email}" />
                    <button class="action-btn delete" title="Delete User">
                <i class="fas fa-trash-alt"></i>
                </button>
                </form>
                </td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<!-- Bootstrap JS (for interactive components like modals, dropdowns, etc.) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<!-- Custom JavaScript to handle delete action -->
<script>
    function deleteUser(userId) {
        if (confirm('Are you sure you want to delete this user?')) {
            // Replace with actual backend logic to delete the user
            alert('User ' + userId + ' deleted');
        }
    }
</script>

</body>
</html>
