/**
 * FoodDash - Food Delivery Admin Interface
 * Main JavaScript File
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all tooltips
    initTooltips();

    // Add fade-in animation to cards
    animateCards();

    // Initialize form validation
    initFormValidation();

    // Initialize image preview for file uploads
    initImagePreview();

    // Initialize confirmation dialogs
    initConfirmDialogs();
});

/**
 * Initialize Bootstrap tooltips
 */
function initTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

/**
 * Add animation to cards on page load
 */
function animateCards() {
    const cards = document.querySelectorAll('.card, .form-card, .list-card');
    cards.forEach((card, index) => {
        setTimeout(() => {
            card.classList.add('fade-in');
        }, 100 * index);
    });

    const listItems = document.querySelectorAll('.list-group-item');
    listItems.forEach((item, index) => {
        setTimeout(() => {
            item.classList.add('slide-in');
        }, 50 * index);
    });
}

/**
 * Initialize form validation for all forms
 */
function initFormValidation() {
    // Get all forms with the class 'needs-validation'
    const forms = document.querySelectorAll('.needs-validation');

    // Loop over them and prevent submission
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    });
}

/**
 * Initialize image preview for file inputs
 */
function initImagePreview() {
    const fileInputs = document.querySelectorAll('input[type="file"][accept*="image"]');

    fileInputs.forEach(input => {
        const previewId = input.getAttribute('data-preview');
        if (previewId) {
            const previewElement = document.getElementById(previewId);

            if (previewElement) {
                input.addEventListener('change', function() {
                    if (this.files && this.files[0]) {
                        const reader = new FileReader();

                        reader.onload = function(e) {
                            previewElement.src = e.target.result;
                            previewElement.style.display = 'block';
                        };

                        reader.readAsDataURL(this.files[0]);
                    }
                });
            }
        }
    });
}

/**
 * Initialize confirmation dialogs for delete actions
 */
function initConfirmDialogs() {
    const deleteLinks = document.querySelectorAll('.delete-link');

    deleteLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            const confirmMessage = this.getAttribute('data-confirm') || 'Are you sure you want to delete this item?';

            if (!confirm(confirmMessage)) {
                event.preventDefault();
            }
        });
    });
}

/**
 * Show a toast notification
 * @param {string} message - The message to display
 * @param {string} type - The type of notification (success, error, warning, info)
 */
function showNotification(message, type = 'success') {
    // Create toast container if it doesn't exist
    let toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
        document.body.appendChild(toastContainer);
    }

    // Create a new toast
    const toastId = 'toast-' + Date.now();
    const toast = document.createElement('div');
    toast.className = `toast align-items-center text-white bg-${type === 'error' ? 'danger' : type}`;
    toast.setAttribute('role', 'alert');
    toast.setAttribute('aria-live', 'assertive');
    toast.setAttribute('aria-atomic', 'true');
    toast.setAttribute('id', toastId);

    // Toast content
    toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;

    // Add toast to container
    toastContainer.appendChild(toast);

    // Initialize and show the toast
    const toastElement = new bootstrap.Toast(toast, {
        animation: true,
        autohide: true,
        delay: 5000
    });
    toastElement.show();

    // Remove toast after it's hidden
    toast.addEventListener('hidden.bs.toast', function() {
        toast.remove();
    });
}

/**
 * Format currency values
 * @param {number} value - The value to format
 * @param {string} currency - The currency code (default: USD)
 * @returns {string} - The formatted currency string
 */
function formatCurrency(value, currency = 'USD') {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: currency
    }).format(value);
}

/**
 * Toggle sidebar on mobile view
 */
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    if (sidebar) {
        sidebar.classList.toggle('show');
    }
}

/**
 * Add loading state to button
 * @param {HTMLElement} button - The button element
 * @param {boolean} isLoading - Whether the button is in loading state
 */
function toggleButtonLoading(button, isLoading) {
    if (isLoading) {
        const originalText = button.innerHTML;
        button.setAttribute('data-original-text', originalText);
        button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...';
        button.disabled = true;
    } else {
        const originalText = button.getAttribute('data-original-text');
        if (originalText) {
            button.innerHTML = originalText;
        }
        button.disabled = false;
    }
}
