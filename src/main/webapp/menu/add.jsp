<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Add Menu Item" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
  <jsp:param name="title" value="${title}"/>
</jsp:include>

<div class="row mb-4">
  <div class="col-12">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/menu?action=list">Menu Items</a></li>
        <li class="breadcrumb-item active" aria-current="page">Add New Item</li>
      </ol>
    </nav>
  </div>
</div>

<div class="row justify-content-center">
  <div class="col-md-8">
    <div class="card shadow-sm">
      <div class="card-header bg-white py-3">
        <h3 class="card-title mb-0">
          <i class="fas fa-plus-circle text-primary me-2"></i>Add New Menu Item
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
          <input type="hidden" name="action" value="add">

          <div class="row mb-3">
            <div class="col-md-6 mb-3 mb-md-0">
              <label for="id" class="form-label">
                <i class="fas fa-id-card text-primary me-1"></i>Item ID
              </label>
              <input type="number" class="form-control" id="id" name="id"
                     placeholder="Enter item ID" required>
              <div class="invalid-feedback">Please provide a valid ID</div>
            </div>

            <div class="col-md-6">
              <label for="name" class="form-label">
                <i class="fas fa-utensils text-primary me-1"></i>Item Name
              </label>
              <input type="text" class="form-control" id="name" name="name"
                     placeholder="Enter item name" required>
              <div class="invalid-feedback">Please provide a name</div>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6 mb-3 mb-md-0">
              <label for="restaurantId" class="form-label">
                <i class="fas fa-store text-primary me-1"></i>Restaurant ID
              </label>
              <input type="number" class="form-control" id="restaurantId" name="restaurantId"
                     placeholder="Enter restaurant ID" required>
              <div class="invalid-feedback">Please specify a restaurant</div>
            </div>

            <div class="col-md-6">
              <label for="price" class="form-label">
                <i class="fas fa-tag text-primary me-1"></i>Price
              </label>
              <div class="input-group">
                <span class="input-group-text">$</span>
                <input type="number" step="0.01" min="0" class="form-control" id="price" name="price"
                       placeholder="0.00" required>
                <div class="invalid-feedback">Please provide a valid price</div>
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="description" class="form-label">
              <i class="fas fa-align-left text-primary me-1"></i>Description
            </label>
            <textarea class="form-control" id="description" name="description"
                      placeholder="Enter description" rows="3" required></textarea>
            <div class="invalid-feedback">Please provide a description</div>
          </div>

          <div class="mb-4">
            <label for="image" class="form-label">
              <i class="fas fa-image text-primary me-1"></i>Upload Image
            </label>
            <input type="file" class="form-control" id="image" name="image"
                   accept="image/*" data-preview="imagePreview">
            <div class="mt-2">
              <img id="imagePreview" src="" alt="Preview" class="img-thumbnail"
                   style="max-height: 200px; display: none;">
            </div>
          </div>

          <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-plus-circle me-2"></i>Add Menu Item
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
          <i class="fas fa-info-circle text-primary me-2"></i>Adding a New Menu Item
        </h5>
      </div>
      <div class="card-body">
        <p><i class="fas fa-check-circle text-success me-2"></i><strong>Item ID:</strong> Unique identifier for this menu item.</p>
        <p><i class="fas fa-check-circle text-success me-2"></i><strong>Item Name:</strong> Name of the dish or product.</p>
        <p><i class="fas fa-check-circle text-success me-2"></i><strong>Restaurant ID:</strong> Which restaurant offers this item.</p>
        <p><i class="fas fa-check-circle text-success me-2"></i><strong>Price:</strong> How much the item costs.</p>
        <p><i class="fas fa-check-circle text-success me-2"></i><strong>Description:</strong> Details about the item.</p>
        <p><i class="fas fa-check-circle text-success me-2"></i><strong>Image:</strong> A picture of the item (optional).</p>
      </div>
      <img src="https://pixabay.com/get/g454e6dfca1ee77f968170d737338767c46cb6035867caa75707ac6fec67696ce9717d85ef241e54a2634bdac14ad35b082a6f8f7e6759d305425c924324472b4_1280.jpg" class="card-img-bottom" alt="Food image">
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
