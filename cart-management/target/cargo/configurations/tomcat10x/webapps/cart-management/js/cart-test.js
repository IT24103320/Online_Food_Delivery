// Simple JavaScript functions for testing the cart functionality

function updateCartCount() {
    // In a real integration, this would get the actual cart count from the server
    const count = sessionStorage.getItem('cartCount') || 0;
    document.getElementById('cartCount').textContent = count;
}

function addToCartSuccess() {
    const currentCount = parseInt(sessionStorage.getItem('cartCount') || 0);
    sessionStorage.setItem('cartCount', currentCount + 1);
    updateCartCount();
    
    // Show notification
    const notification = document.createElement('div');
    notification.className = 'toast show position-fixed bottom-0 end-0 m-3';
    notification.setAttribute('role', 'alert');
    notification.setAttribute('aria-live', 'assertive');
    notification.setAttribute('aria-atomic', 'true');
    notification.innerHTML = `
        <div class="toast-header bg-success text-white">
            <i class="bi bi-check-circle me-2"></i>
            <strong class="me-auto">Success</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            Item added to cart successfully!
        </div>
    `;
    document.body.appendChild(notification);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.remove();
    }, 3000);
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    updateCartCount();
});
