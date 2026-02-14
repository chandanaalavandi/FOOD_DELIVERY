package com.delivery.model;

public class CartItem {
    private int menuId;
    private String itemName;
    private double price;
    private int quantity;
    private String imageUrl;
    
    public CartItem() {
    }
    
    public CartItem(int menuId, String itemName, double price, int quantity, String imageUrl) {
        this.menuId = menuId;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
    }
    
    // Getters
    public int getMenuId() { return menuId; }
    public String getItemName() { return itemName; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public String getImageUrl() { return imageUrl; }
    public double getTotalPrice() { return price * quantity; }
    
    // Setters
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setPrice(double price) { this.price = price; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
