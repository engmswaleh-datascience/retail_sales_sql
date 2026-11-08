# Retail Sales & Customer Intelligence Using PostgreSQL

**Category:** Data Analytics · **Technology:** PostgreSQL · **Level:** Beginner → Advanced ·
**Time:** 7 days · **Marks:** 100

---

## 1. The story

**Duka Smart Electronics** is a growing Kenyan retailer selling phones, laptops, accessories, TVs and
home appliances in ten towns — from Nairobi and Mombasa to Meru and Machakos. It has been trading
since January 2025 and keeps every order in a database.

Management has questions. *Who are our best customers? Which products actually make money? Are sales
growing? Which customers have stopped buying?* Nobody has looked at the data properly yet.

You have just joined as a **Junior Data Analyst**. Your job this week: set up the company's database,
load its data, answer 46 business questions in SQL, and tell management what you found.

All the people and companies in this data are fictional.

---

## 2. What you will learn

- Creating a database and tables with keys and constraints
- Filtering, sorting and summarising data (`SELECT`, `WHERE`, `GROUP BY`, `HAVING`)
- Combining tables with `JOIN`s — including finding what is *missing* with a `LEFT JOIN`
- Breaking hard questions into steps with subqueries and CTEs (`WITH`)
- Ranking, running totals and month-on-month growth with window functions
- Saving logic as a view and a function
- Turning query results into business insight a manager can act on

---

## 3. What you need

1. **PostgreSQL 14 or newer.**
   - Windows/macOS: download from <https://www.postgresql.org/download/> (the installer includes
     **pgAdmin** and **psql**). Remember the password you set for the `postgres` user.
   - Ubuntu: `sudo apt install postgresql`
2. **A SQL editor** — pgAdmin (comes with PostgreSQL), DBeaver, or VS Code with a PostgreSQL extension.
   You can also use `psql` in a terminal; the commands below show both.
3. **Git and a GitHub account** to submit your work.

Check PostgreSQL is installed:

```bash
psql --version
```

---

## 4. The files you downloaded

Download all six files from the project page into one folder.

| File | What it does | Run it connected to |
|---|---|---|
| `01_create_database.sql` | Creates the `retail_analytics` database | `postgres` (any existing DB) |
| `02_create_tables.sql` | Creates the `customers` and `orders` tables | `retail_analytics` |
| `03_insert_customers.sql` | Inserts 150 customers | `retail_analytics` |
| `04_insert_orders.sql` | Inserts 800 orders | `retail_analytics` |
| `05_verify_data.sql` | Checks everything loaded correctly | `retail_analytics` |
| `README.md` | This guide | — |

> **Why two steps?** PostgreSQL can create a database, but it cannot then switch to it inside the same
> script. So you run file 01 while connected to the default `postgres` database, then **connect to
> `retail_analytics`** and run 02–05.

All scripts are **safe to run twice** — nothing is duplicated.

---

## 5. Setting up — step by step

### Option A: using psql (terminal)

Open a terminal in the folder with the files and run, one at a time:

```bash
psql -U postgres -d postgres         -f 01_create_database.sql
psql -U postgres -d retail_analytics -f 02_create_tables.sql
psql -U postgres -d retail_analytics -f 03_insert_customers.sql
psql -U postgres -d retail_analytics -f 04_insert_orders.sql
psql -U postgres -d retail_analytics -f 05_verify_data.sql
```

(On Windows, if `psql` is not found, use the **SQL Shell (psql)** app from the Start menu, or add
`C:\Program Files\PostgreSQL\<version>\bin` to your PATH.)

### Option B: using pgAdmin

1. Open pgAdmin, connect to your server, and right-click **Databases → Create → Database…**. Name it
   `retail_analytics` and save. (pgAdmin does not understand the `\gexec` line in file 01, so creating
   it this way replaces step 01.)
2. Click `retail_analytics` in the tree, then **Tools → Query Tool**.
3. Open `02_create_tables.sql` (folder icon), press **Execute** (▶ / F5).
4. Do the same for `03_insert_customers.sql`, then `04_insert_orders.sql`, then `05_verify_data.sql`.

