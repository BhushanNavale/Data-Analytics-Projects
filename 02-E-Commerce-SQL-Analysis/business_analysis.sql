/* -: BUSINESS REQUIREMENTS :- */

-- Management wants to know which products generate the highest revenue so they can prioritize inventory and marketing
SELECT p.product_id, P.product_name, round(SUM(OI.item_total),2) AS total_revenue
FROM products AS P
JOIN order_items AS OI
ON P.product_id = OI.product_id
GROUP BY 
	p.product_id,
	P.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Management wants to identify the top 10 customers by total spending.
SELECT U.user_id, U.`name` , round(SUM(O.total_amount),2) AS total_spending
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id
GROUP BY 
	U.user_id,
    U.`name`
ORDER BY total_spending DESC
LIMIT 10;

-- Management wants to know Which product categories generate the highest revenue?
SELECT P.category, ROUND(SUM(OI.item_total),2) AS total_revenue
FROM products AS P
JOIN order_items AS OI
ON P.product_id = OI.product_id
GROUP BY P.category
ORDER BY total_revenue DESC;

-- The Sales Director wants to identify customers who have placed the highest number of orders.
SELECT U.user_id, U.`name`, COUNT(*) AS total_orders
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id
GROUP BY 
	U.user_id,
    U.`name`
ORDER BY total_orders DESC;

-- Management wants to know Products that have high sales but poor customer ratings. //////tough
-- MY ANSWER
/*SELECT P.product_name, ROUND(SUM(OI.item_total),2) AS revenue
FROM products AS P
JOIN order_items AS OI
ON P.product_id = OI.product_id
JOIN reviews AS R
ON P.product_id = R.product_id
where R.rating < 3
GROUP BY P.product_name
ORDER BY revenue DESC
LIMIT 10; */

WITH product_revenue AS
	(	
		SELECT product_id, ROUND(SUM(item_total),2) AS total_revenue 
        FROM order_items
        GROUP BY product_id
	),
product_rating AS 
	(
		SELECT product_id, ROUND(avg(rating),2) AS average_rating 
		FROM reviews 
        GROUP BY product_id
)
SELECT P.product_id,
	   P.product_name,
       PRV.total_revenue,
       PRT.average_rating
FROM products AS P
JOIN product_revenue as PRV
	ON P.product_id = PRV.product_id
JOIN product_rating as PRT
	ON P.product_id = PRT.product_id 
WHERE PRT.average_rating < 3
ORDER BY PRV.total_revenue DESC
LIMIT 10
;

-- Which products sold the highest number of units?
-- METHOD:-1
SELECT 
	  P.product_id, 
      P.product_name, 
      SUM(OI.quantity) AS total_units
FROM products AS P
JOIN order_items AS OI
ON P.product_id = OI.product_id
GROUP BY 
	  P.product_id,
	  P.product_name
ORDER BY total_units DESC 
LIMIT 10;

-- METHOD:-2 USING CTE's
WITH total_units AS
(
	SELECT product_id,SUM(quantity) AS total_sold_unit
    FROM order_items
    GROUP BY product_id
)
SELECT 
	  P.product_name,
      TU.total_sold_unit
FROM products AS P
JOIN total_units AS TU
ON P.product_id = TU.product_id
ORDER BY TU.total_sold_unit DESC
limit 10
;
	
-- Management don't just want the top-selling products overall. I want to know the top-selling product in each category  //////tough
WITH total_revenue AS
(
		SELECT 
				P.product_id,
                P.product_name,
                P.category,
                SUM(OI.item_total) AS revenue
        FROM products AS P
        JOIN order_items AS OI 
        ON P.product_id = OI.product_id
        GROUP BY 
				P.product_id,
                P.product_name,
                P.category
),
rank_product AS
(
		SELECT * , 
        row_number() 
        OVER	
			(partition by category
			 ORDER BY revenue DESC
			) AS row_num
		FROM total_revenue
) 
SELECT 
	  category, 
      product_name,
      ROUND(revenue,2) AS revenue
FROM rank_product
WHERE row_num = 1
ORDER BY revenue DESC;

