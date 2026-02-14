package com.delivery.dao;

import com.delivery.model.Order;
import java.util.List;

public interface OrderDAO {
    Order getOrderById(int orderId);
    List<Order> getOrdersByUserId(int userId);
    int addOrder(Order order);
    boolean updateOrderStatus(int orderId, String status);
    boolean deleteOrder(int orderId);
}
