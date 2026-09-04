# business queries

-- Q1. What is the total revenue generated?
SELECT 
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2) AS total_revenue
FROM
    orders o
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Completed';

-- Q2. How much revenue did we generate each month?
SELECT 
    MONTH(o.order_date) AS month_no,
    MONTHNAME(o.order_date) AS months,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2) AS total_revenue
FROM
    orders o
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY month_no , months
ORDER BY month_no;

-- Q3. Is revenue increasing or decreasing month over month?
with monthly_revenue_trend as 
(
select 
	month(o.order_date) as month_no,
	monthname(o.order_date) as months,
    round(sum(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) as current_revenue,
    lag(round(sum(oi.quantity * oi.unit_price * (1 - oi.discount)), 2)) over(order by	month(o.order_date) ) as previous_revenue 
from orders o
join order_items oi
    on o.order_id = oi.order_id
where o.order_status = 'Completed'
group by month_no, months
)	
select *,
    case
		when current_revenue > previous_revenue then 'increased'
        when current_revenue < previous_revenue then 'decreased'
        when current_revenue = previous_revenue then 'same'
        else 'no previous revenue'
	end as trend
from monthly_revenue_trend;

-- Q4. What is the average order value (AOV)?
SELECT 
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)) / COUNT(DISTINCT o.order_id),
            2) AS average_order_value
FROM
    orders o
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Completed';

-- Q5.Which months generated the highest and lowest revenue?
with monthly_revenue as
(
select 
	monthname(o.order_date) as month,
   round(sum(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) as total_revenue
from orders o
join order_items oi
    on o.order_id = oi.order_id
where o.order_status = 'Completed'
group by  month
),
ranked_months as
(
select
	month,
    total_revenue,
    rank() over(order by total_revenue desc) as highest_rank,
    rank() over(order by total_revenue asc) as lowest_rank
from monthly_revenue
) 
select 
    month,
    total_revenue,
    case
        when highest_rank = 1 then 'highest'
        when lowest_rank = 1 then 'lowest'
    end as revenue_type
from ranked_months
where highest_rank = 1
   or lowest_rank = 1;

-- Q6. How many orders were Completed, Cancelled, Returned, and Pending, and what percentage does each represent?
SELECT 
    TRIM(order_status) AS order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT 
                    COUNT(*)
                FROM
                    orders),
            2) AS percentage
FROM
    orders
GROUP BY TRIM(order_status);
 
 -- Q7. Who are our top 10 customers based on total spending?
SELECT 
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2) AS total_spending
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY c.customer_id , c.customer_name
ORDER BY total_spending DESC
LIMIT 10;
 
 -- Q8. Which customers have placed the most orders?
SELECT 
    c.customer_id, c.customer_name, COUNT(*) AS order_count
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.customer_name
ORDER BY order_count DESC
LIMIT 10;
 
 -- Q9. how many customers are repeat customers, and how many purchased only once?
SELECT 
    SUM(order_count > 1) AS total_repeted_customers,
    SUM(order_count = 1) AS purchased_only_once
FROM
    (SELECT 
        customer_id, COUNT(*) AS order_count
    FROM
        orders
    GROUP BY customer_id) AS customer_count;
 
 -- Q10. What is the average amount spent by a customer?
 with customers_spending as
 (
  select 
	c.customer_id,
    c.customer_name, 
    round(sum(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) as total_spending
 from customers as c
 join orders as o
 on c.customer_id = o.customer_id
join order_items oi
    on o.order_id = oi.order_id
where o.order_status = 'Completed'
 group by c.customer_id,c.customer_name 
 )
 select round(avg(total_spending),2) as avg_spent_amount
 from customers_spending;
 
-- Q11. Which cities generate the most revenue?
SELECT 
    c.city,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2) AS total_revenue
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 10;
 
 -- Q12. Which 10 products generate the most revenue?
