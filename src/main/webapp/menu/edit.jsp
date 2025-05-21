<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Edit Menu Item" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
  <jsp:param name="title" value="${title}"/>
</jsp:include>

<div class="row mb-4">
  <div class="col-12">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/menu?action=list">Menu Items</a></li>
        <li class="breadcrumb-item active" aria-current="page">Edit Item</li>
      </ol>
    </nav>
  </div>
</div>

<div class="row justify-content-center">
  <div class="col-md-8">
    <div class="card shadow-sm">
      <div class="card-header bg-white py-3">
        <h3 class="card-title mb-0">
          <i class="fas fa-edit text-primary me-2"></i>Edit Menu Item
        </h3>
      </div>
      <div class="card-body">
        <c:if test="${not empty error}">
          <div class="alert alert-danger d-flex align-items-center" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            <div>${error}</div>
          </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/menu" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
          <input type="hidden" name="action" value="update">
          <input type="hidden" name="id" value="${menuItem.split(',')[0]}">

          <div class="row mb-3">
            <div class="col-md-6 mb-3 mb-md-0">
              <label for="id" class="form-label">
                <i class="fas fa-id-card text-primary me-1"></i>Item ID
              </label>
              <input type="text" class="form-control" id="id" value="${menuItem.split(',')[0]}" disabled>
              <small class="text-muted">ID cannot be changed</small>
            </div>

            <div class="col-md-6">
              <label for="name" class="form-label">
                <i class="fas fa-utensils text-primary me-1"></i>Item Name
              </label>
              <input type="text" class="form-control" id="name" name="name"
                     value="${menuItem.split(',')[1]}" required>
              <div class="invalid-feedback">Please provide a name</div>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6 mb-3 mb-md-0">
              <label for="restaurantId" class="form-label">
                <i class="fas fa-store text-primary me-1"></i>Restaurant ID
              </label>
              <input type="number" class="form-control" id="restaurantId" name="restaurantId"
                     value="${menuItem.split(',')[2]}" required>
              <div class="invalid-feedback">Please specify a restaurant</div>
            </div>

            <div class="col-md-6">
              <label for="price" class="form-label">
                <i class="fas fa-tag text-primary me-1"></i>Price
              </label>
              <div class="input-group">
                <span class="input-group-text">$</span>
                <input type="number" step="0.01" min="0" class="form-control" id="price" name="price"
                       value="${menuItem.split(',')[3]}" required>
                <div class="invalid-feedback">Please provide a valid price</div>
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="description" class="form-label">
              <i class="fas fa-align-left text-primary me-1"></i>Description
            </label>
            <textarea class="form-control" id="description" name="description"
                      rows="3" required>${menuItem.split(',')[4]}</textarea>
            <div class="invalid-feedback">Please provide a description</div>
          </div>

          <div class="mb-4">
            <label for="image" class="form-label">
              <i class="fas fa-image text-primary me-1"></i>Upload New Image (optional)
            </label>
            <input type="file" class="form-control" id="image" name="image"
                   accept="image/*" data-preview="imagePreview">
            <div class="mt-2 d-flex flex-column">
              <small class="text-muted mb-2">Current image: ${menuItem.split(',')[5]}</small>
              <div class="current-image-container">
                <img src="${pageContext.request.contextPath}/${menuItem.split(',')[5]}"
                     alt="Current Image" class="img-thumbnail" style="max-height: 200px;">
              </div>
              <div class="mt-2">
                <img id="imagePreview" src="" alt="New Image Preview" class="img-thumbnail"
                     style="max-height: 200px; display: none;">
              </div>
            </div>
          </div>

          <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-save me-2"></i>Update Menu Item
            </button>
            <a href="${pageContext.request.contextPath}/menu?action=list" class="btn btn-outline-secondary">
              <i class="fas fa-arrow-left me-2"></i>Back to Menu List
            </a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="col-md-4">
    <div class="card shadow-sm">
      <div class="card-header bg-white py-3">
        <h5 class="card-title mb-0">
          <i class="fas fa-info-circle text-primary me-2"></i>Editing Tips
        </h5>
      </div>
      <div class="card-body">
        <p><i class="fas fa-lightbulb text-warning me-2"></i>Make your item descriptions appetizing and detailed.</p>
        <p><i class="fas fa-lightbulb text-warning me-2"></i>High-quality images increase customer interest.</p>
        <p><i class="fas fa-lightbulb text-warning me-2"></i>Keep pricing competitive but profitable.</p>
        <p><i class="fas fa-lightbulb text-warning me-2"></i>Update items regularly to keep menu fresh.</p>
      </div>
      <img src="https://pixabay.com/get/gd35151e222ee4edee80a71a08bec18a1e15ce33b5b90ba9e91bc60b7cdb9fe8347e0dbf83a84deaedf564f1ea8b4bdbb34bbb16c46f10827d5ef1984abdb599f_1280.jpg" class="card-img-bottom" alt="Food image">
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
