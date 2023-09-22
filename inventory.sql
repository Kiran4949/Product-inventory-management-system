-- Create a new database named 'inventory'
CREATE DATABASE inventory;

-- Use the 'inventory' database
USE inventory;

-- Create a table named 'user' for storing user information
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  role_id INT NOT NULL,
  first_name VARCHAR(50) DEFAULT NULL,
  middle_name VARCHAR(50) DEFAULT NULL,
  last_name VARCHAR(50) DEFAULT NULL,
  username VARCHAR(50) UNIQUE,
  mobile VARCHAR(15) UNIQUE,
  email VARCHAR(50) UNIQUE,
  password_hash VARCHAR(32) NOT NULL,
  registered_at DATETIME NOT NULL,
  last_login DATETIME DEFAULT NULL,
  intro TEXT,
  profile TEXT
);

SELECT * FROM users;

-- Create a table named 'order' for storing order information
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  type INT NOT NULL DEFAULT 0,
  status INT NOT NULL DEFAULT 0,
  sub_total FLOAT NOT NULL DEFAULT 0,
  item_discount FLOAT NOT NULL DEFAULT 0,
  tax FLOAT NOT NULL DEFAULT 0,
  shipping FLOAT NOT NULL DEFAULT 0,
  total FLOAT NOT NULL DEFAULT 0,
  promo VARCHAR(50),
  discount FLOAT NOT NULL DEFAULT 0,
  grand_total FLOAT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  content TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create a table named 'address' for storing user addresses
CREATE TABLE addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  order_id INT,
  first_name VARCHAR(50) DEFAULT NULL,
  middle_name VARCHAR(50) DEFAULT NULL,
  last_name VARCHAR(50) DEFAULT NULL,
  mobile VARCHAR(15),
  email VARCHAR(50),
  line1 VARCHAR(50),
  line2 VARCHAR(50),
  city VARCHAR(50),
  province VARCHAR(50),
  country VARCHAR(50),
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Create a table named 'product' for storing product information
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(75) NOT NULL,
  summary TEXT,
  type INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  content TEXT
);

-- Create a table named 'category' for storing product categories
CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  parent_id INT,
  title VARCHAR(75) NOT NULL,
  meta_title VARCHAR(100),
  slug VARCHAR(100) NOT NULL,
  content TEXT,
  FOREIGN KEY (parent_id) REFERENCES categories(id)
);

-- Create a table named 'brand' for storing brand information
CREATE TABLE brands (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(75) NOT NULL,
  summary TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  content TEXT
);

-- Create a table named 'product_category' for linking products and categories
CREATE TABLE product_categories (
  product_id INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (product_id, category_id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Create a table named 'product_meta' for storing product metadata
CREATE TABLE product_meta (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  meta_key VARCHAR(50) NOT NULL,
  content TEXT,
  UNIQUE KEY uq_product_meta (product_id, meta_key),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Create a table named 'transaction' for storing transaction information
CREATE TABLE transactions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  order_id INT NOT NULL,
  code VARCHAR(100) NOT NULL,
  type INT NOT NULL DEFAULT 0,
  mode INT NOT NULL DEFAULT 0,
  status INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  content TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Create a table named 'item' for storing item information
CREATE TABLE items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  brand_id INT NOT NULL,
  supplier_id INT NOT NULL,
  order_id INT NOT NULL,
  sku VARCHAR(100) NOT NULL,
  mrp FLOAT NOT NULL DEFAULT 0,
  discount FLOAT NOT NULL DEFAULT 0,
  price FLOAT NOT NULL DEFAULT 0,
  quantity INT NOT NULL DEFAULT 0,
  sold INT NOT NULL DEFAULT 0,
  available INT NOT NULL DEFAULT 0,
  defective INT NOT NULL DEFAULT 0,
  created_by INT NOT NULL,
  updated_by INT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (brand_id) REFERENCES brands(id),
  FOREIGN KEY (supplier_id) REFERENCES users(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Create a table named 'order_item' for linking orders and items
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  item_id INT NOT NULL,
  order_id INT NOT NULL,
  sku VARCHAR(100) NOT NULL,
  price FLOAT NOT NULL DEFAULT 0,
  discount FLOAT NOT NULL DEFAULT 0,
  quantity INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  updated_at DATETIME DEFAULT NULL,
  content TEXT,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (item_id) REFERENCES items(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

show tables;