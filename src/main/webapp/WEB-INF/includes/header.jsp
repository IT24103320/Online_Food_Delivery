<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FoodDash Admin - ${param.title}</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Custom CSS -->
  <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
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
    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
      <i class="fas fa-utensils me-2"></i>FoodDash
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <c:choose>
          <c:when test="${not empty sessionScope.admin}">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                <i class="fas fa-home me-1"></i> Home
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/restaurant?action=list">
                <i class="fas fa-store me-1"></i> Restaurants
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/menu?action=list">
                <i class="fas fa-utensils me-1"></i> Menu Items
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/admin?action=logout">
                <i class="fas fa-sign-out-alt me-1"></i> Logout
              </a>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                <i class="fas fa-sign-in-alt me-1"></i> Admin Login
              </a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>

<!-- Main Content Container -->
<div class="container py-4">
<c:if test="${not empty sessionScope.admin}">
  <div class="welcome-banner bg-primary-light p-3 mb-4 rounded slide-in">
    <div class="d-flex align-items-center">
      <i class="fas fa-user-circle text-primary me-3 fs-1"></i>
      <div>
        <h4 class="mb-0">Welcome, ${sessionScope.admin.username}!</h4>
        <p class="text-muted mb-0">Manage your food delivery system</p>
      </div>
    </div>
  </div>
</c:if>