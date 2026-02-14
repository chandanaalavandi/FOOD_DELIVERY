package com.delivery.dao;

import com.delivery.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    OrderItem getOrderItemById(int orderItemId);
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    boolean addOrderItem(OrderItem orderItem);
    boolean deleteOrderItem(int orderItemId);
}
