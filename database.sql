-- ==============================
-- FOOD DELIVERY APPLICATION
-- MySQL Database Schema
-- ==============================

-- Drop and Create Database
DROP DATABASE IF EXISTS food_delivery;
CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;

-- ==============================
-- USERS TABLE
-- ==============================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    pincode VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- RESTAURANTS TABLE
-- ==============================
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(100),
    rating DECIMAL(3,2) DEFAULT 4.5,
    eta INT DEFAULT 30,
    image_url VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- MENU TABLE
-- ==============================
CREATE TABLE menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 4.0,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

-- ==============================
-- ORDERS TABLE
-- ==============================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

-- ==============================
-- ORDER_ITEMS TABLE
-- ==============================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE
);

-- ==============================
-- SAMPLE DATA - USERS
-- ==============================
INSERT INTO users (username, email, password, phone, address, city, pincode) VALUES
('john_doe', 'john@example.com', 'password123', '9876543210', '123 Street, Apt 4', 'Delhi', '110001'),
('jane_smith', 'jane@example.com', 'password123', '8765432109', '456 Avenue, Apt 5', 'Bangalore', '560001'),
('mike_johnson', 'mike@example.com', 'password123', '7654321098', '789 Road, Apt 6', 'Mumbai', '400001');

-- ==============================
-- SAMPLE DATA - RESTAURANTS
-- ==============================
INSERT INTO restaurants (name, cuisine, rating, eta, image_url, address, phone) VALUES
('Infinity', 'Indian', 4.8, 25, '/images/Restaurants/infinity.png', '100 Food Street', '9111111111'),
('Rangrezza', 'Multi-Cuisine', 4.6, 30, '/images/Restaurants/Rangrezza.png', '200 Taste Avenue', '9222222222'),
('SALT', 'Continental', 4.7, 35, '/images/Restaurants/SALT.png', '300 Flavor Lane', '9333333333'),
('Sky House', 'Fusion', 4.5, 28, '/images/Restaurants/sky-house.png', '400 Blend Road', '9444444444');

-- ==============================
-- SAMPLE DATA - MENU ITEMS
-- ==============================
INSERT INTO menu (restaurant_id, item_name, price, description, rating, image_url) VALUES
-- Infinity Restaurant (ID: 1)
(1, 'Butter Chicken', 350.00, 'Creamy butter chicken curry', 4.8, '/images/menu/butter-chicken.png'),
(1, 'Paneer Tikka', 280.00, 'Chargrilled paneer pieces', 4.7, '/images/menu/paneer-tikka.png'),
(1, 'Biryani', 320.00, 'Fragrant basmati rice', 4.6, '/images/menu/biryani.png'),
(1, 'Lassi', 80.00, 'Sweet yogurt beverage', 4.5, '/images/menu/lassi.png'),

-- Rangrezza Restaurant (ID: 2)
(2, 'Dosa', 150.00, 'Crispy South Indian dosa', 4.7, '/images/menu/dosa.png'),
(2, 'Uttapam', 140.00, 'Soft Indian pancake with toppings', 4.6, '/images/menu/uttapam.png'),
(2, 'Vada', 110.00, 'Crispy deep-fried savory snack', 4.7, '/images/menu/vada.png'),
(2, 'Rasam', 90.00, 'Tangy aromatic spiced soup', 4.6, '/images/menu/rasam.png'),

-- SALT Restaurant (ID: 3)
(3, 'Pasta', 280.00, 'Italian pasta carbonara', 4.6, '/images/menu/pasta.png'),
(3, 'Pizza', 350.00, 'Wood-fired pizzas', 4.7, '/images/menu/pizza.png'),
(3, 'Risotto', 320.00, 'Creamy arborio risotto', 4.5, '/images/menu/risotto.png'),
(3, 'Tiramisu', 200.00, 'Classic Italian dessert', 4.8, '/images/menu/tiramisu.png'),

-- Sky House Restaurant (ID: 4)
(4, 'Sushi', 450.00, 'Fresh sushi rolls', 4.7, '/images/menu/sushi.png'),
(4, 'Tempura', 380.00, 'Crispy battered vegetables', 4.6, '/images/menu/tempura.png'),
(4, 'Ramen', 320.00, 'Japanese noodle soup', 4.8, '/images/menu/ramen.png'),
(4, 'Mochi', 150.00, 'Sweet rice cake', 4.5, '/images/menu/mochi.png');

-- ==============================
-- NOTE: Orders and OrderItems will be created dynamically through the application
-- ==============================

-- ==============================
-- VERIFY TABLES
-- ==============================
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM restaurants;
SELECT * FROM menu;
