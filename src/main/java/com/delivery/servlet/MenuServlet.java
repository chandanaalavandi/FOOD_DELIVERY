package com.delivery.servlet;

import com.delivery.dao_impl.MenuDAOImpl;
import com.delivery.dao_impl.RestaurantDAOImpl;
import com.delivery.model.Menu;
import com.delivery.model.Restaurant;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.List;

public class MenuServlet extends HttpServlet {
    private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
    private MenuDAOImpl menuDAO = new MenuDAOImpl();
    
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
        
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        
        // Store restaurantId in session for use in cart/checkout pages
        session.setAttribute("restaurantId", restaurantId);
        
        Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
        List<Menu> menus = menuDAO.getMenuByRestaurantId(restaurantId);
        
        request.setAttribute("restaurant", restaurant);
        request.setAttribute("menus", menus);
        
        try {
            request.getRequestDispatcher("/jsp/menu.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
