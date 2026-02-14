package com.delivery.model;

public class Menu {
    private int menuId;
    private int restaurantId;
    private String itemName;
    private double price;
    private String description;
    private double rating;
    private String imageUrl;
    
    public Menu() {
    }
    
    public Menu(int menuId, int restaurantId, String itemName, double price, 
                String description, double rating, String imageUrl) {
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.price = price;
        this.description = description;
        this.rating = rating;
        this.imageUrl = imageUrl;
    }
    
    // Getters
    public int getMenuId() { return menuId; }
    public int getRestaurantId() { return restaurantId; }
    public String getItemName() { return itemName; }
    public double getPrice() { return price; }
    public String getDescription() { return description; }
    public double getRating() { return rating; }
    public String getImageUrl() { return imageUrl; }
    
    // Setters
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setPrice(double price) { this.price = price; }
    public void setDescription(String description) { this.description = description; }
    public void setRating(double rating) { this.rating = rating; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
