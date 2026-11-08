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
Clone this repository and run the setup files in numerical order:

```bash
# Step 1: Create the target database (connect to default postgres DB)
psql -U postgres -d postgres -f 01_create_database.sql

# Step 2: Build table structure
psql -U postgres -d retail_analytics -f 02_create_tables.sql

# Step 3: Populate customers and orders
psql -U postgres -d retail_analytics -f 03_insert_customers.sql
psql -U postgres -d retail_analytics -f 04_insert_orders.sql

# Step 4: Validate row counts and integrity
psql -U postgres -d retail_analytics -f 05_verify_data.sql
```

*(If using **pgAdmin**, create the database `retail_analytics` via the UI first, open the Query Tool on `retail_analytics`, and run scripts 02 through 05 sequentially.)*

### 2. Verify Data Ingestion
Running `05_verify_data.sql` should report:
* **150** total customers
* **800** total orders
* **0** unlinked orphan orders
* Order date range spanning **January 2025 through September 2026**

---

## 🛠️ Key Database Objects Created

### Monthly Sales Summary View
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

### Customer Revenue Lookup Function
A defensive SQL function that retrieves net completed revenue for any customer ID, returning `0` if no completed orders exist:

```sql
CREATE OR REPLACE FUNCTION get_customer_revenue(p_customer_id INTEGER)
RETURNS NUMERIC LANGUAGE sql AS $$
    SELECT COALESCE(SUM(quantity * unit_price * (1 - discount / 100.0)), 0)
    FROM orders 
    WHERE customer_id = p_customer_id 
      AND order_status = 'Completed';
$$;
```

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