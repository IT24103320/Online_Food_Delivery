<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</div><!-- End of container -->

<!-- Footer -->
<footer class="footer mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5 class="footer-brand mb-3">
                    <i class="fas fa-utensils me-2"></i>FoodDash Admin
                </h5>
                <p class="footer-text">Manage your food delivery system with ease.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="footer-text">&copy; <%= java.time.Year.now().getValue() %> FoodDash. All rights reserved.</p>
                <p class="footer-text">Version 1.0</p>
            </div>
        </div>
    </div>
</footer>

<!-- Toast container for notifications -->
<div class="toast-container position-fixed bottom-0 end-0 p-3"></div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>