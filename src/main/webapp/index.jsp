<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
</head>
<body>
    <% 
        if (session.getAttribute("userId") != null) {
            response.sendRedirect("servlet/RestaurantServlet");
        } else {
            response.sendRedirect("jsp/signin.jsp");
        }
    %>
</body>
</html>
