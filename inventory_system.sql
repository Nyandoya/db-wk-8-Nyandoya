-- Inventory Management System Database
CREATE DATABASE InventoryManagementSystem;
USE InventoryManagementSystem;

-- Create Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL
);

-- Create Warehouses Table
CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    manager VARCHAR(255) NOT NULL
);

-- Create Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    supplier_id INT NOT NULL,
    category VARCHAR(100),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Create Inventory Table (M-M relationship between Products and Warehouses)
CREATE TABLE Inventory (
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    last_restocked DATE,
    PRIMARY KEY (product_id, warehouse_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2) NOT NULL
);

-- Create OrderItems Table
CREATE TABLE OrderItems (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Sample Suppliers
INSERT INTO Suppliers (name, contact_email, phone, address) VALUES
('Tech Corp', 'tech@supplier.com', '111-222-3333', '123 Tech Valley, CA'),
('Home Essentials', 'home@supplier.com', '444-555-6666', '456 Comfort Lane, TX');

-- Insert Sample Warehouses
INSERT INTO Warehouses (location, capacity, manager) VALUES
('Nairobi', 5000, 'John WarehouseManager'),
('Eldoret', 7500, 'Sarah StorageExpert');

-- Insert Sample Products
INSERT INTO Products (sku, name, description, price, supplier_id, category) VALUES
('TECH-LP-001', 'Laptop', '15" Business Laptop', 899.99, 1, 'Electronics'),
('HOME-DC-002', 'Desk Chair', 'Ergonomic Office Chair', 199.50, 2, 'Furniture'),
('HOME-LT-003', 'Smart Bulb', 'WiFi Enabled LED Bulb', 29.99, 2, 'Lighting');

-- Insert Sample Inventory
INSERT INTO Inventory (product_id, warehouse_id, quantity, last_restocked) VALUES
(1, 1, 50, '2024-02-15'),
(2, 1, 120, '2024-03-01'),
(3, 2, 300, '2024-03-10'),
(1, 2, 30, '2024-01-20');

-- Insert Sample Orders
INSERT INTO Orders (customer_name, customer_email, status, total_amount) VALUES
('Office Solutions', 'office@example.com', 'Delivered', 1099.48),
('Remote Worker Co', 'remote@example.com', 'Pending', 329.98);

-- Insert Sample Order Items
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 899.99),
(1, 2, 1, 199.49),
(2, 3, 10, 29.99);