<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.delivery.model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/orderhistory.css">
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
        <h2>Your Orders</h2>
        
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
        %>
        
        <% if (orders != null && !orders.isEmpty()) { %>
            <div class="orders-list">
                <%
                    for (Order order : orders) {
                %>
                    <div class="order-card">
                        <div class="order-header">
                            <h3>Order #<%=order.getOrderId()%></h3>
                            <span class="order-status <%=order.getStatus().toLowerCase()%>"><%=order.getStatus()%></span>
                        </div>
                        <div class="order-details">
                            <p><strong>Date:</strong> <%=order.getCreatedAt()%></p>
                            <p><strong>Total:</strong> ₹<%=order.getTotalPrice()%></p>
                            <p><strong>Address:</strong> <%=order.getDeliveryAddress()%></p>
                            <p><strong>Payment:</strong> <%=order.getPaymentMethod()%></p>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        <% } else { %>
            <div class="no-orders">
                <p>No orders placed yet!</p>
                <a href="${pageContext.request.contextPath}/servlet/RestaurantServlet" class="btn btn-primary">Start Ordering</a>
            </div>
        <% } %>
    </div>
    
    <script src="${pageContext.request.contextPath}/static/js/ui.js"></script>
</body>
</html>