SELECT 
    pdt.product_id,
    pdt.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2) AS total_revenue
FROM
    products pdt
        JOIN
    order_items oi ON pdt.product_id = oi.product_id
        JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY pdt.product_id , pdt.product_name
ORDER BY total_revenue DESC
LIMIT 10;
 
 -- Q13. Which 10 products sell the most units?
SELECT 
    pdt.product_id,
    pdt.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM
    products pdt
        JOIN
    order_items oi ON pdt.product_id = oi.product_id
        JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY pdt.product_id , pdt.product_name
ORDER BY total_units_sold DESC
LIMIT 10;
 
 -- Q14. Which products generate the highest profit?
 with product_profit as (
    select
        pdt.product_id,
        pdt.product_name,
        round(sum(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) as total_revenue,
        round(sum(oi.quantity * pdt.cost), 2) as total_cost

from orders o
join order_items oi
    on o.order_id = oi.order_id
    join products as pdt
        on oi.product_id = pdt.product_id
        WHERE o.order_status = 'Completed'
		AND pdt.cost IS NOT NULL
    group by pdt.product_id, pdt.product_name
)
select
    product_id,
    product_name,
    total_revenue,
    total_cost,
    round(total_revenue - total_cost, 2) as profit
from product_profit
order by profit desc
limit 10;

-- Q15. Which products have the lowest profit?
 with product_profit as (
    select
        pdt.product_id,
        pdt.product_name,
        round(sum(oi.quantity * oi.unit_price * (1 - oi.discount)), 2) as total_revenue,
        round(sum(oi.quantity * pdt.cost), 2) as total_cost
from orders o
join order_items oi
    on o.order_id = oi.order_id
    join products as pdt
        on oi.product_id = pdt.product_id
        WHERE o.order_status = 'Completed'
		AND pdt.cost IS NOT NULL
    group by pdt.product_id, pdt.product_name
)
select
    product_id,
    product_name,
    total_revenue,
    total_cost,
    round(total_revenue - total_cost, 2) as profit
from product_profit
order by profit asc
limit 10;

-- Q16. Which categories generate the most revenue?
SELECT 
    ct.category_id,
    ct.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount)),
            2) AS total_revenue
FROM
    order_items AS oi
        JOIN
    products AS pdt ON oi.product_id = pdt.product_id
        JOIN
    categories AS ct ON pdt.category_id = ct.category_id
        JOIN
    orders AS o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Completed'
GROUP BY ct.category_id , ct.category_name
ORDER BY total_revenue DESC;

-- Q17. Which categories generate the most profit?
WITH category_profit AS
(
    SELECT
        ct.category_id,
        ct.category_name,

        ROUND(
            SUM(
                oi.quantity * oi.unit_price * (1 - oi.discount)
            ), 2
        ) AS total_revenue,

        ROUND(
            SUM(
                oi.quantity * pdt.cost
            ), 2
        ) AS total_cost

    FROM order_items AS oi

    JOIN products AS pdt
        ON oi.product_id = pdt.product_id

    JOIN categories AS ct
        ON pdt.category_id = ct.category_id

    JOIN orders AS o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'Completed'
      AND pdt.cost IS NOT NULL

    GROUP BY
        ct.category_id,
        ct.category_name
)

SELECT
    category_id,
    category_name,
    total_revenue,
    total_cost,
    ROUND(total_revenue - total_cost, 2) AS total_profit
FROM category_profit
ORDER BY total_profit DESC;

-- Q18. Which products have never been purchased?
SELECT 
    pdt.product_id, pdt.product_name
FROM
    products AS pdt
        LEFT JOIN
    (SELECT DISTINCT
        oi.product_id
    FROM
        order_items AS oi
    JOIN orders AS o ON oi.order_id = o.order_id
    WHERE
        o.order_status = 'Completed') AS purchased_products ON pdt.product_id = purchased_products.product_id
WHERE
    purchased_products.product_id IS NULL
