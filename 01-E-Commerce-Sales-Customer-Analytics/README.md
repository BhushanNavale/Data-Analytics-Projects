# 🛒 E-Commerce Sales & Customer Analytics

## 📌 Project Overview

This project is an end-to-end **E-Commerce Sales & Customer Analytics** project built using **MySQL and Power BI**.

The main objective was to analyze the business from a sales, profitability, product, customer, and payment perspective and convert the analysis into an interactive Power BI dashboard.

I started with a defined business problem instead of creating a dashboard from random business questions.

### Project Workflow

**Data Cleaning → EDA → Business Problem → SQL Business Analysis → Power BI Data Model → DAX → Dashboard → Business Insights → Recommendations**

---

# 🎯 Business Problem

> **The company wants to understand overall business performance, identify the key drivers of revenue and profit, determine its most valuable customers, and identify products and customer satisfaction areas that require improvement.**

Based on this business problem, the project focuses on:

- Overall sales and profitability
- Revenue and profit drivers
- Customer value and purchasing behavior
- Product and category performance
- Customer satisfaction
- Payment performance
- Areas that need improvement

---

# 🗂️ Dataset

The dataset contains **7 interconnected tables**.

| Table | Purpose |
|---|---|
| `customers` | Customer details |
| `products` | Product information |
| `categories` | Product categories |
| `orders` | Order-level information |
| `order_items` | Products within each order |
| `payments` | Payment information |
| `reviews` | Customer product reviews |

## 🔗 Data Model

<img width="612" height="751" alt="Screenshot 2026-09-04 042206" src="https://github.com/user-attachments/assets/89cba049-a950-4f2a-b57c-ba5625b90317" />


The tables were connected in Power BI to support analysis across customers, products, categories, orders, payments, and reviews.

---

# 🧹 Data Cleaning

Before performing the analysis, I cleaned and prepared the dataset.

The cleaning process included:

- Checking missing/null values
- Checking duplicate records
- Handling inconsistent date values and formats
- Checking inconsistent text values
- Checking data types
- Validating relationships between tables
- Checking imported data

I did not blindly remove all rows containing null values because removing them could affect calculations and analysis.

---

# 🔎 Exploratory Data Analysis

After data cleaning, I performed focused EDA to understand the structure and quality of the data before starting business analysis.

The EDA covered:

- Customer data
- Product and category data
- Orders and order items
- Payment data
- Review data
- Missing and inconsistent values
- Relationships between tables
- Basic data patterns

The EDA was intentionally kept focused so that the project could move from understanding the data to solving the defined business problem.

---

# 💰 Revenue Calculation

Revenue was calculated consistently using:

```text
Quantity × Unit Price × (1 - Discount)
```

SQL logic used:

```sql
SUM(
    oi.quantity * oi.unit_price * (1 - oi.discount)
)
```

This revenue calculation was used throughout the relevant business analysis.

---

# 📊 SQL Business Analysis

After EDA, I used MySQL to answer business questions related to the business problem.

## Sales Analysis

- What is the total revenue generated?
- How much revenue is generated each month?
- Is revenue increasing or decreasing month over month?
- What is the Average Order Value?
- Which months generated the highest and lowest revenue?
- How are orders distributed across different statuses?

## Customer Analysis

- Who are the top 10 customers based on total spending?
- Which customers have placed the most orders?
- How many customers are repeat customers and how many purchased only once?
- What is the average amount spent by a customer?
- Which cities generate the most revenue?

## Product Analysis

- Which 10 products generate the most revenue?
- Which 10 products sell the most units?
- Which products generate the highest profit?
- Which products generate the lowest profit?
- Which products have never been purchased?

## Category Analysis

- Which categories generate the most revenue?
- Which categories generate the most profit?

## Review Analysis

- What is the overall average product rating?
- Which categories have the highest and lowest average ratings?
- Which products have the highest number of reviews?
- Which products have high sales but low ratings?

## Payment Analysis

- Which payment methods are used the most?
- How much revenue comes from each payment method?
- Which payment methods have the highest number of failed payments?

---

# 🧮 Power BI Data Preparation

