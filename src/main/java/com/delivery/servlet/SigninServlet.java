package com.delivery.servlet;

import com.delivery.dao_impl.UserDAOImpl;
import com.delivery.model.User;
import javax.servlet.*;
import javax.servlet.http.*;

public class SigninServlet extends HttpServlet {
    private UserDAOImpl userDAO = new UserDAOImpl();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDAO.getUserByUsername(username);
        
        if (user != null && user.getPassword().equals(password)) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("email", user.getEmail());
            
            try {
                response.sendRedirect(request.getContextPath() + "/servlet/RestaurantServlet");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            request.setAttribute("error", "Invalid username or password!");
            try {
                request.getRequestDispatcher("/jsp/signin.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
