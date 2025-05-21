<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.order_management.model.Order" %>
<%
  Order nextOrder = (Order) request.getAttribute("nextOrder");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>View Order</title>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f0f9f4;
      padding: 20px;
    }
    h1 {
      color: #2f855a;
      margin-bottom: 20px;
    }
    .order-section {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
      margin-bottom: 40px;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>View Next Order</h1>
  <div class="order-section">
    <% if (nextOrder == null) { %>
    <p class="text-center text-gray-700">No orders in the queue.</p>
    <% } else { %>
    <h3>Order Details</h3>
    <table class="table table-bordered">
      <tr>
        <th>Order ID</th>
        <td><%= nextOrder.getOrderId() %></td>
      </tr>
      <tr>
        <th>Customer Name</th>
        <td><%= nextOrder.getCustomerName() %></td>
      </tr>
      <tr>
        <th>Address</th>
        <td><%= nextOrder.getAddress() %></td>
      </tr>
      <tr>
        <th>Price</th>
        <td><%= String.format("%.2f", nextOrder.getPrice()) %></td>
      </tr>
      <tr>
        <th>Phone</th>
        <td><%= nextOrder.getPhone() %></td>
      </tr>
    </table>
    <% } %>
    <a href="index.jsp" class="btn btn-secondary mt-3">Back to Home</a>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>