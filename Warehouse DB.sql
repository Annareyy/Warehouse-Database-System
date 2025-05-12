-- warehouse_management database

CREATE DATABASE IF NOT EXISTS warehouse_system;
USE warehouse_system;

-- Table to store units of measurement (e.g., kg, box, piece)
CREATE TABLE units (
    unit_id INT AUTO_INCREMENT PRIMARY KEY,
    unit_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table to store product categories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table to store suppliers
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT
);

-- Table to store products in the warehouse
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    category_id INT,
    supplier_id INT,
    unit_id INT,
    reorder_level INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);

-- Table to track inventory of products (in a single warehouse)
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    UNIQUE(product_id)
);

-- Table to record purchase orders (incoming stock)
CREATE TABLE purchase_orders (
    po_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    po_date DATE NOT NULL,
    status ENUM('Pending', 'Received', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Table to record items in each purchase order
CREATE TABLE purchase_order_items (
    poi_id INT AUTO_INCREMENT PRIMARY KEY,
    po_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Table to record dispatch orders (stock going out)
CREATE TABLE dispatch_orders (
    dispatch_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    dispatch_date DATE,
    status ENUM('Pending', 'Dispatched', 'Cancelled') DEFAULT 'Pending'
);

-- Table to record items in each dispatch order
CREATE TABLE dispatch_order_items (
    doi_id INT AUTO_INCREMENT PRIMARY KEY,
    dispatch_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (dispatch_id) REFERENCES dispatch_orders(dispatch_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Adding data to the database tables
-- Insert categories
INSERT INTO categories (category_id, category_name) VALUES 
(1, 'Electronics'), 
(2, 'Furniture');

-- Insert units
INSERT INTO units (unit_name) VALUES 
('Piece'), 
('Box');

-- Insert suppliers
INSERT INTO suppliers (supplier_id, name, email, phone, address) VALUES 
(1, 'Tech Supplies Ltd.', 'contact@techsupplies.com', '1234567890', 'Nairobi'),
(2, 'HomeFurnish Co.', 'support@homefurnish.com', '0987654321', 'Mombasa');

-- Insert products
INSERT INTO products (product_id, name, description, category_id, supplier_id, unit_id, reorder_level, sku) 
VALUES  
(1, 'LED TV', '42-inch Smart TV', 1, 1, 1, 5, 'SKU-TV-001'),  
(2, 'Office Chair', 'Ergonomic chair with wheels', 2, 2, 1, 10, 'SKU-CHAIR-002');


-- Insert inventory
INSERT INTO inventory (product_id, quantity) VALUES 
(1, 20), 
(2, 15);

-- Insert purchase orders
INSERT INTO purchase_orders (po_id, supplier_id, po_date, status) VALUES 
(101, 1, '2025-05-01', 'Received'), 
(102, 2, '2025-05-02', 'Pending');

-- Insert purchase_order_items
INSERT INTO purchase_order_items (po_id, product_id, quantity) VALUES 
(101, 1, 10), 
(102, 2, 5);

-- Insert dispatch orders
INSERT INTO dispatch_orders (dispatch_id, customer_name, dispatch_date, status) VALUES 
(201, 'Jane Doe', '2025-05-05', 'Dispatched');

-- Insert dispatch_order_items
INSERT INTO dispatch_order_items (dispatch_id, product_id, quantity) VALUES 
(201, 1, 2);

-- Select all products with their category and supplier names
SELECT 
    p.product_id, 
    p.name AS product_name, 
    c.category_name, 
    s.name AS supplier_name
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id;

-- Check inventory levels
SELECT 
    p.name, 
    i.quantity, 
    p.reorder_level,
    CASE 
        WHEN i.quantity <= p.reorder_level THEN 'Restock Needed'
        ELSE 'Stock OK'
    END AS stock_status
FROM 
    inventory i
JOIN 
    products p ON i.product_id = p.product_id;
