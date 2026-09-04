# customer table
-- view table
describe customers;
select * from customers;

-- Q1. How many unique customers do we have?
select count(distinct customer_id) as total_unique_customers
from customers;

-- Q2. Are there any duplicate customers or missing customer information?
-- duplicate customers
select customer_id, count(*) as duplicate_customers
from customers
group by customer_id
having count(*) > 1;

-- missing customer information
SELECT
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(customer_name IS NULL) AS missing_name,
    SUM(email IS NULL) AS missing_email,
    SUM(gender IS NULL) AS missing_gender,
    SUM(city IS NULL) AS missing_city,
    SUM(state IS NULL) AS missing_state
FROM customers;
   
-- Q3. Which cities and states have the most customers?
select state, city, count(*) as total_customers
from customers
group by state, city
order by total_customers desc;

# categories table
-- view table
describe categories;
select * from categories;

-- Q4. How many products are there in each category?
select category_name, count(*) as total_products
from categories 
join products 
on categories.category_id = products.category_id
group by category_name
order by total_products desc;

# products table
-- view table
describe products;
select * from products;

-- Q5. Are any product details missing, such as price, cost, brand, or category?
SELECT
    SUM(price IS NULL) AS missing_price,
    SUM(cost IS NULL) AS missing_cost,
    SUM(brand IS NULL) AS missing_brand,
    SUM(category_id IS NULL) AS missing_category
FROM products;
   
-- Q6. Are there any products where the cost is equal to or higher than the selling price?
SELECT
    product_id,
    product_name,
    cost,
    price
FROM products
WHERE cost >= price;

-- Q7. Which products have the highest and lowest prices?
-- highest prices
select 
	product_id,
	product_name,
	price
from products
order by price desc
limit 10;

-- lowest prices
select 
	product_id,
	product_name,
	price
from products
order by price asc
limit 10;

# orders table
-- view table
describe orders;
select * from orders;

-- Q8. How many orders do we have, and what dates does the data cover?
select count(distinct order_id) as total_orders
from orders;

select min(order_date) as earliest_order_date,
	max(order_date) as latest_order_date
from orders;

-- Q9. How many orders are Completed, Cancelled, Returned, and Pending?
select order_status, count(*) as total_orders
from orders
group by order_status 
order by total_orders desc;

-- Q10. Are there any orders with missing dates or customers that don't exist in the customer table?
select order_id
from orders
where order_date is null;

select order_id
from orders
left join customers
on orders.customer_id = customers.customer_id
where customers.customer_id is null;

-- Q11. How many orders were placed each month?
select month(order_date) as month_no, monthname(order_date) as month , count(*) as total_orders 
from orders
group by month, month_no
order by month_no;

# order_items table
-- view table
describe order_items;
select * from order_items;

-- Q12. Are all order items connected to a valid order and product?
select order_item_id
from order_items as oi
left join orders as o
on oi.order_id = o.order_id
left join products as p
on oi.product_id = p.product_id
where o.order_id is null
	or p.product_id is null;

-- Q13. Are there any invalid quantities or discounts?
select *
from order_items
where quantity = 0 or discount < 0 ; 

-- Q14. How many products are usually included in one order?
select avg(total_product) as avg_products_per_order
from
	(select order_id, count(*) as total_product
	from order_items
	group by order_id) as order_summary;

# payments table
-- view table
describe payments;
select * from payments;

-- Q15. Does every order have a payment record?
select *
from orders as o
left join payments as p
on o.order_id = p.order_id
where p.order_id is null;

-- Q16. Are there any missing payment methods, payment statuses, or payment amounts
SELECT
    SUM(payment_method IS NULL) AS missing_payment_method,
    SUM(payment_status IS NULL) AS missing_payment_status,
    SUM(amount IS NULL) AS missing_payment_amount
FROM payments;

# reviews table
-- view table
describe reviews;
select * from reviews;

-- Q17. Are all product ratings between 1 and 5, and are any review details missing?
SELECT *
FROM reviews
WHERE rating < 1 OR rating > 5;

SELECT
    SUM(review_id IS NULL) AS missing_review_id,
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(rating IS NULL) AS missing_rating,
    SUM(review_date IS NULL) AS missing_review_date,
    SUM(review_text IS NULL) AS missing_review_text
FROM reviews;

-- Q18. How many reviews do we have for each rating from 1 to 5?
select rating,count(*) as total_reviews
from reviews
group by rating
order by rating;


