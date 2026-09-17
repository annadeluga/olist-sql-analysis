# Olist E-Commerce SQL Analysis

## About the project

This project presents an analysis of the Olist Brazilian e-commerce dataset from Kaggle using SQL Server.

The main goal of the project was to explore customer behavior, product sales, payment methods, reviews, sellers and delivery performance, and answer selected business questions using SQL.

## Tools

- SQL Server Management Studio (SSMS)

## SQL techniques

- SELECT
- JOINs
- GROUP BY
- HAVING
- Aggregate Functions
- CASE
- CTEs
- Window Functions
- DENSE_RANK
- COUNT(DISTINCT)
- DATEDIFF
- Data aggregation and percentage calculations

## Database structure

The project uses the Olist e-commerce dataset consisting of multiple related tables.

Primary and foreign keys were defined to establish relationships between the main entities.

## Business questions

### Customers

- Which cities and states have the most unique customers?
- Which customers spend the most and what products do they buy most often?

### Products

- Which products sell the most?
- Which product categories generate the highest revenue and what is their share of total revenue?
- Does the number of product photos relate to sales?

### Payments

- Which payment methods are the most popular and what percentage of payments do they represent?

### Sellers

- Which states have the most sellers and generate the highest revenue?

### Reviews

- What is the overall average review score and how are ratings distributed?
- Which products have the highest average rating?
- Which customers leave reviews most frequently?

### Orders & Delivery

- How does the number of orders change over time?
- What is the average delivery time?
- How often are orders delivered after the estimated delivery date?
- Does delivery delay affect customer review scores?

## SQL queries

### Customers

- [Customer analysis](SQL/01_Customers.sql)

### Products

- [Products analysis](SQL/02_Products.sql)

### Payments & Sellers

- [Payments & Sellers analysis](SQL/03_Payments_Sellers.sql)

### Reviews

- [Reviews analysis](SQL/04_Reviews.sql)

### Orders & Delivery

- [Orders & Delivery analysis](SQL/05_Orders_Delivery.sql)

## Key insights

- 
- 
- 

## Project structure

```text
olist-sql-analysis/
│
├── README.md
│
├── SQL/
│   ├── 01_Customers.sql
│   ├── 02_Products.sql
│   ├── 03_Payments_Sellers.sql
│   ├── 04_Reviews.sql
│   ├── 05_Orders_Delivery.sql
│
└── screenshots/
    └── database_diagram.png
```
