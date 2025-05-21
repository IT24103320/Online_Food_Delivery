<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Restaurants" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
  <jsp:param name="title" value="${title}"/>
</jsp:include>

<div class="row mb-4">
  <div class="col-12">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Restaurants</li>
      </ol>
    </nav>
  </div>
</div>

<div class="row mb-4">
  <div class="col-md-8">
    <h2 class="section-title">
      <i class="fas fa-store text-primary me-2"></i>Restaurants
    </h2>
  </div>
  <div class="col-md-4 text-md-end">
    <a href="${pageContext.request.contextPath}/restaurant?action=add" class="btn btn-primary">
      <i class="fas fa-plus-circle me-2"></i>Add New Restaurant
    </a>
  </div>
</div>

<div class="card shadow-sm">
  <div class="card-body">
    <c:choose>
      <c:when test="${empty restaurants}">
        <div class="text-center py-5">
          <i class="fas fa-store text-muted mb-3" style="font-size: 4rem;"></i>
          <h3>No Restaurants Found</h3>
          <p class="text-muted">Start by adding your first restaurant</p>
          <a href="${pageContext.request.contextPath}/restaurant?action=add" class="btn btn-primary mt-3">
            <i class="fas fa-plus-circle me-2"></i>Add New Restaurant
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead>
            <tr>
              <th scope="col"><i class="fas fa-hashtag me-1"></i>ID</th>
              <th scope="col"><i class="fas fa-store me-1"></i>Name</th>
              <th scope="col"><i class="fas fa-map-marker-alt me-1"></i>Address</th>
              <th scope="col"><i class="fas fa-utensils me-1"></i>Cuisine</th>
              <th scope="col"><i class="fas fa-user me-1"></i>Owner ID</th>
              <th scope="col"><i class="fas fa-cogs me-1"></i>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="restaurant" items="${restaurants}" varStatus="status">
              <tr class="fade-in" style="animation-delay: ${status.index * 0.1}s">
                <td>${restaurant.split(',')[0]}</td>
                <td class="fw-semibold text-primary">${restaurant.split(',')[1]}</td>
                <td>
                                        <span data-bs-toggle="tooltip" title="${restaurant.split(',')[2]}">
                                            ${restaurant.split(',')[2]}
                                        </span>
                </td>
                <td><span class="badge bg-primary-light text-primary">${restaurant.split(',')[3]}</span></td>
                <td>${restaurant.split(',')[4]}</td>
                <td>
                  <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/restaurant?action=update&id=${restaurant.split(',')[0]}"
                       class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                      <i class="fas fa-edit"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/restaurant?action=delete&id=${restaurant.split(',')[0]}"
                       class="btn btn-sm btn-outline-danger delete-link"
                       data-confirm="Are you sure you want to delete ${restaurant.split(',')[1]}?"
                       data-bs-toggle="tooltip" title="Delete">
                      <i class="fas fa-trash-alt"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/menu?action=list&restaurantId=${restaurant.split(',')[0]}"
                       class="btn btn-sm btn-outline-secondary" data-bs-toggle="tooltip" title="View Menu">
                      <i class="fas fa-utensils"></i>
                    </a>
                  </div>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<div class="row mt-4">
  <div class="col-md-4 mb-4">
    <div class="card shadow-sm h-100">
      <div class="card-body">
        <h5 class="card-title"><i class="fas fa-star text-warning me-2"></i>Featured Restaurant</h5>
        <c:if test="${not empty restaurants}">
          <h3 class="text-primary">${restaurants[0].split(',')[1]}</h3>
          <p><i class="fas fa-map-marker-alt me-2 text-primary"></i>${restaurants[0].split(',')[2]}</p>
          <p><i class="fas fa-utensils me-2 text-primary"></i>${restaurants[0].split(',')[3]} Cuisine</p>
        </c:if>
      </div>
    </div>
  </div>

  <div class="col-md-8 mb-4">
    <div class="card bg-light border-0">
      <div class="card-body">
        <h5><i class="fas fa-lightbulb text-warning me-2"></i>Restaurant Management Tips</h5>
        <div class="row">
          <div class="col-md-6">
            <ul class="mb-0">
              <li>Keep restaurant information updated</li>
              <li>Ensure address details are accurate</li>
            </ul>
          </div>
          <div class="col-md-6">
            <ul class="mb-0">
              <li>Add appealing menu items for each restaurant</li>
              <li>Categorize restaurants by cuisine type</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
