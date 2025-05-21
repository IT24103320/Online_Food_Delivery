<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="title" value="Update Restaurant" scope="request"/>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="${title}"/>
</jsp:include>

<div class="row mb-4">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/restaurant?action=list">Restaurants</a></li>
                <li class="breadcrumb-item active" aria-current="page">Update Restaurant</li>
            </ol>
        </nav>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
                <h3 class="card-title mb-0">
                    <i class="fas fa-edit text-primary me-2"></i>Update Restaurant Details
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
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${restaurant.split(',')[0]}">

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label for="id" class="form-label">
                                <i class="fas fa-id-card text-primary me-1"></i>Restaurant ID
                            </label>
                            <input type="text" class="form-control" id="id" value="${restaurant.split(',')[0]}" disabled>
                            <small class="text-muted">ID cannot be changed</small>
                        </div>

                        <div class="col-md-6">
                            <label for="name" class="form-label">
                                <i class="fas fa-store text-primary me-1"></i>Restaurant Name
                            </label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="${restaurant.split(',')[1]}" required>
                            <div class="invalid-feedback">Please provide a name</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">
                            <i class="fas fa-map-marker-alt text-primary me-1"></i>Address
                        </label>
                        <input type="text" class="form-control" id="address" name="address"
                               value="${restaurant.split(',')[2]}" required>
                        <div class="invalid-feedback">Please provide an address</div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label for="cuisine" class="form-label">
                                <i class="fas fa-utensils text-primary me-1"></i>Cuisine Type
                            </label>
                            <select class="form-select" id="cuisine" name="cuisine" required>
                                <option value="Italian" ${restaurant.split(',')[3] == 'Italian' ? 'selected' : ''}>Italian</option>
                                <option value="American" ${restaurant.split(',')[3] == 'American' ? 'selected' : ''}>American</option>
                                <option value="Chinese" ${restaurant.split(',')[3] == 'Chinese' ? 'selected' : ''}>Chinese</option>
                                <option value="Japanese" ${restaurant.split(',')[3] == 'Japanese' ? 'selected' : ''}>Japanese</option>
                                <option value="Mexican" ${restaurant.split(',')[3] == 'Mexican' ? 'selected' : ''}>Mexican</option>
                                <option value="Indian" ${restaurant.split(',')[3] == 'Indian' ? 'selected' : ''}>Indian</option>
                                <option value="Thai" ${restaurant.split(',')[3] == 'Thai' ? 'selected' : ''}>Thai</option>
                                <option value="French" ${restaurant.split(',')[3] == 'French' ? 'selected' : ''}>French</option>
                                <option value="Mediterranean" ${restaurant.split(',')[3] == 'Mediterranean' ? 'selected' : ''}>Mediterranean</option>
                                <option value="Other" ${restaurant.split(',')[3] == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                            <div class="invalid-feedback">Please select a cuisine type</div>
                        </div>

                        <div class="col-md-6">
                            <label for="ownerId" class="form-label">
                                <i class="fas fa-user text-primary me-1"></i>Owner ID
                            </label>
                            <input type="text" class="form-control" id="ownerId" name="ownerId"
                                   value="${restaurant.split(',')[4]}" required>
                            <div class="invalid-feedback">Please provide an owner ID</div>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Update Restaurant
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
                    <i class="fas fa-info-circle text-primary me-2"></i>Restaurant Details
                </h5>
            </div>
            <div class="card-body">
                <div class="restaurant-info">
                    <h5 class="text-primary">${restaurant.split(',')[1]}</h5>
                    <p><i class="fas fa-map-marker-alt me-2"></i>${restaurant.split(',')[2]}</p>
                    <p><i class="fas fa-utensils me-2"></i>${restaurant.split(',')[3]} Cuisine</p>
                    <div class="restaurant-status mb-3">
                        <span class="badge bg-success">Active</span>
                    </div>
                    <hr>
                    <p class="text-muted">
                        <i class="fas fa-info-circle me-2"></i>
                        Update the restaurant information using the form on the left.
                    </p>
                </div>
            </div>
            <img src="https://pixabay.com/get/g14550f00868895cfe30e3c156ad0e8ea0cc7108c3567c522790756204a433febfc4e59d9c7f30ff5243923e6c353e6ae7cb70ec6f548768ac744f55e496a9949_1280.jpg" class="card-img-bottom" alt="Restaurant image">
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
