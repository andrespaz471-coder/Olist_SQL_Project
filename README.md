# Olist SQL Project

## Dataset 

The project uses the public Olist e-commerce dataset (2016-2018), wich contains information about:

- Customers
- Orders
- Order items
- Order payments
- Products
- Sellers
- Product categories

Original dataset (Kaggle): "Brazilian E-Commerce Public Dataset by Olist".

---

## Database Schema

The database is implemented in **MySQL**.

Main tables:

- `customers`
- `orders`
- `order_items`
- `order_payments`
- `products`
- `product_category_name`
- `sellers`

The ER diagram is included in this repository:

- `olist_project.png`

---

## Project Structure 

- `Database_Creation.sql`
  Creates the database ('olist_project') and sets the default schema.

- `Tables_Creation.sql`
  Contains all 'CREATE TABLE' staments and foreign keys

- `Inconsistencies_Correction.sql`
  Scripts used to fit data issues (Inconcistencies, types, constraints).

- `SQL_queries_olist.sql`
  Collection of queries organized by difficulty.

- `olist-project.png`
  ER diagram of the database.

--- 

## How to run

1. Create the database:
   SOURCE: Database_Creation.sql

2. Create all tables:
   SOURCE: Tables_Creation.sql

3. Apply data cleaning scripts:
   SOURCE: Inconsistencies_Correction.sql

4. Explore the analysus queries:
   SOURCE: SQL_queries_olist.sql

You can run these scripts from:
- MySQL client (mysql), or:
- any SQL IDE (e.g. DBeaver) connected to your local MySQL server.

---

## Next Steps: Possible improvements 
1. Add views for the most common analysis.
2. Create stored procedures for reusables metrics (e.g. monthly revenue, cohor analysis).
3. Build a Power BI/ Tableau dashboard on top of this schema. 
