<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History | Food Delivery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .order-card {
            margin-bottom: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .order-header {
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .order-body {
            padding: 20px;
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
        }
        .status-Confirmed {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        .status-Pending {
            background-color: #fff3cd;
            color: #664d03;
        }
        .status-Delivered {
            background-color: #cff4fc;
            color: #055160;
        }
        .status-Cancelled {
            background-color: #f8d7da;
            color: #842029;
        }
        .empty-history {
            text-align: center;
            padding: 40px 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Order History</h1>
            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">
                <i class="bi bi-shop"></i> Browse Restaurants
            </a>
        </div>
        
        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-history">
                    <i class="bi bi-bag" style="font-size: 3rem; color: #6c757d;"></i>
                    <h3 class="mt-3">No Orders Yet</h3>
                    <p class="text-muted">You haven't placed any orders yet. Start ordering some delicious food!</p>
                    <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary mt-3">
                        Browse Restaurants
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">
                        <div class="order-header d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-0">Order #${order.orderId}</h5>
                                <p class="text-muted small mb-0">${order.orderDate}</p>
                            </div>
                            <div>
                                <span class="status-badge status-${order.orderStatus}">${order.orderStatus}</span>
                            </div>
                        </div>
                        <div class="order-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6>${order.restaurantName}</h6>
                                    <div class="mb-3">
                                        <c:forEach var="item" items="${order.items}" varStatus="status">
                                            ${item.quantity}x ${item.name}${!status.last ? ', ' : ''}
                                        </c:forEach>
                                    </div>
                                    <p class="mb-1">
                                        <strong>Delivery Address:</strong> ${order.deliveryAddress}
                                    </p>
                                    <p class="mb-0">
                                        <strong>Total:</strong> $${order.totalAmount}
                                    </p>
                                </div>
                                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                    <a href="${pageContext.request.contextPath}/order/details/${order.orderId}" 
                                       class="btn btn-outline-primary">
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
