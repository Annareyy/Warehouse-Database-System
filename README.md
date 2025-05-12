# Warehouse-Database-System
# 📦 Warehouse Management System (MySQL Project)

## 📌 Project Title

**Warehouse Management System for a Single Warehouse**

---

## 🧾 Description

This project demonstrates the creation of a relational database using **MySQL** to manage a centralized warehouse for a large organization. The database covers essential functions such as:

- Product management  
- Inventory tracking  
- Supplier and unit definitions  
- Purchase and dispatch workflows  
- Reorder level monitoring  

It uses relational constraints such as `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `UNIQUE`, and models different relationship types (`1-1`, `1-M`, `M-M`).

---

## 🎯 Objective

- Build a complete, structured relational database using MySQL.
- Implement and enforce relational integrity constraints.
- Simulate a real-world warehouse environment for a **single location**.
- Test the schema with valid data inserts and queries.
- Provide a well-documented `.sql` file and ERD.

---

## 🛠️ Tech Stack

- **Database:** MySQL
- **Tools:** MySQL Workbench, CLI, phpMyAdmin
- **File:** `warehouse_management.sql`

---

## 🗃️ Database Tables Overview

| Table                  | Purpose |
|------------------------|---------|
| `products`             | Stores products with SKUs, descriptions, and reorder levels |
| `categories`           | Stores product categories |
| `units`                | Stores measurement units (e.g., pieces, boxes) |
| `suppliers`            | Stores supplier contact details |
| `inventory`            | Tracks stock levels of each product |
| `purchase_orders`      | Logs purchase orders |
| `purchase_order_items` | Details of items in each purchase order |
| `dispatch_orders`      | Logs outbound shipments |
| `dispatch_order_items` | Details of items in each dispatch |

---To run the database make sure you have mysql or phpmyadmin then you can clone the repository-
