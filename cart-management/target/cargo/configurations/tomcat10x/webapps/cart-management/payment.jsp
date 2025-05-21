<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment | Food Delivery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .order-summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
        .payment-form {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .credit-card-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .secure-badge {
            background-color: #eaf7ee;
            color: #28a745;
            font-size: 0.8rem;
            padding: 5px 10px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <h1 class="mb-4">Payment</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="row">
            <!-- Payment Form -->
            <div class="col-lg-8">
                <div class="payment-form">
                    <div class="secure-badge">
                        <i class="bi bi-shield-lock me-1"></i> Secure Payment
                    </div>
                    
                    <h4 class="mb-3">Credit Card Information</h4>
                    
                    <form action="${pageContext.request.contextPath}/payment" method="post" id="paymentForm">
                        <input type="hidden" name="action" value="process">
                        
                        <div class="credit-card-box mb-4">
                            <div class="mb-3">
                                <label for="cardholderName" class="form-label">Cardholder Name</label>
                                <input type="text" class="form-control" id="cardholderName" name="cardholderName" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="cardNumber" name="cardNumber" 
                                           placeholder="1234 5678 9012 3456" required maxlength="19">
                                    <span class="input-group-text">
                                        <i class="bi bi-credit-card"></i>
                                    </span>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="expiryDate" class="form-label">Expiry Date</label>
                                    <input type="text" class="form-control" id="expiryDate" name="expiryDate" 
                                           placeholder="MM/YY" required maxlength="5">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="cvv" class="form-label">CVV</label>
                                    <input type="text" class="form-control" id="cvv" name="cvv" 
                                           placeholder="123" required maxlength="4">
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-outline-secondary" 
                                    onclick="window.location.href='${pageContext.request.contextPath}/payment?action=cancel'">
                                <i class="bi bi-arrow-left"></i> Back to Checkout
                            </button>
                            
                            <button type="submit" class="btn btn-primary">
                                Pay $${order.totalAmount} <i class="bi bi-lock"></i>
                            </button>
                        </div>
                    </form>
                </div>
                
                <div class="alert alert-info">
                    <h5><i class="bi bi-info-circle"></i> Demo Mode</h5>
                    <p class="mb-0">This is a demo application. No actual payment will be processed. You can use any valid-format credit card information.</p>
                    <p class="mb-0 mt-2"><strong>Test Card:</strong> 4111 1111 1111 1111, Exp: any future date (MM/YY), CVV: any 3 digits</p>
                </div>
            </div>
            
            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="order-summary">
                    <h4 class="mb-3">Order Summary</h4>
                    <p class="text-muted mb-4">From: ${order.restaurantName}</p>
                    
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
                    
                    <div class="mt-4">
                        <h6>Delivery Information</h6>
                        <p class="mb-1">${order.customerName}</p>
                        <p class="mb-1">${order.customerPhone}</p>
                        <p class="mb-0">${order.deliveryAddress}</p>
                    </div>
                    
                    <div class="mt-4">
                        <h6>Estimated Delivery Time</h6>
                        <p class="text-muted">30-45 minutes after payment confirmation</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Credit card number formatting
        document.getElementById('cardNumber').addEventListener('input', function (e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = '';
            
            for (let i = 0; i < value.length; i++) {
                if (i > 0 && i % 4 === 0) {
                    formattedValue += ' ';
                }
                formattedValue += value[i];
            }
            
            e.target.value = formattedValue;
        });
        
        // Expiry date formatting
        document.getElementById('expiryDate').addEventListener('input', function (e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 2) {
                e.target.value = value.substring(0, 2) + '/' + value.substring(2, 4);
            } else {
                e.target.value = value;
            }
        });
        
        // CVV validation - numbers only
        document.getElementById('cvv').addEventListener('input', function (e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
    </script>
</body>
</html>
