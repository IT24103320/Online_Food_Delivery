<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | Food Delivery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .order-summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
        .form-section {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <h1 class="mb-4">Checkout</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="row">
            <!-- Delivery Details Form -->
            <div class="col-lg-8">
                <form action="${pageContext.request.contextPath}/order" method="post">
                    <input type="hidden" name="action" value="confirm">
                    
                    <div class="form-section mb-4">
                        <h4 class="mb-3">Delivery Address</h4>
                        <div class="mb-3">
                            <label for="customerName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="customerName" name="customerName" required>
                        </div>
                        <div class="mb-3">
                            <label for="customerPhone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="customerPhone" name="customerPhone" required>
                        </div>
                        <div class="mb-3">
                            <label for="deliveryAddress" class="form-label">Delivery Address</label>
                            <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" rows="3" required></textarea>
                        </div>
                    </div>
                    
                    <div class="form-section mb-4">
                        <h4 class="mb-3">Order Items</h4>
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
                                    <c:forEach var="item" items="${cart.items}">
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
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Back to Cart
                        </a>
                        <button type="submit" class="btn btn-primary">
                            Proceed to Payment <i class="bi bi-arrow-right"></i>
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="order-summary">
                    <h4 class="mb-3">Order Summary</h4>
                    <p class="text-muted mb-4">From: ${cart.restaurantName}</p>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal</span>
                        <span>$${cart.subtotal}</span>
                    </div>
                    <c:if test="${cart.discountAmount > 0}">
                        <div class="d-flex justify-content-between mb-2 text-success">
                            <span>Discount</span>
                            <span>-$${cart.discountAmount}</span>
                        </div>
                    </c:if>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Delivery Fee</span>
                        <span>$${cart.deliveryFee}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tax</span>
                        <span>$${cart.taxAmount}</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-2 fw-bold">
                        <span>Total</span>
                        <span>$${cart.totalAmount}</span>
                    </div>
                    
                    <div class="mt-4">
                        <h6>Estimated Delivery Time</h6>
                        <p class="text-muted">30-45 minutes after order confirmation</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
