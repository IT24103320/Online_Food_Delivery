<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Menu Items" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
  <jsp:param name="title" value="${title}"/>
</jsp:include>

<div class="row mb-4">
  <div class="col-12">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Menu Items</li>
      </ol>
    </nav>
  </div>
</div>

<div class="row mb-4">
  <div class="col-md-8">
    <h2 class="section-title">
      <i class="fas fa-utensils text-primary me-2"></i>Menu Items
    </h2>
  </div>
  <div class="col-md-4 text-md-end">
    <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">
      <i class="fas fa-plus-circle me-2"></i>Add New Item
    </a>
  </div>
</div>

<div class="card shadow-sm">
  <div class="card-body">
    <c:choose>
      <c:when test="${empty menuItems}">
        <div class="text-center py-5">
          <i class="fas fa-utensils text-muted mb-3" style="font-size: 4rem;"></i>
          <h3>No Menu Items Found</h3>
          <p class="text-muted">Start by adding your first menu item</p>
          <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary mt-3">
            <i class="fas fa-plus-circle me-2"></i>Add New Item
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead>
            <tr>
              <th scope="col"><i class="fas fa-hashtag me-1"></i>ID</th>
              <th scope="col"><i class="fas fa-utensils me-1"></i>Name</th>
              <th scope="col"><i class="fas fa-store me-1"></i>Restaurant</th>
              <th scope="col"><i class="fas fa-tag me-1"></i>Price</th>
              <th scope="col"><i class="fas fa-align-left me-1"></i>Description</th>
              <th scope="col"><i class="fas fa-image me-1"></i>Image</th>
              <th scope="col"><i class="fas fa-cogs me-1"></i>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${menuItems}" varStatus="status">
              <tr class="fade-in" style="animation-delay: ${status.index * 0.1}s">
                <td>${item.split(',')[0]}</td>
                <td class="fw-semibold text-primary">${item.split(',')[1]}</td>
                <td>${item.split(',')[2]}</td>
                <td>$${item.split(',')[3]}</td>
                <td>
                                        <span class="d-inline-block text-truncate" style="max-width: 150px;">
                                            ${item.split(',')[4]}
                                        </span>
                </td>
                <td>
                  <img src="${pageContext.request.contextPath}/${item.split(',')[5]}"
                       alt="${item.split(',')[1]}" class="food-image"
                       data-bs-toggle="tooltip" title="${item.split(',')[1]}">
                </td>
                <td>
                  <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/menu?action=edit&id=${item.split(',')[0]}"
                       class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                      <i class="fas fa-edit"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/menu?action=delete&id=${item.split(',')[0]}"
                       class="btn btn-sm btn-outline-danger delete-link"
                       data-confirm="Are you sure you want to delete ${item.split(',')[1]}?"
                       data-bs-toggle="tooltip" title="Delete">
                      <i class="fas fa-trash-alt"></i>
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

<div class="mt-4">
  <div class="card bg-light border-0">
    <div class="card-body">
      <h5><i class="fas fa-lightbulb text-warning me-2"></i>Quick Tips</h5>
      <ul class="mb-0">
        <li>Use high-quality images to make your menu items more appealing</li>
        <li>Keep descriptions clear and appetizing</li>
        <li>Update your menu regularly to keep customers engaged</li>
        <li>Ensure prices are competitive and profitable</li>
      </ul>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
