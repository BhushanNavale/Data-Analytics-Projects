/*Users Table Exploration :- */

-- View table
DESCRIBE users;
SELECT * FROM users;

-- Q1:- TOTAL NUMBER OF USERS
SELECT count(*) FROM users;

-- Q2:- GENDER DISTRIBUTION
SELECT gender, count(*) AS total_users
FROM users
GROUP BY gender
ORDER BY total_users DESC;

-- Q3:- USERS BY CITY
SELECT city , count(*) AS total_users
FROM users
GROUP BY city
ORDER BY total_users DESC;

-- Q4:- LIST OF CITIES
SELECT DISTINCT city FROM users;

-- Q5:- MISSING EMAILS
SELECT count(*) AS missing_emails
FROM users
WHERE email IS NULL;

-- Q6:- GENDER DISTRIBUTION(%)
SELECT gender,
       COUNT(*) AS total_users,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM users
GROUP BY gender;


/* Product Table Exploration :- */

-- View Table
describe products;
SELECT * FROM products;

-- Q1:- TOTAL NUMBER OF PRODUCT
SELECT COUNT(*) AS total_products
FROM products;

-- Q2:- TOTAL NUMBER OF CATEGORIES
SELECT COUNT(DISTINCT category) AS total_categories
FROM products;

-- Q3:- TOTAL NUMBER OF BRANDS
SELECT COUNT(DISTINCT brand) AS total_brands
FROM products;

-- Q4:- LIST OF CATEGORIES
SELECT DISTINCT category 
FROM products
ORDER BY category ASC;

-- Q5:- LIST OF BRANDS
SELECT DISTINCT brand
FROM products
ORDER BY brand ASC;

-- Q6:- AVERAGE PRODUCT PRICE BY CATEGORY
SELECT category , round(avg(price),2) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

-- Q7:- NUMBER OF PRODUCTS IN EACH CATEGORY
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- Q8:- AVERAGE PRODUCT RATING BY CATEGORY
SELECT category , round(avg(rating),2) AS avg_rating
FROM products
GROUP BY category
ORDER BY avg_rating DESC;


/* Order  Table Exploration :- */

-- View Table
describe orders;
SELECT * FROM orders;

-- Q1:- TOTAL NUMBER OF ORDERS
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q2:- TOTAL NUMBER OF UNIQUE USERS
SELECT COUNT(DISTINCT user_id) AS total_users
FROM orders;

-- Q3:- NUMBER OF ORDERS FOR EACH ORDER STATUS
SELECT order_status,COUNT(*) AS total_orders
FROM orders	
GROUP BY order_status
ORDER BY total_orders DESC; 

-- Q4:- AVG ORDER AMOUNT BY ORDER_STATUS
SELECT order_status,ROUND(avg(total_amount),2) AS avg_order_amount
FROM orders
GROUP BY order_status
ORDER BY avg_order_amount;

-- Q5:- TOTAL SALES AMOUNT
SELECT ROUND(sum(total_amount),2) AS sales_amount
FROM orders;

-- Q6:- AVG ORDER AMOUNT
SELECT ROUND(avg(total_amount),2) AS avg_order_amount
FROM orders;

-- Q7:- LATEST ORDER
SELECT * 
FROM orders
ORDER BY order_date DESC
LIMIT 1;

-- Q8:- EARLIEST ORDER
SELECT * 
FROM orders
ORDER BY order_date ASC
LIMIT 1;


/* Order_items Table Exploration :- */

-- View Table
describe order_items;
SELECT * FROM order_items;

-- Q1:- TOTAL NUMBER OF ORDER_ITEMS
SELECT COUNT(*)
FROM order_items;

-- Q2:- DUPLICATE NUMBER OF ORDER_ITEMS
SELECT order_item_id, count(*) AS duplicate_count
FROM order_items
GROUP BY order_item_id 
HAVING count(*) > 1;

-- Q3:- TOTAL NUMBER OF UNIQUE PRODUCTS THAT SOLD
SELECT COUNT(DISTINCT product_id) AS total_products
FROM order_items;

-- Q4:-TOTAL UNIQUE USERS
SELECT COUNT(DISTINCT user_id) as total_users
FROM order_items;

-- Q5:- NUMBER OF ORDERS BY EACH USER
SELECT user_id, count(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY user_id
ORDER BY total_orders DESC;

-- Q6:- AVG PRICE OF PRODUCT 
SELECT product_id , ROUND(AVG(item_price),2) AS avg_price
FROM order_items
GROUP BY product_id;

-- Q7:- TOTAL SALES
SELECT ROUND(sum(item_total),2) as total_sales
FROM order_items;

-- Q8:- TOTAL NULL VALUES IN ORDER_ITEM_ID
SELECT COUNT(*) AS null_order_item_id
FROM order_items
WHERE order_item_id IS NULL;


/* REVIEWS Table Exploration :- */

-- View Table
describe reviews;
SELECT * FROM reviews;

-- Q1:- NUMBER OF TOTAL REVIEWS
SELECT COUNT(*) AS total_reviews
FROM reviews;

-- Q2:- DUPLICATE REVIEW COUNT
SELECT review_id, count(*) AS duplicate_reviews
FROM reviews
GROUP BY review_id
HAVING count(*) > 1 ; 

-- Q3:- NUMBER OF REVIEWS FOR EACH PRODUCT
SELECT product_id , count(*) AS total_reviews
FROM reviews
GROUP BY product_id
ORDER BY total_reviews DESC;

-- Q4:- AVG RATING 
SELECT AVG(rating) AS avg_rating
FROM reviews;

-- Q5:- HIGHEST RATING
SELECT MAX(rating) AS highest_rating
FROM reviews;

-- Q6:- LOWEST RATING
SELECT MIN(rating) AS lowest_rating
FROM reviews;

-- Q7:- NUMBER OF REVIEWS FRO EACH RATING
SELECT rating, count(*) AS total_reviews
FROM reviews
GROUP BY rating
ORDER BY rating;

-- Q8:-LATEST REVIEW DATE
SELECT MAX(review_date) AS latest_review_date
FROM reviews;

-- Q9:-EARLIEST REVIEW DATE
SELECT MIN(review_date) AS earliest_review_date
FROM reviews;


/*EVENTS Table Exploration :- */

-- View Table
describe events;
SELECT * FROM events;

-- Q1:- TOTAL NUMBER OF EVENTS
SELECT COUNT(*) AS total_events
FROM events;

-- Q2:-TOTAL COUNT FOR EACH EVENT
SELECT event_type, count(*) as total_events
FROM events
GROUP BY event_type
ORDER BY total_events DESC;

-- Q3:-LATEST EVENT DATE
SELECT MAX(event_timestamp) AS latest_event_date
FROM events;

-- Q4:-EARLIEST EVENT DATE
SELECT MIN(event_timestamp) AS earliest_event_date
FROM events;

-- Q5:-TOTAL EVENTS BY EACH USER
SELECT user_id, count(*) AS total_events
FROM events
GROUP BY user_id
ORDER BY total_events DESC;







