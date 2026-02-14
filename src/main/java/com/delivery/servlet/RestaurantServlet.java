package com.delivery.servlet;

import com.delivery.dao_impl.RestaurantDAOImpl;
import com.delivery.model.Restaurant;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.List;

public class RestaurantServlet extends HttpServlet {
    private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        if (session.getAttribute("userId") == null) {
            try {
                response.sendRedirect(request.getContextPath() + "/jsp/signin.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        
        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
        request.setAttribute("restaurants", restaurants);
        
        try {
            request.getRequestDispatcher("/jsp/restaurant.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
