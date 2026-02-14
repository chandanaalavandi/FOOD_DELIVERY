<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed - Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/success.css">
</head>
<body>
    <div class="success-container">
        <div class="success-card">
            <div class="success-icon">✓</div>
            <h1>Order Placed Successfully!</h1>
            <p>Your order has been confirmed.</p>
            
            <%
                Integer orderId = (Integer) session.getAttribute("orderId");
                if (orderId != null) {
            %>
                <p>Order ID: #<%=orderId%></p>
            <%
                }
            %>
            
            <div class="success-buttons">
                <a href="${pageContext.request.contextPath}/servlet/orderhistory" class="btn btn-primary">View Order History</a>
                <a href="${pageContext.request.contextPath}/servlet/RestaurantServlet" class="btn btn-secondary">Order Again</a>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/static/js/ui.js"></script>
</body>
</html>
