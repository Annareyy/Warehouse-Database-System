-- warehouse_management database
CREATE DATABASE IF NOT EXISTS warehouse_system;
USE warehouse_system;

CREATE TABLE units (
    unit_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address TEXT
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    sku VARCHAR(50) NOT NULL UNIQUE,
    category_id INT,
    supplier_id INT,
    unit_id INT,
    reorder_level INT NOT NULL DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    location_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Purchase Orders placed to suppliers
CREATE TABLE purchase_orders (
    po_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Purchase Order Items
CREATE TABLE purchase_order_items (
    po_id INT,
    product_id INT,
    quantity INT NOT NULL,
    cost_per_unit DECIMAL(10,2),
    PRIMARY KEY (po_id, product_id),
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Dispatch Orders to customers
CREATE TABLE dispatch_orders (
    do_id INT PRIMARY KEY AUTO_INCREMENT,
    dispatch_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    customer_id INT,
    handled_by INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (handled_by) REFERENCES employees(employee_id)
);

-- Dispatch Order Items
CREATE TABLE dispatch_order_items (
    do_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (do_id, product_id),
    FOREIGN KEY (do_id) REFERENCES dispatch_orders(do_id),
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
