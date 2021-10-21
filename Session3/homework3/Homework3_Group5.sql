USE my_guitar_shop;

-- 1
-- Write a SELECT statement that JOINs the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.
-- Return ONe row for each address for the customer with an email address of allan.sherwood@yahoo.com.

SELECT 
first_name
, last_name
, line1
, city
, state
, zip_code
FROM customers cu 
JOIN addresses addr 
ON cu.customer_id = addr.customer_id
WHERE cu.email_address = "allan.sherwood@yahoo.com"
;

-- 2
-- Write a SELECT statement that JOINs the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code. 
-- Return ONe row for each customer, but ONly return addresses that are the shipping address for a customer.

SELECT 
first_name
, last_name
, line1
, city
, state
, zip_code
FROM customers cu 
JOIN addresses addr
ON cu.customer_id = addr.customer_id
WHERE cu.shipping_address_id = addr.address_id
;

-- 3
-- Write a SELECT statement that JOINs the Customers, Orders, Order_Items, and Products tables.
-- This statement should return these columns: last_name, first_name, order_date, product_name, item_price, discount_amount, and quantity.
-- Use aliases for the tables.
-- Sort the final result set by the last_name, order_date, and product_name columns.

SELECT 
  last_name
, first_name
, order_date
, product_name
, item_price
, discount_amount
, quantity
FROM customers cu 
JOIN orders o
ON cu.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
ORDER BY last_name, order_date, product_name
;

-- 4
-- Write a SELECT statement that returns the product_name and list_price columns FROM the Products table.
-- Return ONe row for each product that has the same list price as another product.
-- * Use a self-JOIN to check that the product_id columns aren’t equal but the list_price columns are equal.

SELECT 
  p1.product_name
, p1.list_price
FROM products p1 
JOIN products p2
ON p1.product_id <> p2.product_id 
AND p1.list_price = p2.list_price
ORDER BY product_name;

-- 5
-- Write a SELECT statement that returns these two columns:The category_name column FROM the Categories table, The product_id column FROM the Products table
-- Return ONe row for each category that has never been used. 
-- * Use an outer JOIN and ONly return rows WHERE the product_id column cONtains a null value.

SELECT 
  ca.category_name
, p.product_id
FROM categories ca 
LEFT JOIN products p
ON ca.category_id = p.category_id
WHERE product_id IS NULL;

-- 6
-- Write a SELECT statement that returns ONe row for each customer that has orders with these columns:
-- The email_address column FROM the Customers table 
-- The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table 
-- The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table 
-- Sort the result set in descending sequence by the item price total for each customer.

SELECT 
  email_address
, SUM(item_price * quantity) AS item_price_sum
, SUM(discount_amount * quantity) AS discount_sum
FROM customers cu 
JOIN orders o
ON cu.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cu.email_address
ORDER BY item_price_sum DESC;

-- 7
-- Write a SELECT statement that returns ONe row for each customer that has orders with these columns:
-- The email_address column FROM the Customers table 
-- A count of the number of orders 
-- The total amount for each order 
-- * First, subtract the discount amount FROM the price. Then, multiply by the quantity
-- Return ONly those rows WHERE the customer has more than 1 order.
-- Sort the result set in descending sequence by the sum of the line item amounts.

SELECT 
  email_address
, COUNT(DISTINCT o.order_id) AS order_num
, SUM(item_price * quantity - discount_amount*quantity) AS total_amount
FROM customers cu 
JOIN orders o
ON cu.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cu.email_address
HAVING order_num > 1
ORDER BY total_amount DESC;

-- 8
-- Write a SELECT statement that answers this questiON: What is the total amount ordered for each product? Return these columns:
-- The product_name column FROM the Products table
-- The total amount for each product in the Order_Items table
-- * You can calculate the total amount by subtracting the discount amount FROM the item price and then multiplying it by the quantity
-- Use the WITH ROLLUP operator to include a row that gives the grand total.

SELECT IF(GROUPING(product_name)=1, 'All products', product_name) AS product_name
, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS total_amount
FROM products p 
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
WITH ROLLUP
; 

-- 9
-- Write a SELECT statement that answers this questiON: Which customers have ordered more than ONe product? Return these columns:
-- The email_address column FROM the Customers table
-- The count of distinct products FROM the customer’s orders
-- Sort the result set in ascending sequence by the email_address column.

SELECT 
  email_address
, COUNT(DISTINCT product_id) AS num_product
FROM customers cu
LEFT JOIN orders o
ON cu.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cu.email_address
HAVING num_product > 1
ORDER BY email_address
;

-- 10
-- Write a SELECT statement that answers this questiON: 
-- What is the total quantity purchased for each product within each category? Return these columns:
-- The category_name column FROM the category table
-- The product_name column FROM the products table
-- The total quantity purchased for each product with orders in the Order_Items table
-- Use the WITH ROLLUP operator to include rows that give a summary for each category name as well as a row that gives the grand total. Use the IF and GROUPING functiONs to replace null values in the category_name and product_name columns with literal values if they’re for summary rows.

