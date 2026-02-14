<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.delivery.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/checkout.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1 class="logo">🍕 Food Delivery</h1>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/servlet/RestaurantServlet">Restaurants</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/cart">🛒 Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/logout">Logout</a></li>
                <li><button id="darkModeToggle" class="dark-mode-btn">🌙</button></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <h2>Place Your Order</h2>
        
        <%
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            double totalPrice = 0;
            int restaurantId = (Integer) (session.getAttribute("restaurantId") != null ? session.getAttribute("restaurantId") : 1);
            if (cart != null) {
                for (CartItem item : cart.values()) {
                    totalPrice += item.getTotalPrice();
                }
            }
        %>
        
        <div class="checkout-content">
            <div class="checkout-form">
                <form method="POST" action="${pageContext.request.contextPath}/servlet/checkout">
                    <h3>Delivery Address</h3>
                    <div class="form-group">
                        <label for="address">Street Address</label>
                        <textarea id="address" name="address" required></textarea>
                    </div>
                    
                    <h3>Payment Method</h3>
                    <div class="form-group">
                        <label><input type="radio" name="paymentMethod" value="Cash on Delivery" checked> Cash on Delivery</label>
                    </div>
                    
                    <input type="hidden" name="restaurantId" value="<%=restaurantId%>">
                    <button type="submit" class="btn btn-primary btn-large">Place Order</button>
                </form>
            </div>
            
            <div class="order-summary">
                <h3>Order Summary</h3>
                <div class="summary-items">
                    <%
                        if (cart != null && !cart.isEmpty()) {
                            for (CartItem item : cart.values()) {
                    %>
                        <div class="summary-item">
                            <span><%=item.getItemName()%> x <%=item.getQuantity()%></span>
                            <span>₹<%=item.getTotalPrice()%></span>
                        </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="summary-total">
                    <h4>Total: ₹<%=totalPrice%></h4>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/static/js/ui.js"></script>
</body>
</html>
