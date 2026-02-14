package com.delivery.servlet;

import com.delivery.dao_impl.OrderDAOImpl;
import com.delivery.dao_impl.RestaurantDAOImpl;
import com.delivery.model.Order;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.List;

public class OrderHistoryServlet extends HttpServlet {
    private OrderDAOImpl orderDAO = new OrderDAOImpl();
    private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        
        if (session.getAttribute("userId") == null) {
            try {
                response.sendRedirect(request.getContextPath() + "/jsp/signin.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        List<Order> orders = orderDAO.getOrdersByUserId(userId);
        
        request.setAttribute("orders", orders);
        
        try {
            request.getRequestDispatcher("/jsp/orderhistory.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
