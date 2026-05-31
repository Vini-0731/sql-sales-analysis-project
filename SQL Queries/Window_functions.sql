-- ======================================
-- WINDOW FUNCTION AND SUBQUERIES
-- =======================================

-- Q.1) Rank Sales Representatives by Total Revenue 
-- Q.2) Find Top-Selling Product Category in Each Region
-- Q.3) Find Customers Types Generating Above Average Revenue
-- Q.4) Month-over-Month Sales Growth
-- Q.5) Find Top 3 Highest Revenue Transactions in Each Region
-- Q.6) Compare Sales Rep Performance with Overall Average Revenue



-- Q.1) Rank Sales Representatives by Total Revenue 

SELECT sales_rep, SUM(sales_amount) AS total_sales,
RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM sales_data
GROUP BY sales_rep
ORDER BY sales_rank;


-- Insight:
-- Top-ranked sales representatives contribute a significant share of total revenue,
-- highlighting strong individual sales performance.


-- Q.2) Top-Selling Product Category in Each Region

WITH category_sales AS (SELECT *,
RANK() OVER(PARTITION  BY region ORDER BY SUM(sales_amount) DESC) AS rnk
FROM sales_data
GROUP BY region ,product_category)

SELECT * FROM category_sales
WHERE rnk=1;
 
-- Insight:
-- Certain product categories consistently perform well across multiple regions.


-- Q.3) Find Customers Types Generating Above Average Revenue

SELECT customer_type,SUM(sales_amount) AS total_revenue
FROM sales_data
GROUP BY customer_type
HAVING SUM(sales_amount) >
				(SELECT AVG(customer_sales) 
                 FROM (SELECT customer_type,SUM(sales_amount) AS customer_sales
                        FROM sales_data
						GROUP BY customer_type) AS avg_sales);

-- Insight:
-- Returning customers generate above-average revenue,
-- emphasizing the value of customer retention.



-- Q.4) Month-over-Month Sales Growth

WITH monthly_sales AS (SELECT MONTH(STR_TO_DATE(Sale_Date,'%d-%m-%Y')) AS sales_month,
					ROUND(SUM(Sales_Amount),2) AS total_sales
                    FROM sales_data
                    GROUP BY MONTH(STR_TO_DATE(Sale_Date,'%d-%m-%Y')))


SELECT sales_month,total_sales,
ROUND(LAG(total_sales) OVER(ORDER BY sales_month),2) AS previous_month_sales,
ROUND(((total_sales - LAG(total_sales) OVER(ORDER BY sales_month))/ LAG(total_sales) OVER(ORDER BY sales_month)) * 100,2) AS sales_growth_percentage
FROM monthly_sales;

-- Insight:
-- Month-over-month sales growth analysis reveals business performance trends
-- and helps identify periods of increasing or declining revenue.



-- Q.5) Top 3 Highest Revenue Transactions in Each Region

WITH ranked_sales AS (SELECT *,
					DENSE_RANK() OVER(PARTITION BY region  ORDER BY sales_amount DESC) AS rnk
					FROM sales_data)
SELECT * 
FROM ranked_sales
WHERE rnk<=3;

-- Insight:
-- Some regions generate larger high-value transactions compared to others,
-- indicating stronger purchasing power.


-- Q.6 Compare Sales Rep Performance with Overall Average Revenue

SELECT sales_rep,SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY sales_rep
HAVING SUM(sales_amount)>(SELECT AVG(rep_sales) FROM (SELECT sales_rep,SUM(sales_amount) AS rep_sales
                            FROM sales_data
							GROUP BY sales_rep) AS avg_rep_sales)


-- Insight:
-- Several sales representatives perform above the overall average revenue,
-- demonstrating exceptional sales performance.