After completing the SQL analysis, I imported the data into Power BI and created the required data model.

I also created a dedicated **DateTable** for time-based analysis.

The DateTable contains:

- Date
- Year
- Month Number
- Month
- Quarter
- Year-Month
- Week Number
- Day
- Day Name

The DateTable was used for the time-based visuals in the dashboard.

---

# 📐 DAX Measures

I created the required DAX measures based on the business questions and dashboard requirements.

### Sales & Profit

- Total Revenue
- Total Orders
- Average Order Value
- Total Profit
- Profit Margin
- Total Units Sold

### Customer Analysis

- Total Customers
- Repeat Customers
- One-Time Customers
- Average Customer Spending
- Customer Segment

### Reviews & Payments

- Average Rating
- Total Reviews
- Failed Payments

These measures and many more measures were created to make the dashboard interactive and allow the calculations to respond to filters and slicers.

---

# 📊 Power BI Dashboard

The final dashboard contains **3 pages**.

---

# 📄 Page 1 — Executive Overview

### Business Question

> **How is the business performing overall, and what are the major revenue and profitability trends?**

This page provides a high-level view of business performance.

### KPI Cards

- Total Revenue
- Total Orders
- AOV
- Total Profit
- Profit Margin
- Total Customers

### Visuals

- Monthly Revenue Trend
- Revenue vs Profit
- Revenue by Category
- Order Status Breakdown
- Revenue by Payment Method

### Slicers

- Date
- Category
- Order Status
- Payment Method

### Main Purpose

This page answers:

> **"How is the business doing?"**

---

# 📄 Page 2 — Product & Category Performance

### Business Question

> **What products and categories are driving revenue and profit, and which products need improvement?**

### Visuals

- Top 10 Products by Revenue
- Top 10 Products by Profit
- Top 10 Products by Units Sold
- Top Brands by Revenue
- Revenue vs Profit by Category
- High Revenue + Low Rating Products

### Slicers

- Date
- Category
- Brand

### Main Purpose

This page identifies:

- Products driving revenue
- Products driving profit
- Products with high demand
- Strong-performing brands
- Category-level performance
- Products that may require investigation because of high sales but relatively low ratings

The **Revenue vs Rating** analysis is especially useful because it helps identify products that sell well but may have customer satisfaction issues.

---

# 📄 Page 3 — Customer Analysis

### Business Question

> **Who are our most valuable customers, how do they behave, and where are the opportunities to improve customer retention?**

### KPI Cards

- Total Customers
- Repeat Customers
- One-Time Customers
- Average Customer Spending

### Visuals

- Top 10 Customers by Revenue
- Repeat vs One-Time Customers
- Customers by Order Count
- Revenue by City
- Customers Never Ordered

### Slicers

- Date
- Customer Segment / Order Behavior
- City where required

### Main Purpose

This page focuses on:

- Customer value
- Repeat purchasing behavior
- Order frequency
- Geographic performance
- Customers who have registered but never placed an order

Customers who never ordered are treated as an **opportunity group**, not automatically as lost customers.

---

# 💡 Key Business Insights

## 1. Electronics dominates revenue

Electronics generated approximately:

**₹356.68M**

This is significantly higher than the other categories and shows that the business is highly dependent on Electronics.

---

## 2. Revenue fluctuates significantly across months

### Highest Revenue Month

**May — ₹41.90M**

### Lowest Revenue Month

**June — ₹32.67M**

Revenue does not follow a consistent upward trend throughout the year.

The drop from May to June was approximately **22%**.

---

## 3. Electronics is the main profit driver

Total profit was approximately:

**₹76.95M**

with a profit margin of approximately:

**17.45%**

Electronics contributed approximately:

**₹51.54M**

in profit, making it the largest profit contributor.

---

## 4. Repeat customers form the majority of purchasing customers

The analysis identified approximately:

- **4K repeat customers**
- **760 one-time customers**

This indicates that repeat purchasing is an important part of the customer base.

---

## 5. Some high-revenue products have relatively low ratings

Examples include:

