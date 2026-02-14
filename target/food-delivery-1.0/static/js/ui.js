// Dark Mode Toggle
document.addEventListener('DOMContentLoaded', function() {
    const darkModeToggle = document.getElementById('darkModeToggle');
    
    if (darkModeToggle) {
        // Check if user has previously enabled dark mode
        const isDarkMode = localStorage.getItem('darkMode') === 'true';
        
        if (isDarkMode) {
            document.body.classList.add('dark-mode');
            darkModeToggle.textContent = '☀️';
        }
        
        darkModeToggle.addEventListener('click', function() {
            document.body.classList.toggle('dark-mode');
            const isNowDarkMode = document.body.classList.contains('dark-mode');
            localStorage.setItem('darkMode', isNowDarkMode);
            
            // Update icon
            darkModeToggle.textContent = isNowDarkMode ? '☀️' : '🌙';
        });
    }
});

// Add to Cart Animation
document.addEventListener('DOMContentLoaded', function() {
    const addToCartForms = document.querySelectorAll('.add-to-cart-form');
    
    addToCartForms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const button = this.querySelector('.add-to-cart-btn');
            const originalText = button.textContent;
            
            // Show feedback
            button.textContent = '✓ Added!';
            button.style.backgroundColor = 'var(--success-color)';
            
            // Submit form after animation
            setTimeout(() => {
                this.submit();
            }, 500);
        });
    });
});

// Smooth scroll behavior
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// Form validation
function validateForm(form) {
    const inputs = form.querySelectorAll('input[required], textarea[required]');
    let isValid = true;
    
    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.style.borderColor = 'var(--error-color)';
            isValid = false;
        } else {
            input.style.borderColor = '';
        }
    });
    
    return isValid;
}

// Add ripple effect to buttons
document.querySelectorAll('.btn').forEach(button => {
    button.addEventListener('click', function(e) {
        const ripple = document.createElement('span');
        const rect = this.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = e.clientX - rect.left - size / 2;
        const y = e.clientY - rect.top - size / 2;
        
        ripple.style.width = ripple.style.height = size + 'px';
        ripple.style.left = x + 'px';
        ripple.style.top = y + 'px';
        ripple.classList.add('ripple');
        
        this.appendChild(ripple);
        
        setTimeout(() => ripple.remove(), 600);
    });
});

// Ripple effect CSS injection
const style = document.createElement('style');
style.textContent = `
    .btn {
        position: relative;
        overflow: hidden;
    }
    
    .ripple {
        position: absolute;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.6);
        transform: scale(0);
        animation: ripple-animation 0.6s ease-out;
        pointer-events: none;
    }
    
    @keyframes ripple-animation {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Page restoration on back/forward - remove loaders and restore content
window.addEventListener('pageshow', function(event) {
    // Force entire page to be visible
    document.body.style.cssText = 'opacity: 1 !important; visibility: visible !important; display: block !important; pointer-events: auto !important;';
    document.documentElement.style.cssText = 'opacity: 1 !important; visibility: visible !important;';
    
    // **CRITICAL**: Remove ALL possible overlay elements
    // Remove by class name
    document.querySelectorAll('.page-loader, .loading-overlay, [class*="loader"], [class*="overlay"], [class*="modal-backdrop"]').forEach(function(el) {
        if (el && el.parentNode) el.remove();
    });
    
    // Remove any div or element that might be a full-page overlay
    // Look for elements with high z-index and large dimensions positioned fixed
    Array.from(document.querySelectorAll('*')).forEach(function(el) {
        try {
            const style = window.getComputedStyle(el);
            const zIndex = parseInt(style.zIndex) || 0;
            const position = style.position;
            const backgroundColor = style.backgroundColor;
            
            // If it's a fixed element with high z-index and white-ish background, it's likely a loader
            if (position === 'fixed' && zIndex > 999) {
                // Check if it has a light/white background (matches rgba(255,255,255,*))
                if (backgroundColor.includes('rgb(255') || backgroundColor.includes('rgba(255') || backgroundColor === 'rgba(0, 0, 0, 0)') {
                    const opacity = parseFloat(style.opacity) || 1;
                    if (opacity > 0.3) {
                        el.remove();
                    }
                }
            }
        } catch (e) {
            // Skip elements that throw errors
        }
    });
    
    // Ensure all main content is visible
    document.querySelectorAll('main, section, .container, [role="main"]').forEach(function(el) {
        el.style.opacity = '1';
        el.style.visibility = 'visible';
        el.style.pointerEvents = 'auto';
    });

    // Re-observe lazy images that didn't load yet (back/forward navigation)
    if ('IntersectionObserver' in window && typeof imageObserver !== 'undefined') {
        document.querySelectorAll('img[data-src]').forEach(function(img) {
            if (!img.classList.contains('loaded')) {
                try { imageObserver.observe(img); } catch (e) { /* ignore */ }
            }
        });
    }

    // Re-observe animated cards in case they were restored from bfcache
    document.querySelectorAll('.restaurant-card, .menu-card, .order-card, .cart-item').forEach(function(card) {
        if (!card.dataset.observed) {
            try { observer.observe(card); card.dataset.observed = 'true'; } catch (e) {}
        }
    });

    // Re-highlight active link
    try { highlightActiveLink(); } catch (e) {}
});

// Also clean up on DOMContentLoaded as a fallback and periodic cleanup
function cleanupOverlays() {
    // Remove common overlay selectors
    document.querySelectorAll('.page-loader, .loading-overlay, [class*="loader"], [class*="overlay"], [class*="modal-backdrop"]').forEach(function(el) {
        if (el && el.parentNode) el.remove();
    });
}

document.addEventListener('DOMContentLoaded', function() {
    cleanupOverlays();
    
    // Also clean up after a short delay in case overlays are added during page rendering
    setTimeout(cleanupOverlays, 100);
    setTimeout(cleanupOverlays, 500);
    setTimeout(cleanupOverlays, 1000);
});

// Intersection Observer for fade-in animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver(function(entries) {
    entries.forEach((entry, idx) => {
        if (entry.isIntersecting) {
            // Add a visible class and stagger based on vertical position
            const delay = (entry.target.dataset.stagger || (idx * 80)) + 'ms';
            entry.target.style.transitionDelay = delay;
            entry.target.classList.add('visible');
            try { observer.unobserve(entry.target); } catch (e) {}
        }
    });
}, observerOptions);

// Add fade-in animation CSS
const fadeInStyle = document.createElement('style');
fadeInStyle.textContent = `
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .restaurant-card,
    .menu-card,
    .order-card,
    .cart-item {
        opacity: 0;
        animation: fadeInUp 0.6s ease-out forwards;
    }
