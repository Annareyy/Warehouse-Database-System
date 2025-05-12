# Warehouse-Database-System
# 📦 Warehouse Management System (WMS) - MySQL Project

## 📖 Project Description

This project is a **relational database** designed for a **warehouse management system** for a large-scale company using **MySQL**. It covers essential warehouse operations such as inventory control, supplier and customer tracking, order management (purchasing and dispatch), and staff allocation.

It includes proper **primary keys**, **foreign keys**, **data constraints**, and models **one-to-many** and **many-to-many relationships** with the appropriate junction tables.

---

## 🧱 Key Features

- ✅ Single warehouse support
- ✅ Inventory management with product categorization
- ✅ Purchase orders from suppliers
- ✅ Dispatch orders to customers
- ✅ Employee roles and department allocation
- ✅ Tracking deliveries and dispatches using junction tables
- ✅ Well-normalized structure with referential integrity

---

## 🗂️ Database Structure Overview

### Core Tables
- `products`: Stores product details
- `categories`: Groups products into types
- `suppliers`: Contains vendor info
- `customers`: Contains client info
- `purchase_orders`: Tracks products ordered from suppliers
- `dispatch_orders`: Tracks products sent to customers
- `employees`: Employee details
- `departments`: Employee department categorization
- `roles`: Role definition for each employee
- `units`: Units of measurement for products

### Junction Tables
- `purchase_order_items`: M:N between purchase_orders and products
- `dispatch_order_items`: M:N between dispatch_orders and products

---

## 🔗 Relationships

| Relationship                              | Type         | Mandatory/Optional |
|------------------------------------------|--------------|---------------------|
| products → categories                    | M:1          | Mandatory           |
| products → suppliers                     | M:1          | Mandatory           |
| products → units                         | M:1          | Mandatory           |
| employees → departments                  | M:1          | Mandatory           |
| employees → roles                        | M:1          | Mandatory           |
| purchase_orders ↔ products               | M:N via `purchase_order_items` | Mandatory           |
| dispatch_orders ↔ products               | M:N via `dispatch_order_items` | Mandatory           |

---

## 🚀 How to Run

### Steps: Setup MySQL
Ensure you have MySQL installed and running.

--clone the repository-