| Product | Revenue | Average Rating |
|---|---:|---:|
| HP Pavilion 15 - Small | ₹17.57M | 3.44 |
| HP Pavilion 15 - Medium | ₹16.85M | 3.65 |
| Samsung Galaxy S24 - Classic | ₹15.15M | 3.68 |

These products generate substantial revenue but have relatively weaker ratings.

This does **not** prove that low ratings caused the sales performance. These products should be investigated further.

---

## 6. UPI generated the highest payment revenue

| Payment Method | Revenue |
|---|---:|
| UPI | ₹94.94M |
| Credit Card | ₹92.65M |
| Debit Card | ₹90.25M |
| Cash On Delivery | ₹88.06M |
| Net Banking | ₹84.55M |

UPI generated the highest payment revenue.

However, revenue is relatively distributed across the major payment methods.

---

## 7. Payment failures require attention

Approximately:

**1,157 failed payments**

were identified.

The failed payments were distributed across payment methods rather than being concentrated entirely in one method.

This suggests that the overall payment process should be investigated.

---

# 🚀 What Needs to Improve

The purpose of the analysis is not only to understand what happened but also to identify areas where the business can improve.

## 1. Reduce dependence on Electronics

Electronics contributes the majority of revenue and profit.

The business should continue supporting Electronics while also developing other categories to reduce dependence on one category.

---

## 2. Investigate the May-to-June revenue drop

May generated the highest revenue while June generated the lowest.

The business should investigate whether this was related to:

- Demand changes
- Promotions
- Product availability
- Other operational factors

The available analysis identifies the drop but does not explain its exact cause.

---

## 3. Investigate high-selling products with low ratings

Products such as **HP Pavilion 15 - Small** generate high revenue but have relatively low ratings.

The business should investigate:

- Customer reviews
- Product quality
- Pricing
- Returns
- Customer complaints

The objective is to understand why customer satisfaction is weaker despite strong sales.

---

## 4. Improve payment reliability

The presence of approximately 1,157 failed payments indicates an opportunity to improve payment reliability.

Since failures are distributed across payment methods, the business should investigate common problems in the overall payment process instead of assuming that one specific payment method is responsible.

---

## 5. Convert one-time customers into repeat customers

There are approximately 760 one-time customers.

The business could use:

- Targeted offers
- Follow-up campaigns
- Personalized recommendations

to encourage another purchase.

---

## 6. Focus on profit, not only revenue

High revenue does not automatically mean high profit.

Products and categories should therefore be evaluated using both:

**Revenue + Profit**

before making decisions about pricing, promotions, or product strategy.

---

# 🛠️ Tools Used

### MySQL

Used for:

- Data cleaning
- Exploratory Data Analysis
- Business analysis
- Joins
- Aggregations
- CTEs
- Window functions
- Ranking

### Power Query

Used for:

- Data preparation
- Data cleaning
- Handling data types and values

### Power BI

Used for:

- Data modeling
- DateTable
- Calculated columns
- DAX measures
- Interactive dashboard
- Data visualization

### Excel / CSV

Used for:

- Initial data handling
- Source data

---

# 🔄 Complete Project Workflow

```text
Raw CSV Files
      ↓
Data Cleaning
      ↓
Exploratory Data Analysis
      ↓
Business Problem Definition
      ↓
MySQL Business Analysis
      ↓
Power BI Data Model
      ↓
DateTable & Required Columns
      ↓
DAX Measures
      ↓
3-Page Interactive Dashboard
      ↓
Business Insights
      ↓
Recommendations
```

---

# 🎯 Final Outcome

This project demonstrates an end-to-end data analytics workflow.

Instead of creating a dashboard from random queries, I first defined the business problem and then built the analysis around it.

The project covers:

**Data Cleaning → EDA → SQL Analysis → Data Modeling → DAX → Power BI Dashboard → Business Insights → Recommendations**

The analysis identified several important areas:

- Strong dependence on Electronics
- Significant monthly revenue fluctuations
- Repeat customer behavior
- High-value customers
- High-revenue products with relatively lower ratings
- Payment method performance
- Failed payment opportunities
- Areas where the business can improve profitability and customer experience

The final dashboard turns these findings into an interactive business reporting solution.

