<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Cart Management Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .restaurant-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
            height: 100%;
        }
        .restaurant-card:hover {
            transform: translateY(-5px);
        }
        .menu-item-card {
            margin-bottom: 20px;
            height: 100%;
        }
        .menu-item-img {
            height: 200px;
            object-fit: cover;
        }
        .section-title {
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <header class="mb-5">
            <div class="d-flex justify-content-between align-items-center">
                <h1>Food Delivery - Cart Management Demo</h1>
                <div>
                    <a href="${pageContext.request.contextPath}/cart/view" class="btn btn-outline-primary me-2">
                        <i class="bi bi-cart"></i> View Cart
                    </a>
                    <a href="${pageContext.request.contextPath}/order/history" class="btn btn-outline-secondary">
                        <i class="bi bi-clock-history"></i> Order History
                    </a>
                </div>
            </div>
            <p class="lead text-muted">
                This is a demo for the cart management component. You can add items to your cart, manage quantities, 
                apply promo codes, and checkout with simulated payment processing.
            </p>
        </header>
        
        <h2 class="section-title">Sample Restaurant</h2>
        <div class="card restaurant-card">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" 
                         class="img-fluid rounded-start" alt="Restaurant" style="height: 100%; object-fit: cover;">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h3 class="card-title">Italian Delights</h3>
                        <p class="card-text"><i class="bi bi-geo-alt"></i> 123 Main Street, Your City</p>
                        <p class="card-text"><i class="bi bi-clock"></i> Open: 10:00 AM - 10:00 PM</p>
                        <p class="card-text">Authentic Italian cuisine with a modern twist. Enjoy our hand-crafted pastas, wood-fired pizzas, and delectable desserts.</p>
                        <div>
                            <span class="badge bg-success me-2">Free Delivery</span>
                            <span class="badge bg-info me-2">4.8 ★</span>
                            <span class="badge bg-secondary">30-45 min</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <h2 class="section-title mt-5">Menu Items</h2>
        <div class="row">
            <!-- Menu Item 1 -->
            <div class="col-md-4">
                <div class="card menu-item-card">
                    <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1014&q=80" 
                         class="card-img-top menu-item-img" alt="Margherita Pizza">
                    <div class="card-body">
                        <h5 class="card-title">Margherita Pizza</h5>
                        <p class="card-text">Classic pizza with tomato sauce, mozzarella, fresh basil, salt, and olive oil.</p>
                        <p class="fw-bold">$12.99</p>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="menuItemId" value="1">
                            <input type="hidden" name="name" value="Margherita Pizza">
                            <input type="hidden" name="price" value="12.99">
                            <input type="hidden" name="restaurantId" value="1">
                            <input type="hidden" name="restaurantName" value="Italian Delights">
                            <input type="hidden" name="imagePath" value="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1014&q=80">
                            <div class="d-flex">
                                <select name="quantity" class="form-select me-2" style="width: auto;">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                </button>
                            </div>
                            <div class="mt-2">
                                <input type="text" name="specialInstructions" class="form-control" placeholder="Special instructions">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Menu Item 2 -->
            <div class="col-md-4">
                <div class="card menu-item-card">
                    <img src="https://images.unsplash.com/photo-1597131628347-cea5f2e50d67?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" 
                         class="card-img-top menu-item-img" alt="Fettuccine Alfredo">
                    <div class="card-body">
                        <h5 class="card-title">Fettuccine Alfredo</h5>
                        <p class="card-text">Creamy pasta dish made with fettuccine tossed with butter and Parmesan cheese.</p>
                        <p class="fw-bold">$14.99</p>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="menuItemId" value="2">
                            <input type="hidden" name="name" value="Fettuccine Alfredo">
                            <input type="hidden" name="price" value="14.99">
                            <input type="hidden" name="restaurantId" value="1">
                            <input type="hidden" name="restaurantName" value="Italian Delights">
                            <input type="hidden" name="imagePath" value="https://images.unsplash.com/photo-1597131628347-cea5f2e50d67?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80">
                            <div class="d-flex">
                                <select name="quantity" class="form-select me-2" style="width: auto;">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                </button>
                            </div>
                            <div class="mt-2">
                                <input type="text" name="specialInstructions" class="form-control" placeholder="Special instructions">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Menu Item 3 -->
            <div class="col-md-4">
                <div class="card menu-item-card">
                    <img src="https://images.unsplash.com/photo-1607920592519-eca3ae505473?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80" 
                         class="card-img-top menu-item-img" alt="Tiramisu">
                    <div class="card-body">
                        <h5 class="card-title">Tiramisu</h5>
                        <p class="card-text">Classic Italian dessert made with layers of coffee-soaked ladyfingers and mascarpone cream.</p>
                        <p class="fw-bold">$8.99</p>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="menuItemId" value="3">
                            <input type="hidden" name="name" value="Tiramisu">
                            <input type="hidden" name="price" value="8.99">
                            <input type="hidden" name="restaurantId" value="1">
                            <input type="hidden" name="restaurantName" value="Italian Delights">
                            <input type="hidden" name="imagePath" value="https://images.unsplash.com/photo-1607920592519-eca3ae505473?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80">
                            <div class="d-flex">
                                <select name="quantity" class="form-select me-2" style="width: auto;">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                </button>
                            </div>
                            <div class="mt-2">
                                <input type="text" name="specialInstructions" class="form-control" placeholder="Special instructions">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
