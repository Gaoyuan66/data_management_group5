-- ************************************************************************
-- The following SQL queries introduce the most important features of 
-- aggregation in SQL. The queries closesly follow the examples given in 
-- chapter 6 of Murach's MySQL (3rd Edition). 
--
-- Run each query individually to see results in the Results Grid, using
-- (a) "Execute the statement under the keyboard cursor" button 
-- (b) Pressing Ctrl-Enter (on Windows)
--
-- Prepared by David Tilson 26-September-2019 
-- ************************************************************************


-- The syntax of the aggregate functions
-- AVG([ALL|DISTINCT] expression)
-- SUM([ALL|DISTINCT] expression)
-- MIN([ALL|DISTINCT] expression)
-- MAX([ALL|DISTINCT] expression)
-- COUNT([ALL|DISTINCT] expression)
-- COUNT(*)

USE ap;
-- Inspect the invoices table. 
-- How many rows does it have? 
-- Do any fields have NULLs? 
SELECT * from invoices;

-- The aggregatio functions (aka column functions) operate on values in selected rows
-- Here we are counting the number of invoices
-- 		COUNT(*) counts the number of rows selected (all of them in this case)
-- 		COUNT(payment_date) only counts the number of non-NULL values in that column 
SELECT COUNT(*) AS number_of_invoices, COUNT(payment_date) AS number_of_rows_with_payment_date
FROM invoices;

-- This query lists invoices with an outstanding balance
-- Note the number of rows returned (11)
SELECT * FROM invoices 
WHERE invoice_total - payment_total - credit_total > 0;


-- Aggregation functions operate on these rows that satisfy the condition
-- in the WHERE clause 
SELECT 			COUNT(*) AS number_of_invoices, 
				SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices 
WHERE invoice_total - payment_total - credit_total > 0;


-- A summary query with COUNT(*), AVG, and SUM
SELECT 	'After 1 May 2018' AS selection_date, 
		COUNT(*) AS number_of_invoices,
		ROUND(AVG(invoice_total), 2) AS avg_invoice_amt,
		SUM(invoice_total) AS total_invoice_amt
FROM invoices
WHERE invoice_date > '2018-05-01'; 


-- A summary query with MIN and MAX
SELECT 'After 1 May 2018' AS selection_date, 
    COUNT(*) AS number_of_invoices,
    MAX(invoice_total) AS highest_invoice_total,
    MIN(invoice_total) AS lowest_invoice_total
FROM invoices
WHERE invoice_date > '2018-05-01';

-- A summary query for non-numeric columns
SELECT MIN(vendor_name) AS first_vendor,
    MAX(vendor_name) AS last_vendor,
    COUNT(vendor_name) AS number_of_vendors
FROM vendors;


-- A summary query with the DISTINCT keyword
SELECT COUNT(DISTINCT vendor_id) AS number_of_vendors,
    COUNT(vendor_id) AS number_of_invoices,
    ROUND(AVG(invoice_total), 2) AS avg_invoice_amt,
    SUM(invoice_total) AS total_invoice_amt
FROM invoices
WHERE invoice_date > '2018-01-01';

-- The syntax of a SELECT statement 
-- with GROUP BY and HAVING clauses
-- SELECT select_list
-- FROM table_source
-- [WHERE search_condition]
-- [GROUP BY group_by_list]
-- [HAVING search_condition]
-- [ORDER BY order_by_list]

-- A summary query that calculates the average invoice amount by vendor
SELECT vendor_id, ROUND(AVG(invoice_total), 2) 
    AS average_invoice_amount
FROM invoices
GROUP BY vendor_id
ORDER BY average_invoice_amount DESC;

-- Same summary but only returning results for average 
-- invoice amounts larger than 2000
SELECT vendor_id, ROUND(AVG(invoice_total), 2) 
    AS average_invoice_amount
FROM invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC;

-- Same summary but using column alias in HAVING clause
-- Note the rounding function might make it a little different
-- with edge cases 
SELECT vendor_id, ROUND(AVG(invoice_total), 2) 
    AS average_invoice_amount
FROM invoices
GROUP BY vendor_id
HAVING average_invoice_amount > 2000
ORDER BY average_invoice_amount DESC;


