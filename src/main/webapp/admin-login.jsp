<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FoodDash - Admin Login</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Custom CSS -->
  <link href="css/styles.css" rel="stylesheet">
  <!-- Favicon -->
  <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🍔</text></svg>">
</head>
<body class="auth-background">
<!-- Login Form -->
<div class="login-card">
  <div class="text-center mb-4">
    <i class="fas fa-utensils text-primary" style="font-size: 3rem;"></i>
    <h2 class="title-text">FoodDash</h2>
    <p class="text-muted">Admin Login Portal</p>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger d-flex align-items-center" role="alert">
      <i class="fas fa-exclamation-circle me-2"></i>
      <div>${error}</div>
    </div>
  </c:if>

  <form action="admin" method="post" class="needs-validation" novalidate>
    <div class="mb-3">
      <label for="username" class="form-label">
        <i class="fas fa-user food-icon"></i>Username
      </label>
      <div class="input-group">
        <span class="input-group-text"><i class="fas fa-user"></i></span>
        <input type="text" class="form-control" id="username" name="username"
               placeholder="Enter your username" required>
        <div class="invalid-feedback">Please enter your username</div>
      </div>
    </div>

    <div class="mb-4">
      <label for="password" class="form-label">
        <i class="fas fa-lock food-icon"></i>Password
      </label>
      <div class="input-group">
        <span class="input-group-text"><i class="fas fa-lock"></i></span>
        <input type="password" class="form-control" id="password" name="password"
               placeholder="Enter your password" required>
        <div class="invalid-feedback">Please enter your password</div>
      </div>
    </div>

    <div class="mb-3">
      <button type="submit" class="btn btn-primary w-100">
        <i class="fas fa-sign-in-alt me-2"></i>Login
      </button>
    </div>

    <a href="index.jsp" class="btn btn-outline-secondary w-100">
      <i class="fas fa-home me-2"></i>Back to Home
    </a>
  </form>

  <div class="text-center mt-4">
    <p class="mb-0 text-muted">Manage your food delivery system</p>
    <p class="text-muted">© <%= java.time.Year.now().getValue() %> FoodDash</p>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="js/main.js"></script>
</body>
</html>