`;
document.head.appendChild(fadeInStyle);

// Observe cards
document.querySelectorAll('.restaurant-card, .menu-card, .order-card, .cart-item').forEach(card => {
    // store a stagger value based on position for nicer effect
    const rect = card.getBoundingClientRect();
    card.dataset.stagger = Math.max(0, Math.round((rect.top % 500) / 2));
    observer.observe(card);
});

// Add-to-cart micro animation: floating dot flying to cart icon
document.querySelectorAll('.add-to-cart-btn').forEach(btn => {
    btn.addEventListener('click', function(e) {
        const rect = this.getBoundingClientRect();
        const dot = document.createElement('div');
        dot.style.cssText = `position:fixed; left:${rect.left + rect.width/2}px; top:${rect.top + rect.height/2}px; width:14px; height:14px; border-radius:50%; background: radial-gradient(circle at 30% 30%, #fff, ${getComputedStyle(document.documentElement).getPropertyValue('--primary-color') || '#FF6B35'}); z-index:1200; pointer-events:none; transform: translate(-50%,-50%) scale(1); transition: transform 0.9s cubic-bezier(.2,1,.22,1), opacity 0.9s;`;
        document.body.appendChild(dot);

        // find cart icon position (fallback to top-right)
        const cartIcon = document.querySelector('.nav-links .cart-icon') || document.querySelector('.floating-cart') || null;
        let destX = window.innerWidth - 48;
        let destY = 28;
        if (cartIcon) {
            const cRect = cartIcon.getBoundingClientRect();
            destX = cRect.left + cRect.width/2;
            destY = cRect.top + cRect.height/2;
        }

        requestAnimationFrame(() => {
            dot.style.transform = `translate(${destX - (rect.left + rect.width/2)}px, ${destY - (rect.top + rect.height/2)}px) scale(0.2)`;
            dot.style.opacity = '0.0';
        });

        setTimeout(() => dot.remove(), 1000);
    });
});

// Notification system
function showNotification(message, type = 'success') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${type === 'success' ? 'var(--success-color)' : 'var(--error-color)'};
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 0.5rem;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        animation: slideInRight 0.3s ease-out;
        z-index: 1000;
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.animation = 'slideOutRight 0.3s ease-out forwards';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Add notification animations
const notificationStyle = document.createElement('style');
notificationStyle.textContent = `
    @keyframes slideInRight {
        from {
            opacity: 0;
            transform: translateX(100px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    @keyframes slideOutRight {
        from {
            opacity: 1;
            transform: translateX(0);
        }
        to {
            opacity: 0;
            transform: translateX(100px);
        }
    }
`;
document.head.appendChild(notificationStyle);

// Prevent form resubmission on page refresh
document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function() {
        this.style.opacity = '0.6';
        this.style.pointerEvents = 'none';
    });
});

// Loading indicator for slow connections
// Disabled: The automatic page-loader blocks back/forward navigation in browsers with bfcache
// Instead, rely on the native browser loading state and pageshow event cleanup

// Keyboard shortcuts
document.addEventListener('keydown', function(e) {
    // ESC to close modals or navigate back
    if (e.key === 'Escape') {
        const element = document.querySelector('.modal');
        if (element) {
            element.style.display = 'none';
        }
    }
    
    // Home key to scroll to top
    if (e.key === 'Home') {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
});

// Lazy loading for images
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src || img.src;
                img.classList.add('loaded');
                imageObserver.unobserve(img);
            }
        });
    });
    
    document.querySelectorAll('img[data-src]').forEach(img => imageObserver.observe(img));
}

// Active link highlighting
function highlightActiveLink() {
    const currentPage = window.location.pathname;
    document.querySelectorAll('.nav-links a').forEach(link => {
        if (link.pathname === currentPage) {
            link.style.opacity = '0.7';
            link.style.fontWeight = 'bold';
        }
    });
}

document.addEventListener('DOMContentLoaded', highlightActiveLink);

// Print-friendly styles
window.addEventListener('beforeprint', function() {
    document.body.style.backgroundColor = 'white';
    document.querySelectorAll('.navbar').forEach(nav => nav.style.display = 'none');
});

window.addEventListener('afterprint', function() {
    location.reload();
});
