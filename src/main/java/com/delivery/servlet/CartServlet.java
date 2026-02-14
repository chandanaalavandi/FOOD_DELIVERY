package com.delivery.servlet;

import com.delivery.model.CartItem;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.HashMap;
import java.util.Map;

public class CartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        
        String action = request.getParameter("action");
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        
        // Get or create cart
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        
        if ("add".equals(action)) {
            String itemName = request.getParameter("itemName");
            double price = Double.parseDouble(request.getParameter("price"));
            String imageUrl = request.getParameter("imageUrl");
            
            if (cart.containsKey(menuId)) {
                CartItem item = cart.get(menuId);
                item.setQuantity(item.getQuantity() + 1);
            } else {
                cart.put(menuId, new CartItem(menuId, itemName, price, 1, imageUrl));
            }
        } else if ("remove".equals(action)) {
            cart.remove(menuId);
        } else if ("update".equals(action)) {
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            if (cart.containsKey(menuId)) {
                if (quantity > 0) {
                    cart.get(menuId).setQuantity(quantity);
                } else {
                    cart.remove(menuId);
                }
            }
        } else if ("clear".equals(action)) {
            cart.clear();
        }
        
        try {
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
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
        
        try {
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
