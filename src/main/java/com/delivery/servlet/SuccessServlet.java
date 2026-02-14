package com.delivery.servlet;

import javax.servlet.*;
import javax.servlet.http.*;

public class SuccessServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        
        // Check if user has just completed an order
        if (session.getAttribute("userId") == null) {
            try {
                response.sendRedirect(request.getContextPath() + "/servlet/signin");
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        
        // Forward to success page
        try {
            request.getRequestDispatcher("/jsp/success.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
