package com.delivery.dao;

import com.delivery.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {
    Restaurant getRestaurantById(int restaurantId);
    List<Restaurant> getAllRestaurants();
    boolean addRestaurant(Restaurant restaurant);
    boolean updateRestaurant(Restaurant restaurant);
    boolean deleteRestaurant(int restaurantId);
}
