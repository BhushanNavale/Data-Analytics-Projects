/* -: ADVANCE QUERIES :- */

-- "Assign an order number to every order for each customer based on the order date."
-- method-1
WITH customer_orders AS
(
	SELECT 
		U.user_id,
		U.`name`,
		O.order_id,
		O.order_date
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
	GROUP BY 
		U.user_id,
		U.`name`,
		O.order_id,
		O.order_date
),
ordering_number AS
(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY order_date) AS order_number
	FROM customer_orders
)
SELECT * FROM ordering_number;

-- method-2
SELECT 
		U.user_id,
		U.`name`,
		O.order_id,
		O.order_date, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY order_date) AS order_number
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id;
    
-- "For every order, show the previous order amount placed by the same customer."
SELECT 
	U.user_id,
    U.`name`,
    O.order_id,
    O.order_date,
    O.total_amount,
    LAG(total_amount) OVER(PARTITION BY user_id ORDER BY order_date) AS previous_order_amount
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id;

-- "For every order, show whether the order amount increased, decreased, or stayed the same compared to the customer's previous order."
-- method-1
SELECT 
	U.user_id,
    U.`name`,
    O.order_id,
    O.order_date,
    O.total_amount,
    LAG(total_amount) OVER(PARTITION BY user_id ORDER BY order_date) AS previous_order_amount,
    CASE
		WHEN O.total_amount > LAG(total_amount)OVER(PARTITION BY user_id ORDER BY order_date) THEN 'increased'
        WHEN O.total_amount < LAG(total_amount)OVER(PARTITION BY user_id ORDER BY order_date) THEN 'decreased'
        WHEN O.total_amount = LAG(total_amount)OVER(PARTITION BY user_id ORDER BY order_date) THEN 'no change'
        ELSE 'first order'
	END AS order_trend
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id;

-- method-2
WITH order_history AS
(
	SELECT 
	U.user_id,
    U.`name`,
    O.order_id,
    O.order_date,
    O.total_amount,
    LAG(total_amount) OVER(PARTITION BY user_id ORDER BY order_date) AS previous_order_amount
    FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
)
SELECT *,
		CASE
			WHEN total_amount > previous_order_amount THEN 'increased'
			WHEN total_amount < previous_order_amount THEN 'decreased'
			WHEN total_amount = previous_order_amount THEN 'no change'
			ELSE 'first order'
		END AS order_trend
FROM order_history;

-- Calculate the cumulative (running total) revenue by month.
WITH monthly_trend AS
(
	SELECT 
		YEAR(O.order_date) AS `year`,
		MONTH(O.order_date) AS month_no,
		monthname(O.order_date) AS `month`,
		ROUND(SUM(O.total_amount),2) AS monthly_revenue
 	FROM orders AS O
    GROUP BY 
		`year`,
        month_no,
        `month`
)
SELECT *,
		SUM(monthly_revenue) OVER(PARTITION BY `year` ORDER BY `year`,month_no) AS cumulative_revenue
FROM monthly_trend;

-- "Show only the orders where the current order amount is greater than the previous order amount for the same customer."
WITH order_history as
(
	SELECT 
		U.user_id,
		U.`name`,
		O.order_id,
		O.order_date,
		O.total_amount AS current_order_amount,
		LAG(total_amount) OVER(PARTITION BY user_id ORDER BY order_date)  AS previous_order_amount
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
)
SELECT *
FROM order_history
WHERE current_order_amount > previous_order_amount;

-- Show the highest-value order for every customer.
WITH ranked_customers as
(
	SELECT 
			U.user_id,
			U.`name`,
			O.order_id,
			O.order_date,
			total_amount AS order_amount,
			ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY total_amount DESC)  AS ranking
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
)
SELECT 	
	user_id,
    name,
    order_id,
    order_date,
    order_amount
FROM ranked_customers
WHERE ranking = 1;

-- "Show the latest order placed by every customer."
WITH latest_order as
(
	SELECT 
			U.user_id,
			U.`name`,
			O.order_id,
			O.order_date,
			total_amount AS order_amount,
			ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY order_date DESC, order_id DESC)  AS ranking
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
)
SELECT 	
	user_id,
    name,
    order_id,
    order_date,
    order_amount
FROM latest_order
WHERE ranking = 1;

-- "Show every order along with the customer's average order amount."
SELECT 
		U.user_id,
		U.`name`,
		O.order_id,
		O.order_date,
		total_amount AS order_amount,
		avg(total_amount) OVER(PARTITION BY user_id)  AS avg_order_amount
FROM users AS U
JOIN orders AS O
ON U.user_id = O.user_id;

-- "Show only the orders where the order amount is greater than the customer's average order amount."
WITH greater_order_amount AS
(
	SELECT 
			U.user_id,
			U.`name`,
			O.order_id,
			O.order_date,
			total_amount AS order_amount,
			avg(total_amount) OVER(PARTITION BY user_id)  AS avg_order_amount
	FROM users AS U
	JOIN orders AS O
	ON U.user_id = O.user_id
)
SELECT *
FROM greater_order_amount
WHERE order_amount > avg_order_amount;

-- "Calculate the number of days between each order and the customer's previous order."
WITH total_days AS
(
    SELECT 
		U.user_id,
		U.name,
		O.order_id,
		O.order_date,
		LAG(O.order_date) OVER(PARTITION BY user_id ORDER BY order_date) AS previous_order_date
	FROM users AS U 
	JOIN orders AS O
	ON U.user_id = O.user_id
)
SELECT  *,datediff(order_date,previous_order_date) AS days_between_orders
FROM total_days
;