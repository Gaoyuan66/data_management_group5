-- ************************************************************************
-- The following SQL queries introduce the most important features of the 
-- SELECT query type. The queries closesly follow the examples given in 
-- chapter 3 of Murach's MySQL (3rd Edition). Chapter 3 is available as 
-- a free download from murach.com
--
-- Run each query individually to see results in the Results Grid, using
-- (a) "Execute the statement under the keyboard cursor" button 
-- (b) Pressing Ctrl-Enter (on Windows)
--
-- Prepared by David Tilson 14-September-2019
-- ************************************************************************

-- We can look at the contents of a table in a database by
-- specifying the database (schema) name and the table name
-- The * in the SELECT clause indicates that we want all columns
SELECT  * 
FROM    ap.invoices;

-- If we state that we want to use a particular database (schema) with USE
-- we do not have to specify it explictly in the queries that follow
USE AP; 

-- Note that comments start with double hyphens (--)
-- All SQL queries are terminated with semi-colons (;)

-- We can look at all the rows in the invoices table but this could be 
-- a bad idea if it was huge table

SELECT *
FROM   invoices;

-- Look at just 10 rows
SELECT *
FROM  invoices
LIMIT 10;

-- We can retreive just a few columns by specifying them in the SELECT statement and 
-- sort the results by adding an ORDER BY clause (sorts in ASCENDING order by default)
SELECT invoice_number, invoice_date, invoice_total
FROM  invoices
ORDER BY invoice_total;

-- We can sort DESCENDING by specifying the DESC option
-- in the ORDER BY clause
SELECT invoice_number, invoice_date, invoice_total
FROM  invoices
ORDER BY invoice_total DESC;

-- We can sort by multiple columns too
SELECT vendor_name, vendor_city, vendor_state, vendor_zip_code
FROM vendors
ORDER BY vendor_state, vendor_city, vendor_name;

-- Note you can order by a column in the base table even 
-- if it is not included in the SELECT clause

-- The queries above returned all the rows (unless we specified a LIMIT)
-- The WHERE clause is used to filter the rows according to specified criteria
SELECT invoice_number, invoice_date, invoice_total
FROM  invoices
WHERE invoice_id = 17;

-- We can also specify an expression to calculate a value based on columns in the table
-- Here the resulting column is renamed to an ALIAS specified after the AS keyword
SELECT invoice_id,  invoice_total, credit_total + payment_total AS total_credits
FROM  invoices
WHERE invoice_id = 17;

