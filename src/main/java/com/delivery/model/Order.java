package com.delivery.model;

public class Order {
    private int orderId;
    private int userId;
    private int restaurantId;
    private double totalPrice;
    private String deliveryAddress;
    private String paymentMethod;
    private String status;
    private String createdAt;
    
    public Order() {
    }
    
    public Order(int orderId, int userId, int restaurantId, double totalPrice, 
                 String deliveryAddress, String paymentMethod, String status, String createdAt) {
        this.orderId = orderId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.totalPrice = totalPrice;
        this.deliveryAddress = deliveryAddress;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.createdAt = createdAt;
    }
    
    // Getters
    public int getOrderId() { return orderId; }
    public int getUserId() { return userId; }
    public int getRestaurantId() { return restaurantId; }
    public double getTotalPrice() { return totalPrice; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public String getPaymentMethod() { return paymentMethod; }
    public String getStatus() { return status; }
    public String getCreatedAt() { return createdAt; }
    
    // Setters
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