### Check it worked

`05_verify_data.sql` prints a table of checks. You should see **150 customers**, **800 orders**,
**0 orders with no customer**, and orders from **January 2025 to September 2026**. Take a screenshot —
it goes in your submission.

---

## 6. The data

### `customers` — one row per customer (150 rows)

| Column | Type | Meaning |
|---|---|---|
| `customer_id` | INTEGER, **primary key** | Unique customer number |
| `customer_name` | VARCHAR(100), not null | Full name |
| `gender` | VARCHAR(10) | `Male` / `Female` |
| `city` | VARCHAR(50) | One of ten Kenyan towns |
| `registration_date` | DATE | When they joined |
| `customer_segment` | VARCHAR(20) | `Retail`, `Corporate` or `VIP` |

### `orders` — one row per order (800 rows)

| Column | Type | Meaning |
|---|---|---|
| `order_id` | INTEGER, **primary key** | Unique order number |
| `customer_id` | INTEGER, **foreign key → customers** | Who placed it |
| `order_date` | DATE, not null | When it was placed |
| `product_name` | VARCHAR(100) | What was bought |
| `product_category` | VARCHAR(50) | `Electronics`, `Accessories`, `Home Appliances`, `Computing`, `Mobile Phones` |
| `quantity` | INTEGER (> 0) | Units in the order |
| `unit_price` | NUMERIC(12,2) | Selling price per unit, KSh, **before** discount |
| `cost_price` | NUMERIC(12,2) | What one unit cost the company, KSh |
| `discount` | NUMERIC(5,2) (0–100) | Discount **percentage** — `10` means 10% off |
| `payment_method` | VARCHAR(30) | `M-Pesa`, `Cash`, `Card`, `Bank Transfer` |
| `order_status` | VARCHAR(20) | `Completed`, `Pending`, `Cancelled` |

### How the tables connect

```
customers (1) ──────────< orders (many)
customer_id               customer_id
```

One customer can have many orders; every order belongs to exactly one customer. **Some customers have
never ordered** — you will need a `LEFT JOIN` to find them.

Before you start, look at the data:

```sql
SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5;
```

---

## 7. Business rules — read these first

Most mistakes in this project come from skipping this section.

| Measure | Formula |
|---|---|
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

## 8. The assignment — 46 questions

Write every answer in `queries.sql`, numbered like this:

```sql
-- Q1: Retrieve all customer records
SELECT ...;

-- Q2: Display customer names, cities, and segments
SELECT ...;
```

Each section starts with the concepts you need and a reminder of the syntax. **The hints show the
shape of a query, not the answer.**

### Section A — SQL fundamentals (Q1–Q10)

*Concepts:* `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, `LIMIT`, `LIKE`, `BETWEEN`

```sql
SELECT column1, column2 FROM table WHERE condition ORDER BY column DESC LIMIT n;
-- text patterns: WHERE name LIKE 'K%'      ranges: WHERE x BETWEEN 1 AND 10
```

1. Retrieve all customer records.
2. Display customer names, cities, and segments.
3. Find customers living in Nairobi.
4. Find customers registered after January 1, 2025.
5. Display all unique customer cities.
6. Retrieve the 10 most recent orders.
7. Find orders with unit prices above KSh 10,000.
8. Find customers whose names start with A.
9. Retrieve orders with quantities between 2 and 5.
10. Find orders paid through M-Pesa.

### Section B — Aggregation and grouping (Q11–Q20)

*Concepts:* `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`, `ROUND`

```sql
SELECT group_column, SUM(...) AS total
FROM table WHERE row_condition
GROUP BY group_column
HAVING SUM(...) > 1000;      -- HAVING filters groups; WHERE filters rows
```

11. Count all customers.
12. Count all orders.
13. Calculate completed-order revenue.
14. Calculate the average completed-order value.
15. Find the highest and lowest product prices.
16. Calculate revenue by product category.
17. Count customers by city.
18. Calculate quantity sold by product.
19. Find categories generating more than KSh 100,000 in revenue.
20. Calculate the percentage of cancelled orders.

*Tip for Q20:* `COUNT(*) / COUNT(*)` between whole numbers gives 0 in PostgreSQL. Multiply by `100.0`
first. `COUNT(*) FILTER (WHERE …)` counts only some rows.

### Section C — Joins and customer analytics (Q21–Q28)

*Concepts:* `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`

```sql
SELECT c.customer_name, o.order_id
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id;      -- only customers WITH orders

