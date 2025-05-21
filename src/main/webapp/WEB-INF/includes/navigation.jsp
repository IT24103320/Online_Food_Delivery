<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="card mb-4 shadow-sm">
  <div class="card-body">
    <h5 class="card-title text-primary mb-3">
      <i class="fas fa-compass me-2"></i>Quick Navigation
    </h5>
    <div class="row g-3">
      <div class="col-6 col-md-3">
        <a href="${pageContext.request.contextPath}/index.jsp" class="text-decoration-none">
          <div class="navigation-item p-3 bg-primary-light rounded text-center">
            <i class="fas fa-home fs-4 text-primary mb-2"></i>
            <p class="mb-0">Dashboard</p>
          </div>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="${pageContext.request.contextPath}/restaurant?action=add" class="text-decoration-none">
          <div class="navigation-item p-3 bg-primary-light rounded text-center">
            <i class="fas fa-plus-circle fs-4 text-primary mb-2"></i>
            <p class="mb-0">Add Restaurant</p>
          </div>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="${pageContext.request.contextPath}/menu" class="text-decoration-none">
          <div class="navigation-item p-3 bg-primary-light rounded text-center">
            <i class="fas fa-utensils fs-4 text-primary mb-2"></i>
            <p class="mb-0">Add Menu Item</p>
          </div>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="${pageContext.request.contextPath}/restaurant?action=list" class="text-decoration-none">
          <div class="navigation-item p-3 bg-primary-light rounded text-center">
            <i class="fas fa-list fs-4 text-primary mb-2"></i>
            <p class="mb-0">View Restaurants</p>
          </div>
        </a>
      </div>
    </div>
  </div>
</div>