package com.delivery.dao;

import com.delivery.model.Menu;
import java.util.List;

public interface MenuDAO {
    Menu getMenuById(int menuId);
    List<Menu> getMenuByRestaurantId(int restaurantId);
    List<Menu> getAllMenuItems();
    boolean addMenu(Menu menu);
    boolean updateMenu(Menu menu);
    boolean deleteMenu(int menuId);
}
