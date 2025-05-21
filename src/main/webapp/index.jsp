<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FoodDash - Admin Dashboard</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Custom CSS -->
  <link href="css/styles.css" rel="stylesheet">
  <!-- Favicon -->
  <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🍔</text></svg>">
</head>
<body>
<!-- Food decoration elements -->
<i class="fas fa-pizza-slice food-decoration food-decoration-1"></i>
<i class="fas fa-hamburger food-decoration food-decoration-2"></i>
<i class="fas fa-utensils food-decoration food-decoration-3"></i>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">
      <i class="fas fa-utensils me-2"></i>FoodDash Admin
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="home.jsp">
            <i class="fas fa-home me-1"></i> Customer Home
          </a>
        </li>
        <c:if test="${not empty sessionScope.admin}">
          <li class="nav-item">
            <a class="nav-link" href="restaurant?action=list">
              <i class="fas fa-store me-1"></i> Restaurants
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="menu?action=list">
              <i class="fas fa-utensils me-1"></i> Menu Items
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="admin?action=logout">
              <i class="fas fa-sign-out-alt me-1"></i> Logout
            </a>
          </li>
        </c:if>
        <c:if test="${empty sessionScope.admin}">
          <li class="nav-item">
            <a class="nav-link" href="admin">
              <i class="fas fa-sign-in-alt me-1"></i> Admin Login
            </a>
          </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>

<!-- Main Content -->
<div class="container py-5">
  <div class="text-center mb-5">
    <h1 class="display-4 brand-title mb-3">Welcome to FoodDash Admin</h1>
    <p class="lead text-muted">Manage your food delivery platform with ease</p>
  </div>

  <c:choose>
    <c:when test="${not empty sessionScope.admin}">
      <!-- Admin Dashboard Content -->
      <div class="welcome-banner bg-primary-light p-4 mb-5 rounded shadow-sm">
        <div class="d-flex align-items-center">
          <i class="fas fa-user-circle text-primary me-4" style="font-size: 3rem;"></i>
          <div>
            <h3 class="mb-1">Welcome, ${sessionScope.admin.username}!</h3>
            <p class="mb-0 text-muted">Manage your restaurants and menu items from this dashboard</p>
          </div>
        </div>
      </div>

      <div class="row mb-5">
        <div class="col-md-4 mb-4">
          <div class="card dashboard-card h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="rounded-circle bg-primary-light p-3 me-3">
                  <i class="fas fa-store text-primary fa-2x"></i>
                </div>
                <h5 class="card-title mb-0">Manage Restaurants</h5>
              </div>
              <p class="card-text text-muted">Add, edit, or remove restaurants from your delivery platform.</p>
              <div class="mt-auto">
                <a href="restaurant?action=list" class="btn btn-primary me-2">
                  <i class="fas fa-list me-1"></i> View All
                </a>
                <a href="restaurant?action=add" class="btn btn-outline-primary">
                  <i class="fas fa-plus me-1"></i> Add New
                </a>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="card dashboard-card h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="rounded-circle bg-primary-light p-3 me-3">
                  <i class="fas fa-utensils text-primary fa-2x"></i>
                </div>
                <h5 class="card-title mb-0">Manage Menu Items</h5>
              </div>
              <p class="card-text text-muted">Create and manage menu items for your restaurants.</p>
              <div class="mt-auto">
                <a href="menu?action=list" class="btn btn-primary me-2">
                  <i class="fas fa-list me-1"></i> View All
                </a>
                <a href="menu" class="btn btn-outline-primary">
                  <i class="fas fa-plus me-1"></i> Add New
                </a>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="card dashboard-card h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="rounded-circle bg-primary-light p-3 me-3">
                  <i class="fas fa-desktop text-primary fa-2x"></i>
                </div>
                <h5 class="card-title mb-0">View Customer Site</h5>
              </div>
              <p class="card-text text-muted">See how your menu looks to customers on the main website.</p>
              <div class="mt-auto">
                <a href="home.jsp" class="btn btn-primary">
                  <i class="fas fa-external-link-alt me-1"></i> Visit Customer Site
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-lg-8 mb-4">
          <div class="card shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
              <h5 class="mb-0"><i class="fas fa-bullhorn text-primary me-2"></i>Quick Actions</h5>
            </div>
            <div class="card-body">
              <div class="row g-3">
                <div class="col-md-6">
                  <a href="restaurant?action=add" class="btn btn-outline-primary w-100 text-start">
                    <i class="fas fa-plus-circle me-2"></i> Add New Restaurant
                  </a>
                </div>
                <div class="col-md-6">
                  <a href="menu" class="btn btn-outline-primary w-100 text-start">
                    <i class="fas fa-plus-circle me-2"></i> Add New Menu Item
                  </a>
                </div>
                <div class="col-md-6">
                  <a href="restaurant?action=list" class="btn btn-outline-secondary w-100 text-start">
                    <i class="fas fa-list me-2"></i> View All Restaurants
                  </a>
                </div>
                <div class="col-md-6">
                  <a href="menu?action=list" class="btn btn-outline-secondary w-100 text-start">
                    <i class="fas fa-list me-2"></i> View All Menu Items
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-4 mb-4">
          <div class="card shadow-sm">
            <div class="card-header bg-white">
              <h5 class="mb-0"><i class="fas fa-info-circle text-primary me-2"></i>System Information</h5>
            </div>
            <div class="card-body">
              <p class="mb-2"><strong>User:</strong> ${sessionScope.admin.username}</p>
              <p class="mb-2"><strong>Server Time:</strong> <%= new java.util.Date() %></p>
              <p class="mb-0"><strong>Application Version:</strong> 1.0</p>
            </div>
          </div>
        </div>
      </div>
    </c:when>
    <c:otherwise>
      <!-- Login Prompt -->
      <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
          <div class="card shadow-sm text-center">
            <div class="card-body py-5">
              <i class="fas fa-lock text-primary mb-3" style="font-size: 3rem;"></i>
              <h2 class="card-title mb-3">Admin Access Required</h2>
              <p class="card-text text-muted mb-4">Please login to access the admin dashboard</p>
              <div class="d-grid gap-3">
                <a href="admin" class="btn btn-primary btn-lg">
                  <i class="fas fa-sign-in-alt me-2"></i>Admin Login
                </a>
                <a href="home.jsp" class="btn btn-outline-primary">
                  <i class="fas fa-home me-2"></i>Go to Customer Home
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<!-- Footer -->
<footer class="footer mt-auto">
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        <h5 class="footer-brand mb-3">
          <i class="fas fa-utensils me-2"></i>FoodDash Admin
        </h5>
        <p class="footer-text">Manage your food delivery system with ease.</p>
      </div>
      <div class="col-md-6 text-md-end">
        <p class="footer-text">&copy; <%= java.time.Year.now().getValue() %> FoodDash. All rights reserved.</p>
        <p class="footer-text">Version 1.0</p>
      </div>
    </div>
  </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="js/main.js"></script>
</body>
</html>