-- Several aliases can be specified. Note that an alias can include spaces  
-- by including the alias in single (') or double quotes (")
SELECT invoice_number AS 'Invoice Number',  invoice_date AS Date, invoice_total AS Total
FROM  invoices;


-- Without the alias the resulting column name is the expression
-- i.e. 'credit_total + payment_total' in this example
SELECT invoice_id,  invoice_total, credit_total + payment_total
FROM  invoices
WHERE invoice_id = 17;


-- The criteria used for filtering rows includes all rows between given dates
SELECT invoice_number, invoice_date, invoice_total
FROM  invoices
WHERE invoice_date BETWEEN '2018-06-01' AND '2018-06-30'
ORDER BY invoice_date;

-- The criteria in the WHERE clause can be quantitative comparisons of course
SELECT invoice_number, invoice_date, invoice_total
FROM  invoices
WHERE invoice_total > 5000
ORDER BY invoice_date;

-- If the criteria is not met by any row an empty set of rows will be returned
SELECT invoice_number, invoice_date, invoice_total
FROM  invoices
WHERE invoice_total > 50000;

-- The LIMIT clause can be used with ORDER BY to select the largest or smallest vaues
-- Here we find the 5 largest invoice totals
SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_total DESC
LIMIT 5;

-- We can include an offset value with LIMIT (the first parameter when two are used)
-- to explore elsewhere in the ordered query e.g. this list starts with 101st row
SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id ASC
LIMIT 100, 5;


-- We can also use a range of functions in the SELECT clause
-- CONCAT concatenates strings. Note the single quotes used to 
-- identify the literal string for the space ' '
SELECT first_name, last_name, concat(first_name, ' ', last_name) AS full_name
FROM vendor_contacts;

-- Double quotes also work " "
SELECT first_name, last_name, concat(first_name, " ", last_name) AS full_name
FROM vendor_contacts;

-- The arithmetic operators have a particilar precidence
-- *, /, DIV (integer division), % (Modulo or remainder), +, -
SELECT invoice_id,
invoice_id / 3 AS decimal_quotient,
invoice_id DIV 3 AS integer_quotient,
invoice_id % 3 AS remainder
FROM invoices
ORDER BY invoice_id;

-- The order of the calculations can be controlled with parentheses
SELECT invoice_id,
		invoice_id + 7 * 3 AS multiply_first,
        (invoice_id + 7) * 3 AS add_first
FROM invoices
ORDER BY invoice_id;

-- ************************************************************************
-- Introduction to some functions ... but there are many more
-- ************************************************************************

-- The LEFT function extracts a specified number of characters from the 
-- left of a string. Note that we can ORDER BY an alias
SELECT vendor_contact_first_name, vendor_contact_last_name, 
		CONCAT (LEFT (vendor_contact_first_name, 1), 
				LEFT (vendor_contact_last_name, 1)) AS initials
FROM vendors
ORDER BY initials;


-- A common data cleaning task is to convert from one data format to another. Here is an example using
-- the DATE_FORMAT function.  Check out MySQL documentation for a list of all the options
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format 
SELECT invoice_date,
		DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY', 
        DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM invoices
ORDER BY invoice_date; 

-- Answer can be rounded to the nearest integer or a specified number of decimal places
SELECT invoice_date, invoice_total, 
		ROUND(invoice_total) AS nearest_dollar,
        ROUND(invoice_total,1) as nearest_10_cents
FROM invoices
ORDER BY invoice_date;

-- Testing calculations, functions and expressions (without a FROM clause)
-- before crafting the version with data from table(s)
-- Note: the current_date function returns the current date ... parentheses are optional for this function

SELECT 1000 * (1 + 0.1) AS "test the math";

SELECT "David" AS first_name, "Tilson" AS last_name, 
CONCAT(LEFT("David", 1), LEFT("Tilson", 1)) AS Initials;

SELECT current_date(),
		DATE_FORMAT(current_date, '%m/%d/%y') AS 'MM/DD/YY', 
        DATE_FORMAT(current_date, '%e-%b-%Y') AS 'DD-Mon-YYYY';
        
SELECT 12345.6789 AS value, 
ROUND( 12345.6789) AS nearest_dollar,
ROUND( 12345.6789,1) AS nearest_10_cents;

-- We can list the cities where the vendors are located
-- but we see many duplicates in the results
SELECT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city;

-- Duplicate rows can be eliminated using the DISTINCT keyword
-- in the SELECT clause as shown
SELECT DISTINCT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city;

-- ************************************************************************
-- Going deeper on the WHERE clause
-- Comparison operators are used to compare two expressions. 
--    If the comparison is TRUE for a row it is included in the result set
--    If the comparison is FALSE or NULL it is not. 
-- The comparison operators =, <, >, <=, >= have the usual meanings
-- <> and != both respresent 'not equal'
-- ************************************************************************

-- Find the vendors from a particular state 
-- String literals are included in quotes
SELECT * FROM vendors
WHERE vendor_state ='IA';

-- String comparisons are not case sensitive in the MySQL dialect of SQL
SELECT * FROM vendors
WHERE vendor_state ="ia";

-- String comparison can be made case sensitive by casting one of the strings
-- into a binary string
SELECT * FROM vendors
WHERE vendor_state = BINARY("ia");

-- Finding invoices with a balance due
SELECT * FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

-- Finding invoices with a balance due using different expression
SELECT * FROM invoices
WHERE invoice_total > payment_total + credit_total;

-- Finding vendor names from A to L
SELECT  * FROM vendors
WHERE vendor_name <'M'
ORDER BY vendor_name DESC; 

-- Finding invoices on or before a specified date
SELECT * FROM invoices
WHERE invoice_date <= '2018-07-31'
ORDER BY invoice_date DESC;

-- Finding invoices with non-zero credits
-- WHERE credit_total != 0 would also work
SELECT * FROM invoices
WHERE credit_total <> 0
ORDER BY invoice_date DESC;

-- Be careful with comparing expressions with different data types
-- You might have to use CAST or CONVERT functions to get the desired result

-- Multiple expressions can be combined using the AND, OR, and NOT logical operators
-- Order of precednce is NOT, AND, OR
-- Parentheses can be used to clarify the required order of evaluation

SELECT * FROM vendors
WHERE vendor_state = 'NJ' AND vendor_city = 'Springfield';

SELECT * FROM vendors
WHERE vendor_state = 'NJ' OR vendor_city = 'Springfield';

SELECT * FROM vendors
WHERE vendor_state != "CA";

SELECT * FROM invoices
WHERE NOT invoice_total >= 5000;

-- An IN phrase can be used in the WHERE clause to compare the test value to 
-- one of the expressions in a list
-- Here we see if an invoice has certain terms (a list of numeric literals)
SELECT * FROM invoices
WHERE terms_id IN (2,4);

-- This examples uses a list of string literals
SELECT * FROM vendors
WHERE vendor_state NOT IN ('CA','NV','OR');

-- Find the vendors who had an invoice on a paricular date
-- Note that it uses a subquery to generate the list of vendor_ids with
-- orders on that date. You will learn more about subqueries later
SELECT vendor_name FROM vendors
WHERE vendor_id IN
	(SELECT vendor_id
    FROM invoices
    WHERE invoice_date = '2018-04-24');

-- Your can run the subquery on its own to see the list of vendor_ids
-- included in the IN phrase list 
SELECT vendor_id
FROM invoices
WHERE invoice_date = '2018-04-24';

-- The BETWEEN phrase can test if an expression falls within a range of values
-- If it is, the corresponding row is included in the output set
-- Note: The results are inclusive of the lower and upper limits and the 
-- lower limit must be stated first

-- BETWEEN can be used for dates. The range is inclusive of the
-- first and last dates of the month
SELECT * FROM invoices
WHERE invoice_date BETWEEN '2018-06-01' AND '2018-06-30';

-- NOT can be used with BETWEEN
SELECT * FROM vendors
WHERE vendor_zip_code NOT BETWEEN 93600 and 93799;

-- The test expression can be a calulated value
SELECT * FROM invoices 
WHERE invoice_total - payment_total - credit_total BETWEEN 200 AND 500;

-- The upper and lower limits can also be calculated values
SELECT * FROM invoices 
WHERE payment_total  BETWEEN credit_total AND credit_total + 500;

-- A null in a database table indicates that the value is not known. This
-- is not the same a zero or an empty string.

-- This table has a NULL in one of its columns
SELECT * FROM ex.null_sample;

-- We can serarch for zero values... the NULL will not be included in the results
SELECT * FROM ex.null_sample
WHERE invoice_total = 0;

-- We can serarch for non-zero values... the NULL will not be included in the results
SELECT * FROM ex.null_sample
WHERE invoice_total != 0;

-- We can explictly select for NULL values
SELECT * FROM ex.null_sample
WHERE invoice_total IS NULL;

-- Or we can explicitly exclude NULL VALUES 
SELECT * FROM ex.null_sample
WHERE invoice_total IS NOT NULL;








