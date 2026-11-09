# Retail Sales & Customer Analytics (PostgreSQL)

This repository contains a full PostgreSQL reporting suite built for **Duka Smart Electronics**, a retail chain operating across 10 Kenyan towns (including Nairobi, Mombasa, Meru, and Machakos). 

The goal of this project is to take raw transactional data—spanning 150 customers and 800 orders—and turn it into actionable business metrics covering customer lifetime value, product margins, seasonality, and revenue growth.

---

## 💡 What This Project Covers

The SQL scripts in this project answer 46 core business questions organized into six practical areas:

1. **SQL Fundamentals**: Basic filtering, pattern matching, and sorting on orders and customer lists.
2. **Aggregation & Grouping**: Category-level sales, overall revenue, and average order values.
3. **Joins & Customer Behavior**: Multi-table queries to identify high-spending customers, city-by-city sales, and inactive accounts.
4. **CTEs & Subqueries**: Multi-step reporting for category profit margins and order recency analysis.
5. **Window Functions**: Rank analyses (`RANK`, `DENSE_RANK`), running monthly totals, `LAG()` growth percentages, and `NTILE(4)` spending quartiles.
6. **Views & Stored Logic**: Custom views for monthly executive summaries and lightweight PL/pgSQL functions for instant customer spending lookups.

---

## 🗄️ Database Tables & Schema

The dataset uses two core tables connected by `customer_id`:

### `customers` Table
* `customer_id` (INTEGER, Primary Key): Unique identifier for each customer.
* `customer_name` (VARCHAR): Full customer name.
* `gender` (VARCHAR): `Male` or `Female`.
* `city` (VARCHAR): Town location (e.g., Nairobi, Mombasa, Machakos).
* `registration_date` (DATE): Account creation date.
* `customer_segment` (VARCHAR): `Retail`, `Corporate`, or `VIP`.

### `orders` Table
* `order_id` (INTEGER, Primary Key): Unique order number.
* `customer_id` (INTEGER, Foreign Key): References `customers(customer_id)`.
* `order_date` (DATE): Date the order was placed.
* `product_name` (VARCHAR): Item purchased.
* `product_category` (VARCHAR): `Electronics`, `Accessories`, `Home Appliances`, `Computing`, or `Mobile Phones`.
* `quantity` (INTEGER): Number of units purchased.
* `unit_price` (NUMERIC): List price per unit in KSh before discounts.
* `cost_price` (NUMERIC): Wholesale unit cost to the store in KSh.
* `discount` (NUMERIC): Discount percentage (e.g., 10 for 10% off).
* `payment_method` (VARCHAR): `M-Pesa`, `Cash`, `Card`, or `Bank Transfer`.
* `order_status` (VARCHAR): `Completed`, `Pending`, or `Cancelled`.

---

## 📐 Core Business Formulas

To maintain consistency across all queries:

* **Net Revenue**: `quantity * unit_price * (1 - discount / 100.0)`
* **Total Cost**: `quantity * cost_price`
* **Net Profit**: `Revenue - Cost`
* **Profit Margin %**: `(Profit / Revenue) * 100` *(using `NULLIF(revenue, 0)` to prevent division errors)*
* **Financial Filter**: Financial reports evaluate **`order_status = 'Completed'`** exclusively, while order counts evaluate all statuses unless specified.

---

## 🚀 How to Set Up and Run

### 1. Database Initialization
Create the database and run the setup files in numerical order:

```bash
# Step 1: Create the target database (connect to default postgres DB) and schema
01_create_database.sql

CREATE DATABASE retail_analytics

create schema retail_analytics;

# Step 2: Build table structure
02_create_tables.sql

CREATE TABLE IF NOT EXISTS customers()
CREATE TABLE IF NOT EXISTS orders ()

# Step 3: Populate customers and orders
03_insert_customers.sql
04_insert_orders.sql

# Step 4: Create indexes
05_CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders (customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_date ON orders (order_date);

# Step 5: Validate row counts and integrity
06_verify_data.sql

### 2. Verify Data
select * from customers;
select * from orders;

Running verify_data.sql should report:
* **150** total customers
* **800** total orders
* Order date range spanning **January 2025 through September 2026**

---

## 🛠️ Key Database Objects Created

### Monthly Sales Summary View
SELECT
    ROUND(SUM(quantity * unit_price * (1 - discount / 100)), 2) AS completed_revenue,
    ROUND(SUM(quantity * cost_price), 2)                         AS completed_cost,
    ROUND(SUM(quantity * unit_price * (1 - discount / 100)) - SUM(quantity * cost_price), 2) AS completed_profit
FROM orders
WHERE order_status = 'Completed';

Rather than writing identical grouping logic for recurring reports, the `monthly_sales_summary` view consolidates monthly performance:

```sql
CREATE OR REPLACE VIEW monthly_sales_summary AS
SELECT 
    DATE_TRUNC('month', order_date)::date AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue,
    SUM(quantity * cost_price) AS total_cost,
    SUM((quantity * unit_price * (1 - discount / 100.0)) - (quantity * cost_price)) AS profit
FROM orders
WHERE order_status = 'Completed'
GROUP BY DATE_TRUNC('month', order_date);
```

### Important Business rules

| **Measure** | **Formulae**
| **Revenue** | `quantity * unit_price * (1 - discount / 100)` |
| **Cost** | `quantity * cost_price` |
| **Profit** | `revenue - cost` |
| **Profit margin %** | `profit / revenue * 100` — use `NULLIF(revenue, 0)` so you never divide by zero |

1. **Money questions use Completed orders only.** Revenue, cost, profit, spending and averages count
   only `order_status = 'Completed'`, unless a question says otherwise. Pending orders are not paid
   yet; cancelled ones never will be.
2. **Order counts include every order**, whatever its status ("how many orders" means all of them).
3. **Customer counts count distinct customers.**
4. **"Today" is the latest `order_date` in the data**, not your computer's date — so everyone gets the
   same answer. Get it with `SELECT MAX(order_date) FROM orders`.
5. **Months** mean year *and* month — January 2025 and January 2026 are different months. Use
   `DATE_TRUNC('month', order_date)`.
6. Round money to 2 decimal places with `ROUND(…, 2)`.

---

## 📁 Repository Structure

```
retail-sales-sql/
├── README.md                    # Project documentation & setup guide
├── schema.sql                   # Database table definitions and constraints
├── queries.sql                  # Solutions to all 46 business questions (Q1–Q46)
├── insights.md                  # Executive management summary and strategic recommendations
└── screenshots/                 # Verification outputs and sample query results
```