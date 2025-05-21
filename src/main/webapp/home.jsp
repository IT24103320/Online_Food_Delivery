<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodDash - Food Delivery</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link href="css/styles.css" rel="stylesheet">
    <!-- Favicon -->
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🍔</text></svg>">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
            url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            text-align: center;
            margin-bottom: 40px;
        }

        .menu-card {
            height: 100%;
            transition: transform 0.3s;
        }

        .menu-card:hover {
            transform: translateY(-10px);
        }

        .menu-image {
            height: 200px;
            object-fit: cover;
        }

        .cuisine-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        .price-tag {
            position: absolute;
            bottom: -15px;
            right: 20px;
            background-color: var(--primary-color);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
        }

        .restaurant-name {
            color: var(--primary-color);
            font-weight: 600;
        }

        .category-filter {
            overflow-x: auto;
            white-space: nowrap;
            padding: 10px 0;
            margin-bottom: 30px;
        }

        .category-item {
            display: inline-block;
            padding: 8px 15px;
            margin: 0 5px;
            background-color: var(--light);
            border-radius: 20px;
            cursor: pointer;
            transition: var(--transition);
        }

        .category-item:hover, .category-item.active {
            background-color: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
<!-- Food decoration elements -->
<i class="fas fa-pizza-slice food-decoration food-decoration-1"></i>
<i class="fas fa-hamburger food-decoration food-decoration-2"></i>
<i class="fas fa-utensils food-decoration food-decoration-3"></i>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">
            <i class="fas fa-utensils me-2"></i>FoodDash
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="home.jsp">
                        <i class="fas fa-home me-1"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#restaurants">
                        <i class="fas fa-store me-1"></i> Restaurants
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">
                        <i class="fas fa-info-circle me-1"></i> About
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="admin">
                        <i class="fas fa-user-shield me-1"></i> Admin
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <h1 class="display-4 fw-bold mb-4">Delicious Food Delivered</h1>
        <p class="lead mb-5">Order from your favorite restaurants with just a few clicks</p>
        <div class="d-flex justify-content-center">
            <a href="#menu" class="btn btn-primary btn-lg me-3">
                <i class="fas fa-utensils me-2"></i>Explore Menu
            </a>
            <a href="#restaurants" class="btn btn-outline-light btn-lg">
                <i class="fas fa-store me-2"></i>View Restaurants
            </a>
        </div>
    </div>
</section>

<!-- Main Content -->
<div class="container">
    <!-- Category Filters -->
    <div class="category-filter">
        <div class="category-item active">All</div>
        <div class="category-item">Italian</div>
        <div class="category-item">American</div>
        <div class="category-item">Chinese</div>
        <div class="category-item">Japanese</div>
        <div class="category-item">Mexican</div>
        <div class="category-item">Indian</div>
        <div class="category-item">Thai</div>
    </div>

    <!-- Menu Items Section -->
    <section id="menu" class="py-4">
        <h2 class="section-title mb-4">Our Menu</h2>

        <div class="row g-4">
            <c:choose>
                <c:when test="${empty menuItems}">
                    <c:forEach var="item" items="${['1,Margherita Pizza,1,12.99,Classic tomato and mozzarella,images/pizza.jpg',
                                             '2,Cheeseburger,2,8.99,Juicy beef patty with cheese,images/burger.jpg']}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card menu-card">
                                <div class="position-relative">
                                    <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                                         class="card-img-top menu-image" alt="${item.split(',')[1]}">
                                    <span class="cuisine-badge badge bg-primary-light text-primary">
                                            Italian
                                        </span>
                                    <div class="price-tag">$${item.split(',')[3]}</div>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${item.split(',')[1]}</h5>
                                    <p class="card-text text-muted">${item.split(',')[4]}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                            <span class="restaurant-name">
                                                <i class="fas fa-store me-1"></i>
                                                <c:choose>
                                                    <c:when test="${item.split(',')[2] == '1'}">Italian Bistro</c:when>
                                                    <c:when test="${item.split(',')[2] == '2'}">Burger Bonanza</c:when>
                                                    <c:otherwise>Restaurant #${item.split(',')[2]}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        <button type="button" class="btn btn-sm btn-outline-primary view-details-btn"
                                                data-id="${item.split(',')[0]}" data-bs-toggle="modal" data-bs-target="#menuItemModal">
                                            <i class="fas fa-eye me-1"></i> View
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${menuItems}" varStatus="status">
                        <div class="col-md-6 col-lg-4">
                            <div class="card menu-card">
                                <div class="position-relative">
                                    <img src="${pageContext.request.contextPath}/${item.split(',')[5]}"
                                         class="card-img-top menu-image" alt="${item.split(',')[1]}">
                                    <span class="cuisine-badge badge bg-primary-light text-primary">
                                            <c:choose>
                                                <c:when test="${item.split(',')[2] == '1'}">Italian</c:when>
                                                <c:when test="${item.split(',')[2] == '2'}">American</c:when>
                                                <c:otherwise>Popular</c:otherwise>
                                            </c:choose>
                                        </span>
                                    <div class="price-tag">$${item.split(',')[3]}</div>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${item.split(',')[1]}</h5>
                                    <p class="card-text text-muted">${item.split(',')[4]}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                            <span class="restaurant-name">
                                                <i class="fas fa-store me-1"></i>
                                                <c:choose>
                                                    <c:when test="${item.split(',')[2] == '1'}">Italian Bistro</c:when>
                                                    <c:when test="${item.split(',')[2] == '2'}">Burger Bonanza</c:when>
                                                    <c:otherwise>Restaurant #${item.split(',')[2]}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        <button type="button" class="btn btn-sm btn-outline-primary view-details-btn"
                                                data-id="${item.split(',')[0]}" data-bs-toggle="modal" data-bs-target="#menuItemModal">
                                            <i class="fas fa-eye me-1"></i> View
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Restaurants Section -->
    <section id="restaurants" class="py-5">
        <h2 class="section-title mb-4">Our Partner Restaurants</h2>

        <div class="row g-4">
            <c:choose>
                <c:when test="${empty restaurants}">
                    <c:forEach var="restaurant" items="${['1,Italian Bistro,123 Main St,Italian,owner1',
                                                   '2,Burger Bonanza,456 Oak Ave,American,owner2']}">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="row g-0">
                                    <div class="col-md-4">
                                        <img src="https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80"
                                             class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="${restaurant.split(',')[1]}">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
                                            <h5 class="card-title">${restaurant.split(',')[1]}</h5>
                                            <span class="badge bg-primary-light text-primary mb-2">${restaurant.split(',')[3]}</span>
                                            <p class="card-text">
                                                <i class="fas fa-map-marker-alt text-primary me-1"></i> ${restaurant.split(',')[2]}
                                            </p>
                                            <button type="button" class="btn btn-sm btn-primary">
                                                <i class="fas fa-utensils me-1"></i> Browse Menu
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach var="restaurant" items="${restaurants}" varStatus="status">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="row g-0">
                                    <div class="col-md-4">
                                        <img src="https://source.unsplash.com/random/300x300/?restaurant,${restaurant.split(',')[3]}"
                                             class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="${restaurant.split(',')[1]}">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
                                            <h5 class="card-title">${restaurant.split(',')[1]}</h5>
                                            <span class="badge bg-primary-light text-primary mb-2">${restaurant.split(',')[3]}</span>
                                            <p class="card-text">
                                                <i class="fas fa-map-marker-alt text-primary me-1"></i> ${restaurant.split(',')[2]}
                                            </p>
                                            <button type="button" class="btn btn-sm btn-primary">
                                                <i class="fas fa-utensils me-1"></i> Browse Menu
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-5">
        <div class="row">
            <div class="col-lg-6">
                <h2 class="section-title">About FoodDash</h2>
                <p>FoodDash connects you with the best restaurants in your area. We're passionate about food and committed to providing you with a seamless ordering experience.</p>
                <p>Our mission is to bring delicious food from your favorite local restaurants right to your doorstep, quickly and reliably.</p>
                <ul class="list-unstyled">
                    <li><i class="fas fa-check-circle text-primary me-2"></i> Partnered with top restaurants</li>
                    <li><i class="fas fa-check-circle text-primary me-2"></i> Quick and reliable delivery</li>
                    <li><i class="fas fa-check-circle text-primary me-2"></i> Easy online ordering</li>
                    <li><i class="fas fa-check-circle text-primary me-2"></i> Excellent customer support</li>
                </ul>
            </div>
            <div class="col-lg-6">
                <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                     class="img-fluid rounded shadow" alt="Food Delivery">
            </div>
        </div>
    </section>
