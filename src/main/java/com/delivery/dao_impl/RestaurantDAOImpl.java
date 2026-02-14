package com.delivery.dao_impl;

import com.delivery.dao.RestaurantDAO;
import com.delivery.model.Restaurant;
import com.delivery.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {
    
    @Override
    public Restaurant getRestaurantById(int restaurantId) {
        String query = "SELECT * FROM restaurants WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Restaurant(
                    rs.getInt("restaurant_id"),
                    rs.getString("name"),
                    rs.getString("cuisine"),
                    rs.getDouble("rating"),
                    rs.getInt("eta"),
                    rs.getString("image_url"),
                    rs.getString("address"),
                    rs.getString("phone")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String query = "SELECT * FROM restaurants";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                restaurants.add(new Restaurant(
                    rs.getInt("restaurant_id"),
                    rs.getString("name"),
                    rs.getString("cuisine"),
                    rs.getDouble("rating"),
                    rs.getInt("eta"),
                    rs.getString("image_url"),
                    rs.getString("address"),
                    rs.getString("phone")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }
    
    @Override
    public boolean addRestaurant(Restaurant restaurant) {
        String query = "INSERT INTO restaurants (name, cuisine, rating, eta, image_url, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisine());
            pstmt.setDouble(3, restaurant.getRating());
            pstmt.setInt(4, restaurant.getEta());
            pstmt.setString(5, restaurant.getImageUrl());
            pstmt.setString(6, restaurant.getAddress());
            pstmt.setString(7, restaurant.getPhone());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean updateRestaurant(Restaurant restaurant) {
        String query = "UPDATE restaurants SET name = ?, cuisine = ?, rating = ?, eta = ?, image_url = ?, address = ?, phone = ? WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getCuisine());
            pstmt.setDouble(3, restaurant.getRating());
            pstmt.setInt(4, restaurant.getEta());
            pstmt.setString(5, restaurant.getImageUrl());
            pstmt.setString(6, restaurant.getAddress());
            pstmt.setString(7, restaurant.getPhone());
            pstmt.setInt(8, restaurant.getRestaurantId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deleteRestaurant(int restaurantId) {
        String query = "DELETE FROM restaurants WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, restaurantId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
