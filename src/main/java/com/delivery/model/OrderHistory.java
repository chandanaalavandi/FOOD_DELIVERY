package com.delivery.model;

import java.util.ArrayList;
import java.util.List;

public class OrderHistory {
    private int orderId;
    private String restaurantName;
    private double totalPrice;
    private String status;
    private String createdAt;
    private List<OrderItem> items;
    
    public OrderHistory() {
        this.items = new ArrayList<>();
    }
    
    public OrderHistory(int orderId, String restaurantName, double totalPrice, String status, String createdAt) {
        this.orderId = orderId;
        this.restaurantName = restaurantName;
        this.totalPrice = totalPrice;
        this.status = status;
        this.createdAt = createdAt;
        this.items = new ArrayList<>();
    }
    
    // Getters
    public int getOrderId() { return orderId; }
    public String getRestaurantName() { return restaurantName; }
    public double getTotalPrice() { return totalPrice; }
    public String getStatus() { return status; }
    public String getCreatedAt() { return createdAt; }
    public List<OrderItem> getItems() { return items; }
    
    // Setters
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public void setRestaurantName(String restaurantName) { this.restaurantName = restaurantName; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    public void setItems(List<OrderItem> items) { this.items = items; }
    
    public void addItem(OrderItem item) {
        this.items.add(item);
    }
}
