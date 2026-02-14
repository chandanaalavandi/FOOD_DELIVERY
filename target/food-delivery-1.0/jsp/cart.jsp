<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.delivery.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/cart.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1 class="logo">🍕 Food Delivery</h1>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/servlet/RestaurantServlet">Restaurants</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/logout">Logout</a></li>
                <li><button id="darkModeToggle" class="dark-mode-btn">🌙</button></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <h2>Your Cart</h2>
        
        <%
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            double totalPrice = 0;
        %>
        
        <% if (cart != null && !cart.isEmpty()) { %>
            <div class="cart-items">
                <%
                    for (CartItem item : cart.values()) {
                        totalPrice += item.getTotalPrice();
                %>
                    <div class="cart-item">
                        <img class="cart-thumb" loading="lazy" src="${pageContext.request.contextPath}/static/images/menu/<%=item.getImageUrl().substring(item.getImageUrl().lastIndexOf('/')+1)%>" alt="<%=item.getItemName()%>">
                        <div class="item-details">
                            <h3><%=item.getItemName()%></h3>
                            <p>₹<%=item.getPrice()%> each</p>
                        </div>
                        <div class="item-quantity">
                            <form method="POST" action="${pageContext.request.contextPath}/servlet/cart" style="display: inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="menuId" value="<%=item.getMenuId()%>">
                                <input type="number" name="quantity" value="<%=item.getQuantity()%>" min="1">
                                <button type="submit" class="btn btn-small">Update</button>
                            </form>
                        </div>
                        <div class="item-price">
                            <p>₹<%=item.getTotalPrice()%></p>
                        </div>
                        <form method="POST" action="${pageContext.request.contextPath}/servlet/cart" style="display: inline;">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="menuId" value="<%=item.getMenuId()%>">
                            <button type="submit" class="btn btn-danger">Remove</button>
                        </form>
                    </div>
                <%
                    }
                %>
            </div>
            
            <div class="cart-summary">
                <h3>Total Price: ₹<%=totalPrice%></h3>
                <form method="GET" action="${pageContext.request.contextPath}/servlet/checkout">
                    <input type="hidden" name="total" value="<%=totalPrice%>">
                    <input type="hidden" name="restaurantId" value="<%=session.getAttribute("restaurantId") != null ? session.getAttribute("restaurantId") : "1"%>">
                    <button type="submit" class="btn btn-primary btn-large">Proceed to Checkout</button>
                </form>
            </div>
        <% } else { %>
            <div class="empty-cart">
                <p>Your cart is empty!</p>
                <a href="${pageContext.request.contextPath}/servlet/RestaurantServlet" class="btn btn-primary">Continue Shopping</a>
            </div>
        <% } %>
    </div>
    
    <script src="${pageContext.request.contextPath}/static/js/ui.js"></script>
</body>
</html>
