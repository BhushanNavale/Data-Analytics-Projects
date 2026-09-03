# 🛒 E-commerce SQL Project

> **A SQL project focused on Exploratory Data Analysis (EDA), Business Analysis, and Advanced SQL concepts using MySQL.**

---

## 📌 Project Overview

This project demonstrates SQL skills by analyzing an **E-commerce dataset** using **MySQL**.

The project covers the complete SQL analysis workflow, including:

* 📥 Importing CSV datasets using **MySQL Workbench (Table Data Import Wizard)**
* 🔍 Exploratory Data Analysis (EDA)
* 📊 Business Analysis
* 🚀 Advanced SQL queries using **Window Functions** and **Common Table Expressions (CTEs)**

The objective of this project is to answer real-world business questions and extract meaningful insights from transactional data.

---

## 📂 Dataset

The project uses six CSV files:

* 📄 users.csv
* 📄 products.csv
* 📄 orders.csv
* 📄 order_items.csv
* 📄 reviews.csv
* 📄 events.csv

These datasets represent an e-commerce platform containing customer information, products, orders, reviews, and user activities.

---

## 📁 Project Structure

```text
Ecommerce_SQL_Project/
│
├── dataset/
│   ├── users.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── reviews.csv
│   └── events.csv
│
├── exploratory_queries.sql
├── business_analysis.sql
├── advanced_queries.sql
├── README.md
└── schema.png
```

---

## 🛠️ Tools Used

* MySQL
* MySQL Workbench
* SQL

---

## 🗄️ Database Tables

| Table           | Description                     |
| :-------------- | :------------------------------ |
| **Users**       | Customer information            |
| **Products**    | Product details                 |
| **Orders**      | Customer orders                 |
| **Order Items** | Products included in each order |
| **Reviews**     | Customer product reviews        |
| **Events**      | User activity events            |

---

## 🔍 Exploratory Data Analysis (EDA)

Exploratory analysis was performed on every table before solving business problems.

### 👤 Users

* Total users
* Gender distribution
* Users by city
* Missing emails

### 📦 Products

* Total products
* Categories
* Brands
* Product pricing
* Product ratings

### 🛍️ Orders

* Total orders
* Order status distribution
* Revenue
* Order trends

### 📦 Order Items

* Total order items
* Duplicate checks
* Products sold
* Users purchasing products
* Average product price
* Total sales

### ⭐ Reviews

* Total reviews
* Average rating
* Rating distribution
* Review dates

### 📈 Events

* Total events
* Event type distribution
* User activity
* Event timeline

---

## 📊 Business Analysis

The following business questions were solved using SQL:

* 💰 Top revenue-generating products
* 👑 Top customers by total spending
* 📦 Revenue by product category
* 🛒 Customers with the highest number of orders
* ⭐ Products with high sales but poor ratings
* 📈 Best-selling products by units sold
* 🏆 Top-selling product in each category
* 📅 Monthly revenue trend
* 🛍️ Monthly order trend
* 🏷️ Revenue by brand
* 🌍 Revenue by city
* 👤 Customers with only one completed order
* ✍️ Customers who never wrote a review
* 📦 Products that have never been ordered
* 🚻 Revenue by gender
* 💳 Average Order Value (AOV) by month
* ⚡ Most active users
* 🏙️ Top customers in each city
* 🔁 Repeat customers
* 💎 Customer Lifetime Value (CLV)

---

## 🚀 Advanced SQL Concepts

Advanced SQL queries were implemented using:

* ✅ Common Table Expressions (CTEs)
* ✅ Window Functions
* ✅ ROW_NUMBER()
* ✅ RANK()
* ✅ LAG()
* ✅ SUM() OVER()
* ✅ AVG() OVER()
* ✅ DATEDIFF()
* ✅ CASE Statement

### Advanced SQL Analysis

* Assign order numbers for each customer's orders
* Show previous order amount
* Compare current and previous order values
* Calculate cumulative monthly revenue
* Identify orders with increased spending
* Find the highest-value order for each customer
* Find the latest order for each customer
* Show customer average order amount
* Find orders above customer average
* Calculate days between consecutive orders

---

## 📚 SQL Concepts Used

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* DISTINCT
* Aggregate Functions
* INNER JOIN
* LEFT JOIN
* Common Table Expressions (CTEs)
* Window Functions
* CASE Statement
* Date Functions
* Subqueries

---

## 🗂️ Database Schema

<img width="1288" height="678" alt="schema png" src="https://github.com/user-attachments/assets/d3dd6e89-db35-49e0-af32-e3afa5120298" />

---

## ▶️ How to Run

1. Open **MySQL Workbench**.
2. Create a new database.
3. Import all CSV files using the **Table Data Import Wizard**.
4. Execute the SQL files in the following order:

   * `exploratory_queries.sql`
   * `business_analysis.sql`
   * `advanced_queries.sql`

---

## 📈 Learning Outcomes

Through this project, I practiced:

* Importing CSV datasets into MySQL
* Exploratory Data Analysis (EDA)
* Solving business problems using SQL
* Using Aggregate Functions
* Working with Joins
* Using Common Table Expressions (CTEs)
* Applying Window Functions
* Performing analytical SQL techniques

---

## 👨‍💻 Author

**Bhushan Navale**
**Aspiring Data Analyst**