-- Manager wants to analyze the company's performance over time. ///// Show me the monthly revenue trend
SELECT 
		YEAR(order_date) AS years,
		MONTH(order_date) AS month_no,
		monthname(order_date) AS months,
		round(sum(total_amount),2) AS revenue 
FROM orders 
GROUP BY years, month_no, months
ORDER BY years, month_no;

-- Show me the monthly order trend.
SELECT 
		YEAR(order_date) AS years,
		MONTH(order_date) AS month_no,
		monthname(order_date) AS months,
        count(*) AS total_orders
FROM orders
GROUP BY years, month_no, months
ORDER BY years, month_no;

-- Which brands generate the highest revenue?
SELECT 
		P.brand,
        ROUND(SUM(item_total),2) AS revenue
FROM products AS P
JOIN order_items AS OI
ON P.product_id = OI.product_id
GROUP BY P.brand
ORDER BY revenue DESC
LIMIT 10;

-- Which cities generate the highest revenue? 
SELECT 
		U.city,
        ROUND(SUM(O.total_amount),2) as revenue
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id
GROUP BY U.city
ORDER BY revenue DESC
LIMIT 10;

-- Which customers have placed only one order?
SELECT U.user_id,U.`name` , COUNT(*) AS total_orders
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id
WHERE O.order_status = 'completed' 
GROUP BY U.user_id, U.`name`
HAVING COUNT(*) = 1;

-- Which customers have never written a review?
SELECT U.user_id, U.`name`, U.email
FROM users AS U
LEFT JOIN reviews AS R
ON U.user_id = R.user_id
WHERE R.review_id IS NULL;
 
 -- Which products have never been ordered?
SELECT P.product_id, P.product_name, P.category, P.brand
FROM products AS P
LEFT JOIN order_items AS OI
ON P.product_id = OI.product_id
WHERE OI.order_item_id IS NULL;

-- Management wants to know which gender generates the highest revenue.
SELECT U.gender , ROUND(SUM(O.total_amount),2) AS total_revenue
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id
GROUP BY U.gender
ORDER BY total_revenue DESC;

-- What is the average order value (AOV) for each month
SELECT 
		year(O.order_date) AS `year`,
        month(O.order_date) AS month_no,
		monthname(O.order_date) AS `month`, 
		ROUND(avg(O.total_amount),2) AS avg_order_value
FROM orders AS O
GROUP BY `year`, month_no, `month`
ORDER BY `year`, month_no ;

-- Most active users (based on events)
SELECT 
		U.user_id,
        U.name,
        count(*) AS total_events
FROM users AS U
JOIN events AS E
ON U.user_id = E.user_id
GROUP BY U.user_id, U.name
ORDER BY total_events DESC
LIMIT 10;

-- Top 5 customers in each city by spending (Window Function)  //////tough 
WITH customer_spending AS
(
	SELECT
		U.user_id,
		U.name, U.city ,
        round(SUM(O.total_amount),2) AS total_spending
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
	GROUP BY
		U.user_id,
		U.name,
        U.city
) ,
ranked_customers AS 
(
	SELECT *,
			ROW_NUMBER() 	
            OVER(
				PARTITION BY city ORDER BY total_spending DESC
                ) AS ranking
	FROM customer_spending
)
SELECT
	user_id,
    name,
    city,
    total_spending
FROM ranked_customers
WHERE ranking <=5;

-- Repeat customers (more than one completed order)
SELECT U.user_id, U.name, COUNT(*) AS completed_orders
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id
WHERE O.order_status = 'completed' 
GROUP BY U.user_id, U.name
HAVING COUNT(*) > 1; 

-- Customer Lifetime Value (CLV) and rank them
SELECT 
	U.user_id,	
    U.name ,
    ROUND(sum(O.total_amount),2) AS lifetime_value ,
	RANK() OVER(ORDER BY sum(O.total_amount) DESC) AS customer_rank
FROM users AS U 
JOIN orders AS O
ON U.user_id = O.user_id
GROUP BY U.user_id, U.name
ORDER BY customer_rank;