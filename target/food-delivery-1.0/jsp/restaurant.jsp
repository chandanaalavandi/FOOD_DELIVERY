<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.delivery.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurants - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/restaurant.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1 class="logo">🍕 Food Delivery</h1>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/servlet/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/orderhistory">Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/logout">Logout</a></li>
                <li><button id="darkModeToggle" class="dark-mode-btn">🌙</button></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <h2>Select a Restaurant</h2>
        <div class="restaurants-grid">
            <%
                List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
                if (restaurants != null && !restaurants.isEmpty()) {
                    for (Restaurant rest : restaurants) {
            %>
                <div class="restaurant-card">
                    <img class="responsive-img" loading="lazy" src="${pageContext.request.contextPath}/static/images/Restaurants/<%=rest.getImageUrl().substring(rest.getImageUrl().lastIndexOf('/')+1)%>" alt="<%=rest.getName()%>">
                    <div class="restaurant-info">
                        <h3><%=rest.getName()%></h3>
                        <p class="cuisine"><%=rest.getCuisine()%></p>
                        <div class="restaurant-meta">
                            <span class="rating">⭐ <%=rest.getRating()%></span>
                            <span class="eta">🚴 <%=rest.getEta()%> mins</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/servlet/menu?restaurantId=<%=rest.getRestaurantId()%>" class="btn btn-primary">View Menu</a>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/static/js/ui.js"></script>
</body>
</html>
