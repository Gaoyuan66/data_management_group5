-- Viewing the data FROM products and categories
SELECT * FROM products;
SELECT * FROM categories;

-- Viewing the column definitions for the Categories and Products tables.-- 
DESC products;
DESC categories;

-- Viewing list of product names
SELECT product_name FROM products;

/*
SELECT product_nam FROM products;
Error Code: 1054. 
Unknown column 'product_nam' in 'field list'	
*/

SELECT count(*) AS number_of_products
FROM products;
/* 
---------------PART 2--------------------
1. 
Write a SELECT statement that returns four columns FROM the Products table: product_code, product_name, list_price, and discount_percent. 
Then, run this statement to make sure it works correctly.
Add an ORDER BY clause to this statement that sorts the result set by list price in DESCending sequence. 
Then, run this statement again to make sure it works correctly. 
This is a good way to build and test a statement, one clause at a time.
*/

SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price DESC;


/*
2. 
Write a SELECT statement that returns one column FROM the Customers table named full_name that joins the lASt_name and first_name columns.
Format this column with the lASt name, a comma, a space, and the first name like this:
Doe, John
Sort the result set by the lASt_name column in ASCending sequence.
Return only the customers whose lASt name begins with letters FROM M to Z.
NOTE: When comparing strings of characters, ‘M’ comes before any string of characters that begins with ‘M’. 
For example, ‘M’ comes before ‘Mulligan’.
*/

SELECT CONCAT ( lASt_name, ", " , first_name ) AS full_name 
FROM customers
ORDER BY lASt_name ASC;

/* NEED TO CHECK: (For the code above) When comparing strings of characters, ‘M’ comes before any string of characters that begins with ‘M’. 
For example, ‘M’ comes before ‘Mulligan’." 
*/

/*
3. 
Write a SELECT statement that returns these columns FROM the Products table:
product_name The product_name column
list_price The list_price column
date_added The date_added column
Return only the rows with a list price that’s greater than 500 and less than 2000.
Sort the result set by the date_added column in descending sequence.
*/
SELECT product_name,
list_price,
date_added 
FROM products
WHERE list_price BETWEEN 500 AND 2000
ORDER BY date_added DESC;

/*
4.
Write a SELECT statement that returns these column names and data FROM the Products table:
product_name The product_name column
list_price The list_price column
discount_percent The discount_percent column
discount_amount A column that’s calculated FROM the previous two columns
discount_price A column that’s calculated FROM the previous three columns
Round the discount_amount and discount_price columns to 2 decimal places.
Sort the result set by the discount_price column in DESCending sequence.
Use the LIMIT clause so the result set contains only the first 5 rows.
*/

SELECT list_price,
discount_percent,
round(((list_price*discount_percent)/100),2) AS discount_amount,
round(list_price*(1-discount_percent),2) AS discount_price 
FROM products
ORDER BY discount_price DESC
LIMIT 5;

-- another attempt

SELECT list_price,
discount_percent,
discount_amount,
round((list_price-discount_amount),2) AS discount_price  
FROM products
WHERE discount_amount IN ( SELECT round(((list_price*discount_percent)/100),2) AS discount_amount FROM products    )
ORDER BY discount_amount DESC
LIMIT 5;




/* 
5.
Write a SELECT statement that returns these column names and data FROM the Order_Items table:
item_id The item_id column
item_price The item_price column
discount_amount The discount_amount column
quantity The quantity column
price_total A column that’s calculated by multiplying the item price by the quantity
discount_total A column that’s calculated by multiplying the discount amount by the quantity
item_total A column that’s calculated by subtracting the discount amount FROM the item price and then multiplying by the quantity
Only return rows WHERE the item_total is greater than 500.
Sort the result set by the item_total column in DESCending sequence.
*/

SELECT
item_id, 
item_price,
discount_amount,
quantity,
(item_price*quantity) AS price_total,
(discount_amount*quantity) AS discount_total,
(item_price-discount_amount)*quantity AS item_total
FROM order_items
WHERE (item_price-discount_amount)*quantity > 500
ORDER BY item_total DESC;


/*												Work with nulls and test expressions

6. Write a SELECT statement that returns these columns FROM the Orders table:
order_id The order_id column
order_date The order_date column
ship_date The ship_date column
Return only the rows WHERE the ship_date column contains a null value.
*/ 

SELECT
order_id,
order_date,
ship_date 
FROM orders
WHERE ship_date is null;

/*
7.
Write a SELECT statement without a FROM clause that uses the NOW function to create a row with these columns:
today_unformatted The NOW function unformatted
today_formatted The NOW function in this format: DD-Mon-YYYY
This displays a number for the day, an abbreviation for the month, and a four-digit year.
*/

SELECT now() AS today_unformatted , 
DATE_FORMAT(now(), '%e-%b-%Y') AS 'DD-Mon-YYYY';


/*
8.
Write a SELECT statement without a FROM clause that creates a row with these columns:
price 100 (dollars)
tax_rate .07 (7 percent)
tax_amount The price multiplied by the tax
total The price plus the tax
To calculate the fourth column, add the expressions you used for the first and third columns.
*/

SELECT 100 AS price, .07 AS tax_rate,  
100 * .07 AS tax_amount, 
(SELECT price) + (SELECT tax_amount) AS total;