-- LEFT JOIN keeps every customer; those without orders get NULLs on the orders side
```

21. Display orders with customer names and cities.
22. Calculate total spending by customer.
23. Identify customers who have never ordered.
24. Find the 10 highest-spending customers.
25. Calculate revenue by customer city.
26. Identify customers with more than five orders.
27. Calculate average customer spending by segment.
28. Identify the most popular category among VIP customers.

*Tip for Q27:* first find each customer's total, then average those totals per segment. Say in a
comment how you defined it. *Q28:* say what "popular" means in your answer (orders? units?).

### Section D — Subqueries and CTEs (Q29–Q34)

*Concepts:* subqueries, `WITH` (CTEs), nested aggregation

```sql
WITH step_one AS (
    SELECT customer_id, SUM(...) AS total FROM orders GROUP BY customer_id
)
SELECT * FROM step_one WHERE total > (SELECT AVG(total) FROM step_one);
```

29. Find customers spending above the average total spending per purchasing customer.
30. Find products priced above the overall average unit price.
31. Use a CTE to identify the three highest-revenue months.
32. Find customers purchasing from at least three categories.
33. Use a CTE to calculate category revenue, cost, profit, and profit margin.
34. Find customers whose latest completed order is more than 90 days before the latest order date in
    the dataset.

*Tip for Q32:* `COUNT(DISTINCT product_category)`. *Q34:* subtracting dates gives a number of days:
`DATE '2026-09-30' - DATE '2026-09-01'` is `29`.

### Section E — Window functions (Q35–Q42)

*Concepts:* `OVER`, `PARTITION BY`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `NTILE`

```sql
SELECT customer_id, order_date,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS n
FROM orders;
-- RANK leaves gaps after ties (1,1,3); DENSE_RANK does not (1,1,2)
-- running total:  SUM(x) OVER (ORDER BY month)
-- previous row:   LAG(x) OVER (ORDER BY month)
```

35. Rank customers by spending using `RANK()`.
36. Number each customer's orders by recency using `ROW_NUMBER()`.
37. Rank products within categories using `DENSE_RANK()`.
38. Calculate cumulative monthly revenue.
39. Compare monthly revenue using `LAG()`.
40. Calculate month-over-month revenue growth (%).
41. Divide customers into four spending groups using `NTILE(4)`.
42. Calculate each category's share of total revenue using window functions.

*Tip:* for monthly questions, build a `monthly` CTE (month, revenue) first, then apply the window
function to it. *Q42:* `SUM(SUM(x)) OVER ()` is the grand total next to each group.

### Section F — Advanced business intelligence (Q43–Q46)

*Concepts:* views, PL/pgSQL functions, `CASE`, reporting queries

```sql
CREATE OR REPLACE VIEW my_view AS SELECT ...;

CREATE OR REPLACE FUNCTION my_function(p_id INTEGER)
RETURNS NUMERIC LANGUAGE plpgsql AS $$
DECLARE v_result NUMERIC;
BEGIN
    SELECT ... INTO v_result FROM ... WHERE id = p_id;
    RETURN v_result;
END;
$$;

