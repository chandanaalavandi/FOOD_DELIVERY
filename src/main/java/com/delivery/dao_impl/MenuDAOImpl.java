package com.delivery.dao_impl;

import com.delivery.dao.MenuDAO;
import com.delivery.model.Menu;
import com.delivery.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {
    
    @Override
    public Menu getMenuById(int menuId) {
        String query = "SELECT * FROM menu WHERE menu_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, menuId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Menu(
                    rs.getInt("menu_id"),
                    rs.getInt("restaurant_id"),
                    rs.getString("item_name"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    rs.getDouble("rating"),
                    rs.getString("image_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Menu> getMenuByRestaurantId(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        String query = "SELECT * FROM menu WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                menus.add(new Menu(
                    rs.getInt("menu_id"),
                    rs.getInt("restaurant_id"),
                    rs.getString("item_name"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    rs.getDouble("rating"),
                    rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }
    
    @Override
    public List<Menu> getAllMenuItems() {
        List<Menu> menus = new ArrayList<>();
        String query = "SELECT * FROM menu";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                menus.add(new Menu(
                    rs.getInt("menu_id"),
                    rs.getInt("restaurant_id"),
                    rs.getString("item_name"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    rs.getDouble("rating"),
                    rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }
    
    @Override
    public boolean addMenu(Menu menu) {
        String query = "INSERT INTO menu (restaurant_id, item_name, price, description, rating, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setDouble(3, menu.getPrice());
            pstmt.setString(4, menu.getDescription());
            pstmt.setDouble(5, menu.getRating());
            pstmt.setString(6, menu.getImageUrl());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean updateMenu(Menu menu) {
        String query = "UPDATE menu SET restaurant_id = ?, item_name = ?, price = ?, description = ?, rating = ?, image_url = ? WHERE menu_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setDouble(3, menu.getPrice());
            pstmt.setString(4, menu.getDescription());
            pstmt.setDouble(5, menu.getRating());
            pstmt.setString(6, menu.getImageUrl());
            pstmt.setInt(7, menu.getMenuId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deleteMenu(int menuId) {
        String query = "DELETE FROM menu WHERE menu_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, menuId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
