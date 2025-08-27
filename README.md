# Bike Store Analytics (MySQL + Power BI)

## 📌 Project Overview
This project demonstrates an end-to-end data analytics pipeline using:

- **Excel** as the dataset source  
- **MySQL** for database design, queries, views, stored procedures, triggers, and constraints  
- **Power BI** for data modeling, DAX measures, and interactive dashboards  
- **GitHub** for project version control and documentation  

The dataset simulates a **Bike Store business** including customers, products, sales, staff, inventory, and stores.

---

## 🛠 Tech Stack
- **Excel** → Raw dataset (source data)  
- **MySQL** → Database creation, queries, optimization  
- **Power BI** → Data visualization and dashboard  
- **GitHub** → Project documentation and sharing  

---

## 📂 Repository Structure


---

## 📊 Dataset
The dataset is included in: `dataset/bike_store_data.xlsx`  
It contains data for:
- Customers  
- Stores  
- Staff  
- Products  
- Inventory  
- Orders and Order Items  

This dataset was imported into **MySQL** to simulate a real-world retail sales database.

---

## 🗄 Database (MySQL)
The **Bike Store Database** includes:
- **Tables:** customers, stores, staff, products, orders, order_items, inventory, categories, brands  
- **Views:** e.g., `sales_summary` for total order value  
- **Stored Procedures:** e.g., `sp_get_order_total`  
- **Triggers:** e.g., `tr_update_inventory_after_order` to auto-update inventory  
- **Indexes & Constraints:** for optimization and data integrity  

👉 All SQL files are inside the `database` folder.  
👉 A **full setup file** is provided: `bike_store_full.sql`

---

## 🖼 Entity Relationship Diagram (ERD)
The ERD was created using **MySQL Workbench**.  
It shows all tables and their relationships.

- File: `ERD/bike_store_ERD.png`

---

## 📈 Dashboard (Power BI)
The **Power BI dashboard** (`bike_store_dashboard.pbix`) connects directly to MySQL and provides insights such as:

- Sales by Store  
- Sales by Brand and Category  
- Top 10 Customers by Spend  
- Monthly Sales Trend  
- Inventory Levels  
