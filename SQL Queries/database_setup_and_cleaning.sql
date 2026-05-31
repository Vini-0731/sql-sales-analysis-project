-- SQL Sales Analysis Project

-- =========================================
-- DATABASE SETUP & DATA CLEANING
-- =========================================


-- Create Database

CREATE DATABASE sales_analysis;


-- Use Database

USE sales_analysis;


-- Create TABLE 

DROP TABLE IF EXISTs sales_data;
CREATE TABLE sales_data(
Product_id INT,
Sale_Date TEXT,
Sales_Rep TEXT,
Region TEXT,
Sales_Amount DOUBLE,
Quantity_Sold INT,
Product_Category TEXT,
Unit_Cost DOUBLE,
Unit_Price DOUBLE,
Customer_Type TEXT,
Discount DOUBLE,
Payment_Method TEXT,
Sales_Channel TEXT,
Region_and_Sales_Rep TEXT);


SELECT * FROM sales_data
LIMIT 10;


SELECT COUNT(*) FROM sales_data;


-- =====================
-- Data Cleaning 
-- ======================


-- Checking NULL values

SELECT * FROM sales
WHERE transaction_id IS NULL;


SELECT * FROM sales
WHERE sale_date IS NULL;


SELECT * FROM sales_data
WHERE product_id IS NULL OR
sale_date IS NULL OR
sales_rep IS NULL OR
region IS NULL OR
sales_amount IS NULL OR
quantity_sold IS NULL OR
product_category IS NULL ;


      