</div>

<!-- Menu Item Modal -->
<div class="modal fade" id="menuItemModal" tabindex="-1" aria-labelledby="menuItemModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="menuItemModalLabel">Menu Item Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <img src="" id="modalItemImage" class="img-fluid rounded" alt="Menu Item">
                    </div>
                    <div class="col-md-6">
                        <h4 id="modalItemName" class="mb-3"></h4>
                        <div class="mb-3">
                            <span class="badge bg-primary-light text-primary" id="modalItemCuisine"></span>
                            <span class="badge bg-secondary-light text-secondary" id="modalItemPrice"></span>
                        </div>
                        <p id="modalItemDescription" class="mb-4"></p>
                        <div class="restaurant-info mb-4">
                            <h5 class="mb-2">Restaurant</h5>
                            <p class="mb-1"><i class="fas fa-store text-primary me-2"></i><span id="modalRestaurantName"></span></p>
                            <p class="mb-0"><i class="fas fa-map-marker-alt text-primary me-2"></i><span id="modalRestaurantAddress"></span></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5 class="footer-brand mb-3">
                    <i class="fas fa-utensils me-2"></i>FoodDash
                </h5>
                <p class="footer-text mb-3">Delicious food delivered to your doorstep.</p>
                <div class="social-icons">
                    <a href="#" class="text-light me-2"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-light me-2"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-light me-2"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="col-md-4">
                <h5 class="text-light mb-3">Useful Links</h5>
                <ul class="list-unstyled">
                    <li><a href="home.jsp" class="text-light">Home</a></li>
                    <li><a href="#restaurants" class="text-light">Restaurants</a></li>
                    <li><a href="#about" class="text-light">About Us</a></li>
                    <li><a href="admin" class="text-light">Admin Login</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="text-light mb-3">Contact Us</h5>
                <ul class="list-unstyled">
                    <li class="text-light"><i class="fas fa-map-marker-alt me-2"></i>123 Food Street, Foodville</li>
                    <li class="text-light"><i class="fas fa-phone me-2"></i>(123) 456-7890</li>
                    <li class="text-light"><i class="fas fa-envelope me-2"></i>info@fooddash.com</li>
                </ul>
            </div>
        </div>
        <hr class="bg-light mt-4 mb-4">
        <div class="row">
            <div class="col-md-6">
                <p class="footer-text">&copy; <%= java.time.Year.now().getValue() %> FoodDash. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="footer-text">Designed with <i class="fas fa-heart text-danger"></i> for food lovers</p>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="js/main.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Filter menu items by category
        const categoryItems = document.querySelectorAll('.category-item');
        categoryItems.forEach(item => {
            item.addEventListener('click', function() {
                // Remove active class from all items
                categoryItems.forEach(ci => ci.classList.remove('active'));
                // Add active class to clicked item
                this.classList.add('active');

                // TODO: Implement actual filtering
                console.log('Filter by:', this.textContent);
            });
        });

        // Initialize view details buttons
        const viewButtons = document.querySelectorAll('.view-details-btn');
        viewButtons.forEach(button => {
            button.addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                const cardBody = this.closest('.card-body');
                const cardImage = this.closest('.card').querySelector('.menu-image');

                // Get info from the card
                const itemName = cardBody.querySelector('.card-title').textContent;
                const itemDesc = cardBody.querySelector('.card-text').textContent;
                const itemPrice = this.closest('.card').querySelector('.price-tag').textContent;
                const restaurantName = cardBody.querySelector('.restaurant-name').textContent.trim();
                const cuisineBadge = this.closest('.card').querySelector('.cuisine-badge').textContent.trim();

                // Populate modal
                document.getElementById('modalItemName').textContent = itemName;
                document.getElementById('modalItemDescription').textContent = itemDesc;
                document.getElementById('modalItemPrice').textContent = itemPrice;
                document.getElementById('modalItemCuisine').textContent = cuisineBadge;
                document.getElementById('modalRestaurantName').textContent = restaurantName;
                document.getElementById('modalRestaurantAddress').textContent = "123 Restaurant Street";
                document.getElementById('modalItemImage').src = cardImage.src;
            });
        });
    });
</script>
</body>
</html>