-- A summary query that includes a functionally dependent column
-- There are unique values of vendor_name for each value of vendor_id
SELECT vendor_name, vendor_state,
  ROUND(AVG(invoice_total), 2) AS average_invoice_amount
FROM vendors JOIN invoices
  ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC;

-- A summary query that counts the number of invoices by vendor
SELECT vendor_id, COUNT(*) AS invoice_qty
FROM invoices
GROUP BY vendor_id;

-- A query that finds summaries for vendors by state and city
SELECT vendor_state, vendor_city, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state, vendor_city
ORDER BY vendor_state, vendor_city;

-- A summary query that limits the groups to those with two or more invoices
SELECT vendor_state, vendor_city, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state, vendor_city
HAVING COUNT(*) >= 2
ORDER BY vendor_state, vendor_city;


-- A summary query with a search condition in the HAVING clause
-- Note the use of a column alias in the HAVING clause
SELECT vendor_name, 
    COUNT(*) AS invoice_qty,
    AVG(invoice_total) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING invoice_avg > 500
ORDER BY invoice_qty DESC;

-- A summary query with a search condition in 
-- the HAVING clause
SELECT vendor_name, 
    COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500
ORDER BY invoice_qty DESC;

-- A summary query with a search condition in 
-- the WHERE clause
SELECT vendor_name, 
    COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_total > 500
GROUP BY vendor_name
ORDER BY invoice_qty DESC;


-- A summary query with a compound condition in the HAVING clause
-- However, nnte that MySQL documentation recoomends not including
-- elements that should be in a WHERE clause (e.g. the invoice_date
-- between certain values in the example below
SELECT 
    invoice_date,
    COUNT(*) AS invoice_qty,
    SUM(invoice_total) AS invoice_sum
FROM invoices
GROUP BY invoice_date
HAVING invoice_date BETWEEN '2018-05-01' AND '2018-05-31'
    AND COUNT(*) > 1
    AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;

-- The same query coded with a WHERE clause
-- gets same results
SELECT 
    invoice_date,
    COUNT(*) AS invoice_qty,
    SUM(invoice_total) AS invoice_sum
FROM invoices
WHERE invoice_date BETWEEN '2018-05-01' AND '2018-05-31'
GROUP BY invoice_date
HAVING COUNT(*) > 1 
    AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;


-- A summary query with a final summary row
SELECT vendor_id, COUNT(*) AS invoice_count,
    SUM(invoice_total) AS invoice_total
FROM invoices
GROUP BY vendor_id WITH ROLLUP;


-- A summary query with a summary row  for each grouping level
SELECT vendor_state, vendor_city, COUNT(*) AS qty_vendors
FROM vendors
WHERE vendor_state IN ('IA', 'NJ')
GROUP BY vendor_state, vendor_city WITH ROLLUP;

-- The basic syntax of the GROUPING function GROUPING(expression)
-- A summary query that uses WITH ROLLUP on a table with null values
SELECT invoice_date, payment_date,
       SUM(invoice_total) AS invoice_total,
       SUM(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP;

-- A query that substitutes literals for nulls in summary rows
SELECT IF(GROUPING(invoice_date) = 1, 'Grand totals',
          invoice_date) AS invoice_date,
       IF(GROUPING(payment_date) = 1, 'Invoice date totals',
          payment_date) AS payment_date,
       SUM(invoice_total) AS invoice_total,
       SUM(invoice_total - credit_total - payment_total)
           AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP;

-- A query that displays only summary rows
SELECT IF(GROUPING(invoice_date) = 1, 'Grand totals', invoice_date)
           AS invoice_date,
       IF(GROUPING(payment_date) = 1, 'Invoice date totals',
          payment_date) AS payment_date,
       SUM(invoice_total) AS invoice_total,
       SUM(invoice_total - credit_total - payment_total)
           AS balance_due
FROM invoices
WHERE invoice_date BETWEEN '2018-07-24' AND '2018-07-31'
GROUP BY invoice_date, payment_date WITH ROLLUP
HAVING GROUPING(invoice_date) = 1 OR GROUPING(payment_date) = 1;
