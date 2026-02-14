package com.delivery.servlet;

import com.delivery.dao_impl.UserDAOImpl;
import com.delivery.model.User;
import javax.servlet.*;
import javax.servlet.http.*;

public class ProfileServlet extends HttpServlet {
    private UserDAOImpl userDAO = new UserDAOImpl();
    
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
        User user = userDAO.getUserById(userId);
        
        request.setAttribute("user", user);
        
        try {
            request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        
        int userId = (int) session.getAttribute("userId");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        
        User user = userDAO.getUserById(userId);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setCity(city);
        user.setPincode(pincode);
        
        if (userDAO.updateUser(user)) {
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile!");
        }
        
        request.setAttribute("user", user);
        
        try {
            request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
