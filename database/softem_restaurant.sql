-- ============================================================
--  SOFTEM RESTAURANT — MySQL / MariaDB import file
-- ------------------------------------------------------------
--  XAMPP (phpMyAdmin):
--    1. Start Apache and MySQL in the XAMPP Control Panel.
--    2. Open http://localhost/phpmyadmin
--    3. Click "Import", choose this file, then "Go".
--
--  Command line (Windows cmd, with XAMPP MySQL on PATH):
--    mysql -u root < softem_restaurant.sql
--
--  This file creates the database `softem_restaurant`, then drops and
--  re-creates the `dishes` table with the 8 starter dishes. Re-importing
--  it replaces the MySQL copy with the contents of this file.
-- ============================================================

CREATE DATABASE IF NOT EXISTS softem_restaurant
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE softem_restaurant;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS dishes;

CREATE TABLE dishes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  price INT UNSIGNED NOT NULL,
  image VARCHAR(255) NOT NULL,
  category VARCHAR(40) NOT NULL DEFAULT 'mains',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO dishes (name, price, image, category) VALUES
  ('Smoky Jollof Rice',    5000, 'assets/dish-1.jpg', 'mains'),
  ('Softem Beef Burger',   5000, 'assets/dish-2.jpg', 'mains'),
  ('Pepperoni Pizza',      7500, 'assets/dish-3.jpg', 'mains'),
  ('Crispy Fries',         3000, 'assets/dish-4.jpg', 'sides'),
  ('Puff Puff (6 pcs)',    2000, 'assets/dish-5.jpg', 'pastries'),
  ('Glazed Doughnut',       700, 'assets/dish-6.jpg', 'pastries'),
  ('Grilled Chicken',      6500, 'assets/dish-7.jpg', 'mains'),
  ('Chapman Cooler',       2500, 'assets/dish-8.jpg', 'drinks');
