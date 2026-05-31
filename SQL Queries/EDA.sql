-- =========================================
-- EXPLORATORY DATA ANALYSIS (EDA)
-- =========================================

USE sales_analysis;

-- 1.) Total Number of Records

SELECT COUNT(*) AS Total_records 
FROM sales_data;

-- Insights:
-- Dtaset contains 1000 recorde for analysis

-- 2.) How many Unique Product Categories we have?

SELECT DISTINCT product_category 
FROM sales_data;


-- 3.) Find Number of Sales in Each Region
SELECT region, COUNT(*) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;


-- Insights:
-- North region has the highest number of sales, 
-- Indicates stronger customer activity.


-- 4.) Find Minimum, Maximum and Average Sales Amount
SELECT MAX(Sales_amount) AS Maximum_sales,
       MIN(Sales_amount) AS Minimum_sales,
       AVG(Sales_amount) AS Average_sales
FROM sales_data;   


-- Insights:
-- Large difference between minimum and maximum sales
-- suggests varying customer purchasing patterns.