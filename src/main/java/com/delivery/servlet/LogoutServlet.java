package com.delivery.servlet;

import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        session.invalidate();
        try {
            response.sendRedirect(request.getContextPath() + "/jsp/signin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
