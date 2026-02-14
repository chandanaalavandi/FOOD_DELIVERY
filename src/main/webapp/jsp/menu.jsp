<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.delivery.model.Menu, com.delivery.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/menu.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1 class="logo">🍕 Food Delivery</h1>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/servlet/RestaurantServlet">Restaurants</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/cart">🛒 Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/profile">Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/servlet/logout">Logout</a></li>
                <li><button id="darkModeToggle" class="dark-mode-btn">🌙</button></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <%
            Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
            List<Menu> menus = (List<Menu>) request.getAttribute("menus");
        %>
        
        <div class="restaurant-header">
            <img class="responsive-img" loading="lazy" src="${pageContext.request.contextPath}/static/images/Restaurants/<%=restaurant.getImageUrl().substring(restaurant.getImageUrl().lastIndexOf('/')+1)%>" alt="<%=restaurant.getName()%>">
            <div class="restaurant-details">
                <h1><%=restaurant.getName()%></h1>
                <p><%=restaurant.getCuisine()%> • ⭐ <%=restaurant.getRating()%> • 🚴 <%=restaurant.getEta()%> mins</p>
            </div>
        </div>
        
        <h2>Menu Items</h2>
        <div class="menu-grid">
            <%
                if (menus != null && !menus.isEmpty()) {
                    for (Menu menu : menus) {
            %>
                <div class="menu-card">
                    <img class="menu-thumb" loading="lazy" src="${pageContext.request.contextPath}/static/images/menu/<%=menu.getImageUrl().substring(menu.getImageUrl().lastIndexOf('/')+1)%>" alt="<%=menu.getItemName()%>">
                    <div class="menu-info">
                        <h3><%=menu.getItemName()%></h3>
                        <p><%=menu.getDescription()%></p>
                        <div class="menu-footer">
                            <span class="price">₹<%=menu.getPrice()%></span>
                            <span class="rating">⭐ <%=menu.getRating()%></span>
                        </div>
                        <form method="POST" action="${pageContext.request.contextPath}/servlet/cart" class="add-to-cart-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">
                            <input type="hidden" name="itemName" value="<%=menu.getItemName()%>">
                            <input type="hidden" name="price" value="<%=menu.getPrice()%>">
                            <input type="hidden" name="imageUrl" value="<%=menu.getImageUrl()%>">
                            <button type="submit" class="btn btn-success add-to-cart-btn">+ Add to Cart</button>
                        </form>
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
