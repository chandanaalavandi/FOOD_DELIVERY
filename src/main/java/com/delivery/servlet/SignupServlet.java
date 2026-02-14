package com.delivery.servlet;

import com.delivery.dao_impl.UserDAOImpl;
import com.delivery.model.User;
import javax.servlet.*;
import javax.servlet.http.*;

public class SignupServlet extends HttpServlet {
    private UserDAOImpl userDAO = new UserDAOImpl();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        
        // Validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            try {
                request.getRequestDispatcher("/jsp/signup.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        
        // Check if user already exists
        if (userDAO.checkUserExists(username, email)) {
            request.setAttribute("error", "Username or Email already exists!");
            try {
                request.getRequestDispatcher("/jsp/signup.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        
        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        
        if (userDAO.addUser(user)) {
            request.setAttribute("success", "Signup successful! Please login.");
            try {
                request.getRequestDispatcher("/jsp/signup.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            request.setAttribute("error", "Signup failed. Please try again!");
            try {
                request.getRequestDispatcher("/jsp/signup.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
