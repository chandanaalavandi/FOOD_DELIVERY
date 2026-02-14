package com.delivery.model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String cuisine;
    private double rating;
    private int eta;
    private String imageUrl;
    private String address;
    private String phone;
    
    public Restaurant() {
    }
    
    public Restaurant(int restaurantId, String name, String cuisine, double rating, 
                     int eta, String imageUrl, String address, String phone) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.cuisine = cuisine;
        this.rating = rating;
        this.eta = eta;
        this.imageUrl = imageUrl;
        this.address = address;
        this.phone = phone;
    }
    
    // Getters
    public int getRestaurantId() { return restaurantId; }
    public String getName() { return name; }
    public String getCuisine() { return cuisine; }
    public double getRating() { return rating; }
    public int getEta() { return eta; }
    public String getImageUrl() { return imageUrl; }
    public String getAddress() { return address; }
    public String getPhone() { return phone; }
    
    // Setters
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public void setName(String name) { this.name = name; }
    public void setCuisine(String cuisine) { this.cuisine = cuisine; }
    public void setRating(double rating) { this.rating = rating; }
    public void setEta(int eta) { this.eta = eta; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setAddress(String address) { this.address = address; }
    public void setPhone(String phone) { this.phone = phone; }
}
