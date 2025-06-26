-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_query_p1;

-- USE The Current Table
USE sql_query_p1;

-- CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

select * from retail_sales
LIMIT 10;

select count(*) from retail_sales; 	

-- Data Cleaning
select * from retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null
	or customer_id is null
	or gender is null
	or age is null
	or category is null
	or quantiy is null
	or quantiy is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;
-- 
DELETE FROM retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null
	or customer_id is null
	or gender is null
	or age is null
	or category is null
	or quantiy is null
	or quantiy is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;
    
-- Data Exploration   
-- How many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales;

-- How many uniuque customers we have ?
SELECT COUNT(distinct customer_id) AS total_customers FROM retail_sales;

SELECT COUNT(DISTINCT category) as unique_category FROM retail_sales;

SELECT DISTINCT category as unique_category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 SELECT * FROM retail_sales
 where sale_date='2022-11-05';
 
 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE 
	category='Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
	AND quantiy >= 4;
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.    
 SELECT category,
	sum(total_sale) as total_sales,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM retail_sales
WHERE total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) as total_trans
FROM retail_sales
GROUP BY 1,2
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH cte1 AS
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS highest
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT * 
FROM cte1
WHERE highest = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, 
		SUM(total_sale) as highest_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
		COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales
GROUP BY 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sales as (
SELECT *,
	CASE 
		WHEN HOUR(sale_time)<12 THEN 'morning'
		WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
		ELSE 'evening'
	END AS shifts
FROM retail_sales
)
SELECT shiftS,
		COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY 1;

-- End of project






 
 