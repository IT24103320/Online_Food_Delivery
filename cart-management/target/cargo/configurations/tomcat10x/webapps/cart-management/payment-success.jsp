<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful | Food Delivery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .success-box {
            text-align: center;
            padding: 40px 20px;
            border-radius: 10px;
            background-color: #f8f9fa;
            margin-bottom: 30px;
        }
        .success-icon {
            font-size: 3rem;
            color: #28a745;
            margin-bottom: 20px;
        }
        .order-details {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .map-placeholder {
            background-color: #e9ecef;
            height: 200px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="success-box">
            <div class="success-icon">
                <i class="bi bi-check-circle-fill"></i>
            </div>
            <h1 class="mb-3">Payment Successful!</h1>
            <p class="lead mb-0">Your order has been placed successfully.</p>
            <p class="mb-4">Order ID: ${order.orderId}</p>
            <div class="d-flex justify-content-center">
                <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-primary me-2">
                    View Order History
                </a>
                <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">
                    Continue Shopping
                </a>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-8">
                <div class="order-details">
                    <h4 class="mb-3">Order Details</h4>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.items}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div>
                                                    <h6 class="mb-0">${item.name}</h6>
                                                    <c:if test="${not empty item.specialInstructions}">
                                                        <small class="text-muted">Note: ${item.specialInstructions}</small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${item.quantity}</td>
                                        <td>$${item.price}</td>
                                        <td>$${item.subtotal}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <h5>Delivery Information</h5>
                            <p class="mb-1"><strong>Name:</strong> ${order.customerName}</p>
                            <p class="mb-1"><strong>Phone:</strong> ${order.customerPhone}</p>
                            <p class="mb-3"><strong>Address:</strong> ${order.deliveryAddress}</p>
                            
                            <h5>Order Information</h5>
                            <p class="mb-1"><strong>Restaurant:</strong> ${order.restaurantName}</p>
                            <p class="mb-1"><strong>Order Date:</strong> ${order.orderDate}</p>
                            <p class="mb-0"><strong>Estimated Delivery By:</strong> ${order.estimatedDeliveryTime}</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Payment Summary</h5>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Subtotal</span>
                                <span>$${order.subtotal}</span>
                            </div>
                            <c:if test="${order.discount > 0}">
                                <div class="d-flex justify-content-between mb-2 text-success">
                                    <span>Discount</span>
                                    <span>-$${order.discount}</span>
                                </div>
                            </c:if>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Delivery Fee</span>
                                <span>$${order.deliveryFee}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tax</span>
                                <span>$${order.tax}</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-2 fw-bold">
                                <span>Total</span>
                                <span>$${order.totalAmount}</span>
                            </div>
                            <div class="mt-3 text-muted">
                                <p class="mb-0"><small>Payment Method: Credit Card</small></p>
                                <p class="mb-0"><small>Status: ${order.orderStatus}</small></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="map-placeholder">
                    <div class="text-center">
                        <i class="bi bi-map" style="font-size: 2rem; color: #6c757d;"></i>
                        <p class="mb-0 mt-2">Delivery Tracking Map</p>
                        <p class="text-muted small">(Coming Soon)</p>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Order Status</h5>
                        <div class="d-flex flex-column">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-success rounded-circle me-3" style="width: 10px; height: 10px;"></div>
                                <div>
                                    <p class="mb-0 fw-bold">Order Confirmed</p>
                                    <p class="text-muted small mb-0">${order.orderDate}</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-warning rounded-circle me-3" style="width: 10px; height: 10px;"></div>
                                <div>
                                    <p class="mb-0">Preparing Your Food</p>
                                    <p class="text-muted small mb-0">In progress</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-secondary rounded-circle me-3" style="width: 10px; height: 10px;"></div>
                                <div>
                                    <p class="mb-0">On the Way</p>
                                    <p class="text-muted small mb-0">Coming soon</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="bg-secondary rounded-circle me-3" style="width: 10px; height: 10px;"></div>
                                <div>
                                    <p class="mb-0">Delivered</p>
                                    <p class="text-muted small mb-0">Estimated by ${order.estimatedDeliveryTime}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
