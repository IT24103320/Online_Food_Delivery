<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Add Restaurant" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="${title}"/>
</jsp:include>

<div class="row mb-4">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/restaurant?action=list">Restaurants</a></li>
                <li class="breadcrumb-item active" aria-current="page">Add New Restaurant</li>
            </ol>
        </nav>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
                <h3 class="card-title mb-0">
                    <i class="fas fa-plus-circle text-primary me-2"></i>Add New Restaurant
                </h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger d-flex align-items-center" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <div>${error}</div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/restaurant" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="add">

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label for="id" class="form-label">
                                <i class="fas fa-id-card text-primary me-1"></i>Restaurant ID
                            </label>
                            <input type="number" class="form-control" id="id" name="id"
                                   placeholder="Enter restaurant ID" required>
                            <div class="invalid-feedback">Please provide a valid ID</div>
                        </div>

                        <div class="col-md-6">
                            <label for="name" class="form-label">
                                <i class="fas fa-store text-primary me-1"></i>Restaurant Name
                            </label>
                            <input type="text" class="form-control" id="name" name="name"
                                   placeholder="Enter restaurant name" required>
                            <div class="invalid-feedback">Please provide a name</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">
                            <i class="fas fa-map-marker-alt text-primary me-1"></i>Address
                        </label>
                        <input type="text" class="form-control" id="address" name="address"
                               placeholder="Enter restaurant address" required>
                        <div class="invalid-feedback">Please provide an address</div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label for="cuisine" class="form-label">
                                <i class="fas fa-utensils text-primary me-1"></i>Cuisine Type
                            </label>
                            <select class="form-select" id="cuisine" name="cuisine" required>
                                <option value="" selected disabled>Select cuisine type</option>
                                <option value="Italian">Italian</option>
                                <option value="American">American</option>
                                <option value="Chinese">Chinese</option>
                                <option value="Japanese">Japanese</option>
                                <option value="Mexican">Mexican</option>
                                <option value="Indian">Indian</option>
                                <option value="Thai">Thai</option>
                                <option value="French">French</option>
                                <option value="Mediterranean">Mediterranean</option>
                                <option value="Other">Other</option>
                            </select>
                            <div class="invalid-feedback">Please select a cuisine type</div>
                        </div>

                        <div class="col-md-6">
                            <label for="ownerId" class="form-label">
                                <i class="fas fa-user text-primary me-1"></i>Owner ID
                            </label>
                            <input type="text" class="form-control" id="ownerId" name="ownerId"
                                   placeholder="Enter owner ID" required>
                            <div class="invalid-feedback">Please provide an owner ID</div>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus-circle me-2"></i>Add Restaurant
                        </button>
                        <a href="${pageContext.request.contextPath}/restaurant?action=list" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back to Restaurants
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
                    <i class="fas fa-info-circle text-primary me-2"></i>Adding a Restaurant
                </h5>
            </div>
            <div class="card-body">
                <p><i class="fas fa-check-circle text-success me-2"></i><strong>Restaurant ID:</strong> Unique identifier for this restaurant.</p>
                <p><i class="fas fa-check-circle text-success me-2"></i><strong>Name:</strong> The name of the restaurant.</p>
                <p><i class="fas fa-check-circle text-success me-2"></i><strong>Address:</strong> Physical location of the restaurant.</p>
                <p><i class="fas fa-check-circle text-success me-2"></i><strong>Cuisine:</strong> Type of food served.</p>
                <p><i class="fas fa-check-circle text-success me-2"></i><strong>Owner ID:</strong> Identifier for the restaurant owner.</p>
            </div>
            <img src="https://pixabay.com/get/g1ce0fa601e5155ed1af465471abbcf5cfc0318d70920e47e0b8578864b01bb04ff76dd57eab6589e5c8a34ecd2fc02211de9655a735ab57cc59cd60bda25a8b0_1280.jpg" class="card-img-bottom" alt="Restaurant image">
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
