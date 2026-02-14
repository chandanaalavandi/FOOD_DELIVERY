<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.delivery.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/profile.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1 class="logo">🍕 Food Delivery</h1>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/servlet/RestaurantServlet">Restaurants</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/orderhistory">Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/logout">Logout</a></li>
                <li><button id="darkModeToggle" class="dark-mode-btn">🌙</button></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <h2>My Profile</h2>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <%
            User user = (User) request.getAttribute("user");
            if (user != null) {
        %>
            <div class="profile-card">
                <form method="POST" action="${pageContext.request.contextPath}/servlet/profile">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="<%=user.getUsername()%>" disabled>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="<%=user.getEmail() != null ? user.getEmail() : ""%>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" value="<%=user.getPhone() != null ? user.getPhone() : ""%>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" required><%=user.getAddress() != null ? user.getAddress() : ""%></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" value="<%=user.getCity() != null ? user.getCity() : ""%>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="pincode">Pincode</label>
                        <input type="text" id="pincode" name="pincode" value="<%=user.getPincode() != null ? user.getPincode() : ""%>" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </form>
            </div>
        <%
            }
        %>
    </div>
    
    <script src="${pageContext.request.contextPath}/static/js/ui.js"></script>
</body>
</html>
