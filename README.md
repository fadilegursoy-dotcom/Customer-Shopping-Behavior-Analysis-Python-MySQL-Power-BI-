# Customer Shopping Behavior Analysis (Python + MySQL + Power BI)

## Overview
This project shows how I used **one dataset** and connected **three tools** together:

**Python → MySQL → Power BI**

I cleaned the data in Python, stored it in a MySQL database, analyzed it with SQL queries, and built a visual dashboard in Power BI.

---

## Project Flow

CSV File → Python → MySQL Database → Power BI Dashboard

yaml
Copiar código

---

## 1. Python Work

In Python, I:

- Loaded the CSV file using pandas
- Checked the data (`head`, `info`, `describe`)
- Filled missing values in `Review Rating` using the median
- Cleaned column names (lowercase + no spaces)
- Renamed `purchase_amount_(usd)` to `purchase_amount`
- Created a new column `age_group` from the `age` column
- Converted purchase frequency text into days (`purchase_frequency_days`)
- Removed a duplicate column (`promo_code_used`)
- Connected to MySQL using SQLAlchemy
- Sent the cleaned data to the MySQL table **customer_shopping_behavior**

So after the Python step, the data was ready in MySQL.

---

## 2. MySQL / SQL Work

In MySQL, I worked on the same table:

**shopping_db.customer_shopping_behavior**

I wrote SQL queries to answer business questions such as:

- Revenue by gender  
- Which customers spend more even with discounts  
- Top 5 products by review rating  
- Average purchase amount by shipping type  
- Subscribers vs non-subscribers  
- Top discount-dependent products  
- Customer segmentation (New / Returning / Loyal)  
- Top 3 products per category  
- Repeat buyers based on `previous_purchases`  
- Revenue by age group

These SQL queries helped me understand customer behavior.

---

## 3. Power BI Dashboard

In Power BI, I **connected directly to the same MySQL database**.  
I used the table **customer_shopping_behavior** to build an interactive dashboard.

The dashboard includes:

**KPIs**
- Number of Customers
- Average Purchase Amount
- Average Review Rating

**Charts**
- Customers by Subscription Status
- Revenue by Category
- Items Purchased by Category
- Revenue by Age Group
- Items Purchased by Age Group

**Filters**
- Subscription Status
- Gender
- Category
- Shipping Type

This dashboard allows users to explore customer behavior visually.

---

## Tools Used
- Python (pandas, SQLAlchemy)
- MySQL
- Power BI

---

## Summary
This project demonstrates an end-to-end data pipeline where:

- Python cleans and prepares the data
- MySQL stores and analyzes the data
- Power BI visualizes the results

All parts work together using the **same dataset**.
