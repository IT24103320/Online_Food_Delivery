<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Dashboard" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
  <jsp:param name="title" value="${title}"/>
</jsp:include>

<!-- Dashboard Content -->
<div class="row mb-4">
  <div class="col-12">
    <h1 class="brand-title mb-4">
      <i class="fas fa-utensils me-2"></i>FoodDash Delivery System
    </h1>
    <p class="lead">Welcome to your food delivery management dashboard.</p>
  </div>
</div>

<c:choose>
  <c:when test="${not empty sessionScope.admin}">
    <!-- Admin Dashboard -->
    <jsp:include page="/WEB-INF/includes/navigation.jsp"/>

    <div class="row mb-4">
      <div class="col-md-4 mb-4 mb-md-0">
        <div class="dashboard-card">
          <i class="fas fa-store"></i>
          <div class="content">
            <h3>Manage Restaurants</h3>
            <p>Add, update or delete restaurant information</p>
          </div>
        </div>
      </div>
      <div class="col-md-4 mb-4 mb-md-0">
        <div class="dashboard-card">
          <i class="fas fa-utensils"></i>
          <div class="content">
            <h3>Manage Menu Items</h3>
            <p>Update your food menu and pricing</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="dashboard-card">
          <i class="fas fa-users"></i>
          <div class="content">
            <h3>User Management</h3>
            <p>Manage user accounts and permissions</p>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6 mb-4">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Quick Stats</h5>
            <button class="btn btn-sm btn-outline-primary">Refresh</button>
          </div>
          <div class="card-body">
            <div class="row text-center g-3">
              <div class="col-6">
                <div class="p-3 bg-primary-light rounded">
                  <h2 class="text-primary">2</h2>
                  <p class="mb-0">Restaurants</p>
                </div>
              </div>
              <div class="col-6">
                <div class="p-3 bg-primary-light rounded">
                  <h2 class="text-primary">2</h2>
                  <p class="mb-0">Menu Items</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-6 mb-4">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Quick Actions</h5>
          </div>
          <div class="card-body">
            <div class="d-grid gap-2">
              <a href="restaurant?action=add" class="btn btn-primary">
                <i class="fas fa-plus-circle me-2"></i>Add New Restaurant
              </a>
              <a href="menu" class="btn btn-primary">
                <i class="fas fa-plus-circle me-2"></i>Add New Menu Item
              </a>
              <a href="admin?action=logout" class="btn btn-secondary">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>System Information</h5>
          </div>
          <div class="card-body">
            <p><strong>User:</strong> ${sessionScope.admin.username}</p>
            <p><strong>Server Time:</strong> <%= new java.util.Date() %></p>
            <p><strong>Application Version:</strong> 1.0</p>
          </div>
        </div>
      </div>
    </div>
  </c:when>
  <c:otherwise>
    <!-- Login Prompt -->
    <div class="card">
      <div class="card-body text-center py-5">
        <div class="mb-4">
          <img src="https://pixabay.com/get/g8bb27f83e06c17b0c2d3a57fd7c6cc8251eacd8ad78f26f944559032f50e293e65fda148afd1db79a9b1e1eb1c722156e792b1dfe68cc2d65a8cfab68dbd9fbb_1280.jpg"
               alt="Food Delivery" class="img-fluid rounded" style="max-height: 300px;">
        </div>
        <h2 class="mb-4">Welcome to FoodDash Admin Panel</h2>
        <p class="lead mb-4">Please login to access the admin dashboard</p>
        <a href="admin" class="btn btn-primary btn-lg">
          <i class="fas fa-sign-in-alt me-2"></i>Admin Login
        </a>
      </div>
    </div>
  </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
