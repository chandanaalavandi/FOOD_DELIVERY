package com.delivery.dao;

import com.delivery.model.User;

public interface UserDAO {
    User getUserById(int userId);
    User getUserByUsername(String username);
    User getUserByEmail(String email);
    boolean addUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int userId);
    boolean checkUserExists(String username, String email);
}