ORDER BY pdt.product_id;

-- Q19. What is the overall average product rating?
SELECT 
    ROUND(AVG(rating), 2) AS avg_rating
FROM
    reviews;

-- Q20. Which categories have the highest and lowest average ratings?
with category_rating as
(
	select ct.category_name, round(avg(r.rating),2) as avg_rating
	from reviews as r
	join products as pdt 
	on r.product_id = pdt.product_id
	join categories as ct
	on pdt.category_id = ct.category_id
    GROUP BY ct.category_name
),
ranked_category as
(
select 
	category_name,
	avg_rating,
    rank() over(order by avg_rating desc) as highest_rating,
    rank() over(order by avg_rating asc) as lowest_rating
    from category_rating
)
select 
	category_name,
	avg_rating,
        case
        when highest_rating = 1 then 'highest'
        when lowest_rating = 1 then 'lowest'
    end as rating_type
from ranked_category
where highest_rating = 1
   or lowest_rating = 1;

-- Q21. Which products have the highest number of reviews?
SELECT 
    pdt.product_id, pdt.product_name, COUNT(*) AS total_ratings
FROM
    products AS pdt
        JOIN
    reviews AS r ON pdt.product_id = r.product_id
GROUP BY pdt.product_id , pdt.product_name
ORDER BY total_ratings DESC
LIMIT 10;

-- Q22. Which products have high sales but low ratings?
WITH product_revenue AS
(
    SELECT
        pdt.product_id,
        pdt.product_name,
        ROUND(
            SUM(
                oi.quantity * oi.unit_price * (1 - oi.discount)
            ), 2
        ) AS total_revenue
    FROM products AS pdt

    JOIN order_items AS oi
        ON pdt.product_id = oi.product_id

    JOIN orders AS o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'Completed'

    GROUP BY
        pdt.product_id,
        pdt.product_name
),

product_rating AS
(
    SELECT
        r.product_id,
        ROUND(AVG(r.rating), 2) AS avg_rating
    FROM reviews AS r
    GROUP BY r.product_id
),

revenue_group AS
(
    SELECT
        product_id,
        product_name,
        total_revenue,

        NTILE(4) OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_quartile

    FROM product_revenue
),

rating_group AS
(
    SELECT
        product_id,
        avg_rating,

        NTILE(4) OVER (
            ORDER BY avg_rating ASC
        ) AS rating_quartile

    FROM product_rating
)

SELECT
    rg.product_id,
    rg.product_name,
    rg.total_revenue,
    rt.avg_rating
FROM revenue_group AS rg

JOIN rating_group AS rt
    ON rg.product_id = rt.product_id

WHERE rg.revenue_quartile = 1
  AND rt.rating_quartile = 1

ORDER BY rg.total_revenue DESC;

-- Q23. Which payment methods are used the most?
SELECT 
    payment_method, COUNT(*) AS used_count
FROM
    payments
GROUP BY payment_method
ORDER BY used_count DESC;

-- Q24. How much revenue comes from each payment method?

SELECT 
    p.payment_method,
    ROUND(
        SUM(
            oi.quantity 
            * oi.unit_price 
            * (1 - oi.discount)
        ), 
        2
    ) AS total_revenue
FROM payments AS p
JOIN orders AS o 
    ON p.order_id = o.order_id
JOIN order_items AS oi 
    ON o.order_id = oi.order_id
WHERE LOWER(TRIM(o.order_status)) = 'completed'
  AND LOWER(TRIM(p.payment_status)) = 'successful'
GROUP BY p.payment_method
ORDER BY total_revenue DESC;

-- Q25. Which payment methods have the highest number of failed payments?
SELECT 
    payment_method, COUNT(payment_status) AS failed_payments
FROM
    payments
WHERE
    LOWER(TRIM(payment_status)) = 'failed'
GROUP BY payment_method
ORDER BY failed_payments DESC;
