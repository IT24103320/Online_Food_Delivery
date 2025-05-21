<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.order_management.model.Order" %>
<%@ page import="java.util.List" %>

<%
    // Orders list is passed from servlet as request attribute "orders"
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) {
        orders = java.util.Collections.emptyList();
    }

    // For edit mode: order to edit is passed as "editOrder"
    Order editOrder = (Order) request.getAttribute("editOrder");
    // For view mode: order to view is passed as "viewOrder"
    Order viewOrder = (Order) request.getAttribute("viewOrder");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Order Management</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f0f9f4;
            padding: 20px;
        }
        h1 {
            color: #2f855a;
            margin-bottom: 20px;
        }
        .form-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        .table thead {
            background-color: #38a169;
            color: white;
        }
        .nav-tabs .nav-link.active {
            background-color: #38a169;
            color: white;
        }
        .view-section {
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

    <h1>Order Management</h1>

    <!-- Tabs for Add/Edit and View -->
    <ul class="nav nav-tabs mb-4">
        <li class="nav-item">
            <a class="nav-link <%= (viewOrder == null) ? "active" : "" %>" href="#addEdit" data-toggle="tab">
                <%= (editOrder != null) ? "Edit Order" : "Add New Order" %>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <%= (viewOrder != null) ? "active" : "" %>" href="#view" data-toggle="tab">View Order</a>
        </li>
    </ul>

    <div class="tab-content">
        <!-- Add / Edit Form -->
        <div class="tab-pane <%= (viewOrder == null) ? "active" : "" %>" id="addEdit">
            <div class="form-section">
                <h3><%= (editOrder != null) ? "Edit Order" : "Add New Order" %></h3>
                <form method="post" action="orders">
                    <input type="hidden" name="action" value="<%= (editOrder != null) ? "update" : "add" %>" />
                    <div class="form-group">
                        <label for="orderId">Order ID</label>
                        <input
                                type="text"
                                id="orderId"
                                name="orderId"
                                class="form-control"
                                required
                                value="<%= (editOrder != null) ? editOrder.getOrderId() : "" %>"
                                <%= (editOrder != null) ? "readonly" : "" %>
                        />
                    </div>
                    <div class="form-group">
                        <label for="customerName">Customer Name</label>
                        <input
                                type="text"
                                id="customerName"
                                name="customerName"
                                class="form-control"
                                required
                                value="<%= (editOrder != null) ? editOrder.getCustomerName() : "" %>"
                        />
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input
                                type="text"
                                id="address"
                                name="address"
                                class="form-control"
                                required
                                value="<%= (editOrder != null) ? editOrder.getAddress() : "" %>"
                        />
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input
                                type="number"
                                step="0.01"
                                id="price"
                                name="price"
                                class="form-control"
                                required
                                value="<%= (editOrder != null) ? editOrder.getPrice() : "" %>"
                        />
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input
                                type="text"
                                id="phone"
                                name="phone"
                                class="form-control"
                                required
                                value="<%= (editOrder != null) ? editOrder.getPhone() : "" %>"
                        />
                    </div>
                    <button type="submit" class="btn btn-success">
                        <%= (editOrder != null) ? "Update Order" : "Add Order" %>
                    </button>
                    <% if (editOrder != null) { %>
                    <a href="orders" class="btn btn-secondary ml-2">Cancel</a>
                    <% } %>
                </form>
            </div>
        </div>

        <!-- View Order Section -->
        <div class="tab-pane <%= (viewOrder != null) ? "active" : "" %>" id="view">
            <div class="view-section">
                <h3>View Order</h3>
                <form method="get" action="orders">
                    <input type="hidden" name="action" value="view" />
                    <div class="form-group">
                        <label for="viewOrderId">Select Order</label>
                        <select id="viewOrderId" name="orderId" class="form-control" onchange="this.form.submit()">
                            <option value="">-- Select an Order --</option>
                            <% for (Order order : orders) { %>
                            <option value="<%= order.getOrderId() %>"
                                    <%= (viewOrder != null && order.getOrderId().equals(viewOrder.getOrderId())) ? "selected" : "" %>>
                                <%= order.getOrderId() %> - <%= order.getCustomerName() %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                </form>

                <% if (viewOrder != null) { %>
                <div class="mt-4">
                    <h4>Order Details</h4>
                    <p><strong>Order ID:</strong> <%= viewOrder.getOrderId() %></p>
                    <p><strong>Customer Name:</strong> <%= viewOrder.getCustomerName() %></p>
                    <p><strong>Address:</strong> <%= viewOrder.getAddress() %></p>
                    <p><strong>Price:</strong> <%= String.format("%.2f", viewOrder.getPrice()) %></p>
                    <p><strong>Phone:</strong> <%= viewOrder.getPhone() %></p>
                </div>
                <% } else if (!orders.isEmpty()) { %>
                <p class="text-muted">Select an order to view its details.</p>
                <% } else { %>
                <p class="text-muted">No orders available to view.</p>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Orders Table -->
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Customer Name</th>
            <th>Address</th>
            <th>Price</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (orders.isEmpty()) { %>
        <tr>
            <td colspan="6" class="text-center">No orders found.</td>
        </tr>
        <% } else {
            for (Order order : orders) { %>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getCustomerName() %></td>
            <td><%= order.getAddress() %></td>
            <td><%= String.format("%.2f", order.getPrice()) %></td>
            <td><%= order.getPhone() %></td>
            <td>
                <a href="orders?action=edit&orderId=<%= order.getOrderId() %>" class="btn btn-primary btn-sm">Edit</a>
                <a href="orders?action=delete&orderId=<%= order.getOrderId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete order <%= order.getOrderId() %>?');">Delete</a>
                <a href="orders?action=view&orderId=<%= order.getOrderId() %>" class="btn btn-info btn-sm">View</a>
            </td>
        </tr>
        <%  }
        } %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>