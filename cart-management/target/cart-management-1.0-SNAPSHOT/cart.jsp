<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart | Food Delivery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .cart-item-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-control button {
            width: 32px;
            height: 32px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .quantity-control input {
            width: 50px;
            text-align: center;
        }
        .promo-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .cart-summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <h1 class="mb-4">Your Cart</h1>
        
        <c:choose>
            <c:when test="${empty cart.items}">
                <div class="alert alert-info">
                    <h4>Your cart is empty</h4>
                    <p>Explore our restaurants and add some delicious food to your cart!</p>
                    <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">Browse Restaurants</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Items from ${cart.restaurantName}</h5>
                                <a href="${pageContext.request.contextPath}/cart/clear" class="btn btn-outline-danger btn-sm">
                                    <i class="bi bi-trash"></i> Clear Cart
                                </a>
                            </div>
                            <div class="card-body">
                                <c:forEach var="item" items="${cart.items}">
                                    <div class="row mb-3 border-bottom pb-3">
                                        <!-- Item image -->
                                        <div class="col-md-2 text-center">
                                            <img src="${pageContext.request.contextPath}/${item.imagePath}" alt="${item.name}" class="cart-item-img">
                                        </div>
                                        
                                        <!-- Item details -->
                                        <div class="col-md-6">
                                            <h5>${item.name}</h5>
                                            <p class="text-muted">$${item.price}</p>
                                            
                                            <!-- Special instructions -->
                                            <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-2">
                                                <input type="hidden" name="action" value="updateInstructions">
                                                <input type="hidden" name="itemId" value="${item.id}">
                                                <div class="mb-2">
                                                    <input type="text" name="specialInstructions" class="form-control form-control-sm" 
                                                           placeholder="Special instructions" value="${item.specialInstructions}">
                                                </div>
                                                <button type="submit" class="btn btn-sm btn-outline-secondary">Update</button>
                                            </form>
                                        </div>
                                        
                                        <!-- Quantity controls -->
                                        <div class="col-md-2">
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="itemId" value="${item.id}">
                                                <div class="quantity-control">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                            onclick="updateQuantity(this.form, -1)">
                                                        <i class="bi bi-dash"></i>
                                                    </button>
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" 
                                                           class="form-control mx-2" onchange="this.form.submit()">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                            onclick="updateQuantity(this.form, 1)">
                                                        <i class="bi bi-plus"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                        
                                        <!-- Item total and remove -->
                                        <div class="col-md-2 text-end">
                                            <p class="fw-bold">$${item.subtotal}</p>
                                            <a href="${pageContext.request.contextPath}/cart/remove/${item.id}" 
                                               class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-trash"></i> Remove
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Promo Code Section -->
                        <div class="promo-section">
                            <h5>Promo Code</h5>
                            <c:choose>
                                <c:when test="${empty cart.promoCode}">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="row g-2">
                                        <input type="hidden" name="action" value="applyPromo">
                                        <div class="col-auto">
                                            <input type="text" name="promoCode" class="form-control" placeholder="Enter promo code">
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-primary">Apply</button>
                                        </div>
                                    </form>
                                    <c:if test="${not empty promoError}">
                                        <div class="text-danger mt-2">${promoError}</div>
                                    </c:if>
                                    <div class="mt-2 text-muted small">
                                        <p>Available codes: WELCOME10 (10% off), SUMMER20 (20% off), FREESHIP (Free delivery)</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-success">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong>Code applied:</strong> ${cart.promoCode}
                                                <c:choose>
                                                    <c:when test="${cart.promoCode eq 'FREESHIP'}">  
                                                        <p class="mb-0 small">Free delivery applied!</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="mb-0 small">${cart.discount * 100}% discount applied!</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="removePromo">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">Remove</button>
                                            </form>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="cart-summary">
                            <h4 class="mb-4">Order Summary</h4>
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
                            <div class="d-flex justify-content-between mb-4 fw-bold">
                                <span>Total</span>
                                <span>$${cart.totalAmount}</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/order/checkout" class="btn btn-primary w-100">
                                Proceed to Checkout
                            </a>
                            <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-outline-secondary w-100 mt-2">
                                Continue Shopping
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateQuantity(form, change) {
            const quantityInput = form.querySelector('input[name="quantity"]');
            let newQuantity = parseInt(quantityInput.value) + change;
            if (newQuantity >= 1) {
                quantityInput.value = newQuantity;
                form.submit();
            }
        }
    </script>
</body>
</html>
