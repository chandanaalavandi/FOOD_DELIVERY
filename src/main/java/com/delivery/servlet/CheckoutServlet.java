package com.delivery.servlet;

import com.delivery.dao_impl.RestaurantDAOImpl;
import com.delivery.dao_impl.OrderDAOImpl;
import com.delivery.dao_impl.OrderItemDAOImpl;
import com.delivery.model.CartItem;
import com.delivery.model.Order;
import com.delivery.model.OrderItem;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Map;

public class CheckoutServlet extends HttpServlet {
    private OrderDAOImpl orderDAO = new OrderDAOImpl();
    private OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException {
        HttpSession session = request.getSession();
        
        int userId = (int) session.getAttribute("userId");
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Store restaurantId in session for navigation purposes
        session.setAttribute("restaurantId", restaurantId);
        
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Cart is empty!");
            try {
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        
        // Calculate total
        double totalPrice = 0;
        for (CartItem item : cart.values()) {
            totalPrice += item.getTotalPrice();
        }
        
        // Create order
        Order order = new Order();
        order.setUserId(userId);
        order.setRestaurantId(restaurantId);
        order.setTotalPrice(totalPrice);
        order.setDeliveryAddress(address);
        order.setPaymentMethod(paymentMethod);
        
        int orderId = orderDAO.addOrder(order);
        
        if (orderId > 0) {
            // Add order items
            for (CartItem item : cart.values()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setMenuId(item.getMenuId());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setPrice(item.getPrice());
                orderItemDAO.addOrderItem(orderItem);
            }
            
            // Clear cart
            cart.clear();
            session.setAttribute("orderId", orderId);
            
            // Redirect to success servlet (not JSP)
            try {
                response.sendRedirect(request.getContextPath() + "/servlet/success");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            request.setAttribute("error", "Checkout failed. Please try again!");
            try {
                request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
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
            request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