SELECT CASE WHEN x >= 100 THEN 'High' WHEN x >= 50 THEN 'Medium' ELSE 'Low' END ...
```

43. Create a `monthly_sales_summary` view (month, orders, revenue, cost, profit). Then `SELECT` from it.
44. Create a PostgreSQL function that returns completed-order revenue for a supplied customer ID. Show
    it working for one customer **and** for an ID that does not exist (it should return 0, not NULL).
45. Segment customers into High, Medium and Low Value. **Explain why you chose your thresholds** — for
    example percentiles, or round KSh amounts based on what the data looks like.
46. Produce a management report: the top five customers, top five products, the most profitable
    category, and the lowest-revenue month.

---

## 9. Insights — `insights.md`

Queries are half the job; the other half is telling management what they mean. Write **at least
five insights**. Each one needs:

1. **The finding**, with the number from your query.
2. **Why it matters** to the business.
3. **What you recommend.**

Here is the difference, using a made-up supermarket rather than this data (so it gives nothing away):

**Weak:** "Bakery revenue is 2,000,000."

**Strong:** "Fresh produce brings in the most revenue, but the bakery has the best margin — about a
third of every shilling is profit, against 8% for produce. Recommendation: put the bakery by the
entrance and stop discounting bread on weekdays."

Write yours the same way, with your own numbers and the question they came from. Good places to look: Q16 and
Q33 (what sells vs what makes money), Q25 (cities), Q27 (segments), Q34 (customers drifting away),
Q40 (growth and seasonality), Q45 (value bands).

---

## 10. What to submit

A **public** GitHub repository laid out like this:

```
retail-sales-sql/
├── README.md        # your own: what the project is, how to set it up, how to run your queries
├── schema.sql       # your CREATE TABLE statements (you may copy 02 and improve it)
├── queries.sql      # all 46 answers, numbered -- Q1 … -- Q46
├── insights.md      # at least five insights
└── screenshots/     # 05_verify_data output + 3–5 interesting query results
```

You do not need to include the insert scripts.

### Pushing to GitHub

```bash
cd retail-sales-sql
git init
git add .
git commit -m "Retail sales SQL analysis"
# create an empty public repo on github.com called retail-sales-sql, then:
git remote add origin https://github.com/<your-username>/retail-sales-sql.git
git branch -M main
git push -u origin main
```

Then paste `https://github.com/<your-username>/retail-sales-sql` into the **Submit** box on the
project page. You can resubmit as often as you like until the deadline — your mentor grades the
latest version.

---

## 11. How you are graded (100 marks)

| Criterion | Marks |
|---|---|
| Database setup & schema | 10 |
| SQL correctness — Sections A–C | 30 |
| SQL correctness — Sections D–F | 30 |
| Business insights | 20 |
| Code quality & documentation | 10 |

The full descriptions are in the rubric on the project page.

---

## 12. Suggested plan for the week

| Day | Do this |
|---|---|
| 1 | Install PostgreSQL, run scripts 01–05, explore both tables. Do Section A. |
| 2 | Section B. Re-read the business rules before every money question. |
| 3 | Section C. Draw the join on paper first if it helps. |
| 4 | Section D. Write each CTE step on its own and check it before combining. |
| 5 | Section E. Build the `monthly` CTE once and reuse it. |
| 6 | Section F, then write `insights.md`. |
| 7 | README, screenshots, push to GitHub, submit. Ask for help early if stuck. |

---

## 13. Troubleshooting

| Problem | Fix |
|---|---|
| `database "retail_analytics" does not exist` | Run 01 first, or create it in pgAdmin. |
| `relation "customers" does not exist` | You are connected to the wrong database — connect to `retail_analytics`. |
| `insert or update on table "orders" violates foreign key constraint` | Run 03 (customers) **before** 04 (orders). |
| `\gexec` syntax error in pgAdmin | pgAdmin does not support it — create the database from the menu (Section 5, Option B). |
| `password authentication failed` | Use the password you chose when installing PostgreSQL. |
| My numbers differ from a classmate's | Check you used Completed orders only and applied the discount as a percentage. |
| Percentage comes out as 0 | Integer division — multiply by `100.0` first. |

Stuck for more than 30 minutes on one question? Move on and come back, and ask in your class channel —
explain what you tried and paste the error.