SELECT 
  IF(GROUPING(category_name)=1, 'category total', category_name) AS category_name
, IF(GROUPING(product_name)=1, 'product total',product_name) AS product_name
, SUM(oi.quantity) AS total_quantity
FROM categories ca 
LEFT JOIN products p
ON ca.category_id = p.category_id
JOIN order_items oi 
ON p.product_id = oi.product_id
GROUP BY category_name, product_name
WITH ROLLUP;

-- 11
-- Write a SELECT statement that answers this questiON: 
-- Which products have a list price that’s greater than the average list price for all products?
-- Return the product_name and list_price columns for each product.
-- Sort the result set by the list_price column in descending sequence.

SELECT 
  product_name
, list_price
FROM products
WHERE list_price > (
	SELECT AVG(list_price) 
    FROM products)
ORDER BY list_price DESC
;

-- 12
-- Write a SELECT statement that returns the category_name column FROM the Categories table.
-- Return ONe row for each category that has never been assigned to any product in the Products table. 
-- To do that, use a subquery introduced with the NOT EXISTS operator.

SELECT category_name 
FROM categories 
WHERE NOT EXISTS (
SELECT product_name 
FROM products
WHERE category_id = categories.category_id
)
;

-- 13.1
-- Write a SELECT statement that returns three columns: 
-- email_address, order_id, and the order total for each customer. 
-- To do this, you can group the result set by the email_address and order_id columns. 
-- In additiON, you must calculate the order total FROM the columns in the Order_Items table.

SELECT 
cu.email_address
, o.order_id
, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
FROM customers cu 
LEFT JOIN orders o
ON cu.customer_id = o.customer_id
LEFT JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cu.email_address, o.order_id
;

-- 13.2
-- Write a secONd SELECT statement that uses the first SELECT statement in its FROM clause. 
-- The main query should return two columns: the customer’s email address and the largest order for that customer. 
-- To do this, you can group the result set by the email_address. 
-- Sort the result set by the largest order in descending sequence.
SELECT 
  email_address
, MAX(order_total) AS max_order
FROM
(	
SELECT 
  cu.email_address
, o.order_id
, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
FROM customers cu 
LEFT JOIN orders o
ON cu.customer_id = o.customer_id
LEFT JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cu.email_address, o.order_id
) t
GROUP BY email_address
ORDER BY max_order DESC;

-- 14
-- Use a correlated subquery to return ONe row per customer, representing the customer’s oldest order (the ONe with the earliest date). 
-- Each row should include these three columns: email_address, order_id, and order_date.
-- Sort the result set by the order_date and order_id columns.

SELECT 
email_address
, order_id
, order_date AS oldest_order
FROM customers cu 
JOIN orders o
ON cu.customer_id = o.customer_id
WHERE order_date = (
	SELECT MIN(order_date)
	FROM orders 
	WHERE order_id = o.order_id
)
ORDER BY order_date, order_id;

-- 15
-- Create a view named customer_addresses that shows the shipping and billing addresses for each customer.
-- This view should return these columns FROM the Customers table: customer_id, email_address, last_name and first_name.
-- This view should return these columns FROM the Addresses table: bill_line1, bill_line2, bill_city, bill_state, bill_zip, ship_line1, ship_line2, ship_city, ship_state, and ship_zip.

CREATE OR REPLACE VIEW customer_addresses_bill AS
SELECT 
  cu.customer_id
, cu.email_address
, cu.last_name
, cu.first_name, 
addr.line1 AS bill_line1
, addr.line2 AS bill_line2
, addr.city AS bill_city
, addr.state AS bill_state
, addr.zip_code AS bill_zip
FROM customers cu 
JOIN addresses addr 
ON cu.billing_address_id = addr.address_id;

CREATE OR REPLACE VIEW customer_addresses_ship AS
SELECT cu.customer_id, cu.email_address, cu.last_name, cu.first_name, 
addr.line1 AS ship_line1, addr.line2 AS ship_line2, addr.city AS ship_city, addr.state AS ship_state, addr.zip_code AS ship_zip
FROM customers cu 
JOIN addresses addr 
ON cu.shipping_address_id = addr.address_id;

CREATE OR REPLACE VIEW customer_address AS
SELECT 
  cab.customer_id
, cab.email_address
, cab.last_name
, cab.first_name
, bill_line1, bill_line2, bill_city, bill_state
, bill_zip, ship_line1, ship_line2
, ship_city, ship_state, ship_zip
FROM customer_addresses_bill cab 
JOIN customer_addresses_ship cas
ON cab.customer_id = cas.customer_id;

SELECT customer_id, last_name, first_name, bill_line1 
FROM customer_address
ORDER BY last_name, first_name;


