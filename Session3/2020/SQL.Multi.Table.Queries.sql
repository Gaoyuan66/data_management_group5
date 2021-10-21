-- ************************************************************************
-- The following SQL queries introduce the most important features of 
-- working with multiple tables in SQL. The queries closesly follow the 
-- examples given in chapter 4 of Murach's MySQL (3rd Edition). 
--
-- Run each query individually to see results in the Results Grid, using
-- (a) "Execute the statement under the keyboard cursor" button 
-- (b) Pressing Ctrl-Enter (on Windows)
--
-- Prepared by David Tilson 26-September-2019 
-- ************************************************************************

-- Select the ap database 
USE ap;

-- It is workwhile making sure you know the structure of the database
-- and table you will be working with. You can use SQL queries to explore
-- or work with the EER diagram (Enhanced ERD) available in MySQL 
-- Workbench (select "Reverse Engineer" from "Database Menu"). 

select * from vendors;
DESCRIBE vendors;

-- The explicit syntax for an inner join
-- SELECT select_list
-- FROM table_1
--     [INNER] JOIN table_2
--         ON join_condition_1
--    [[INNER] JOIN table_3
--         ON join_condition_2]...


-- An inner join of the Vendors and Invoices tables
SELECT invoice_number, vendor_name
FROM vendors INNER JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
ORDER BY invoice_number;


-- Same query with vendor_id added to the select list
-- to illustrate the need to qualify tables for
-- ambiguous fields. Same as in FROM clause. 
SELECT vendors.vendor_id, invoice_number, vendor_name
FROM vendors INNER JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
ORDER BY invoice_number;



-- An inner join with aliases for all tables
SELECT invoice_number, vendor_name, invoice_due_date,
    invoice_total - payment_total - credit_total
    AS balance_due
FROM vendors v JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE invoice_total - payment_total - credit_total > 0
ORDER BY invoice_due_date DESC;


-- An inner join with an alias for only one table
SELECT invoice_number, line_item_amount,
    line_item_description
FROM invoices JOIN invoice_line_items line_items
    ON invoices.invoice_id = line_items.invoice_id
WHERE account_number = 540
ORDER BY invoice_date;

-- The syntax of a table name that’s qualified with a database name using
-- database_name.table_name 
-- A join to a table in another database
-- Also shows that queries based on ad-hoc relationships are possbile
-- (i.e. one not using PKs and FKs)
SELECT vendor_name, customer_last_name,
    customer_first_name, vendor_state AS state,
    vendor_city AS city
FROM vendors v
    JOIN om.customers c
    ON v.vendor_zip_code = c.customer_zip
ORDER BY state, city;

-- Examine customer table
SELECT customer_id, customer_last_name, customer_first_name
FROM ex.customers
ORDER BY customer_id;

-- Examine employee table
SELECT * from ex.employees;

-- An inner join with two conditions
SELECT customer_first_name, customer_last_name
FROM ex.customers c JOIN ex.employees e 
    ON c.customer_first_name = e.first_name 
   AND c.customer_last_name = e.last_name;

-- A self-join that returns vendors from cities in common with other vendors
SELECT DISTINCT v1.vendor_name AS vendor, v1.vendor_city, v1.vendor_state
FROM vendors v1 JOIN vendors v2
    ON v1.vendor_city = v2.vendor_city AND
       v1.vendor_state = v2.vendor_state AND
       v1.vendor_name <> v2.vendor_name
ORDER BY v1.vendor_state, v1.vendor_city, v1.vendor_name;

-- Try the above query without the DISTINCT keyword what was it doing
-- Try it again without the third condition 
-- Can you see what each part in the query is doing?
-- It might also help to add v2.vendor_name as vendor2 to get more insight


-- A statement that joins four tables
SELECT vendor_name, invoice_number, invoice_date,
    line_item_amount, account_description
FROM vendors v
    JOIN invoices i 
        ON v.vendor_id = i.vendor_id
    JOIN invoice_line_items li 
        ON i.invoice_id = li.invoice_id
    JOIN general_ledger_accounts gl 
        ON li.account_number = gl.account_number
WHERE invoice_total - payment_total - credit_total > 0
ORDER BY vendor_name, line_item_amount DESC;


-- The implicit syntax for an inner join
-- SELECT select_list
-- FROM table_1, table_2 [, table_3]...
-- WHERE table_1.column_name operator table_2.column_name
--  [AND table_2.column_name operator table_3.column_name]...

-- Join the Vendors and Invoices tables
SELECT invoice_number, vendor_name
FROM vendors v, invoices i
WHERE v.vendor_id = i.vendor_id
ORDER BY invoice_number;

-- Join four tables
SELECT vendor_name, invoice_number, invoice_date,
    line_item_amount, account_description
FROM  vendors v, invoices i, invoice_line_items li, 
    general_ledger_accounts gl
WHERE v.vendor_id = i.vendor_id
  AND i.invoice_id = li.invoice_id
  AND li.account_number = gl.account_number
  AND invoice_total - payment_total - credit_total > 0
ORDER BY vendor_name, line_item_amount DESC;
 
-- Terms to know about inner joins
-- •	Join
-- •	Inner join
-- •	Ad hoc relationship
-- •	Qualified column name
-- •	Table alias
-- •	Schema
-- •	Self-join
-- •	Explicit syntax (SQL-92)
-- •	Implicit syntax


-- The explicit syntax for an outer join
-- SELECT select_list
-- FROM table_1
--     {LEFT|RIGHT} [OUTER] JOIN table_2
--         ON join_condition_1
--    [{LEFT|RIGHT} [OUTER] JOIN table_3
--        ON join_condition_2]...


-- CREATE TEMPORARTY DATABASE TO COMPARE INNER AND OUTER JOINS
-- CROSS JOINS and UNION
-- There examples are not from Murach's MySQL (3rd Edition)
CREATE DATABASE IF NOT EXISTS temp_examples;
USE temp_examples;
CREATE TABLE IF NOT EXISTS temp_examples.customers
(
	cust_id		VARCHAR(10),
    name		VARCHAR(15),
    country		CHAR(2)
);

CREATE TABLE IF NOT EXISTS orders
(
	order_id	INT,
    cust_id		VARCHAR(10),
    total		INT
);

INSERT INTO temp_examples.customers 
VALUES
('a', 'Alice', 'us'),
('b', 'Bob', 'ca'),
('c', 'Carlos', 'mx'),
('d', 'Dieter', 'de');

INSERT INTO temp_examples.orders 
VALUES
(1, 'a', 1539),
(2, 'c', 1871),
(3, 'a', 6352),
(4, 'b', 1456),
(5, 'z', 2137);

-- Inner Join Example
SELECT c.cust_id, name, total 
FROM customers c
	JOIN orders o
    ON (c.cust_id = o.cust_id);

-- LEFT Join Example
-- OUTER keyword is optional
SELECT c.cust_id, name, total 
FROM customers c
	LEFT OUTER JOIN orders o
    ON (c.cust_id = o.cust_id);

-- RIGHT Join Example
-- OUTER keyword is optional
SELECT c.cust_id, name, total 
FROM customers c
	RIGHT JOIN orders o
    ON (c.cust_id = o.cust_id);

-- Note there is no FULL OUTER JOIN in MySQL
-- However, we can simulate it using UNION 
	SELECT c.cust_id, name, total 
	FROM customers c
		LEFT OUTER JOIN orders o
		ON (c.cust_id = o.cust_id)
UNION
	SELECT c.cust_id, name, total 
	FROM customers c
		RIGHT JOIN orders o
		ON (c.cust_id = o.cust_id);

-- Cross joins of these two small tables show the principle
-- Produces result set that includes each row from the first
-- table joined with each row of the second table
-- For large dataset this can return millions of rows
SELECT c.cust_id, name, total, order_id, total  
FROM customers c CROSS JOIN orders o
ORDER BY c.cust_id;

-- Implicit cross join created when multi-table 
-- SELECT query does not have a WHERE clause
SELECT c.cust_id, name, total, order_id, total  
FROM customers c,  orders o
ORDER BY c.cust_id;

DROP DATABASE IF EXISTS temp_examples;

-- Restart using ap database again
USE ap;

-- Outer Joins retrieve unmatched rows from
-- Left outer join	The first (left) table
-- Right outer join	The second (right) table

-- Here are some additional LEFT and RIGHT OUTER joins using the ap database
-- not covered in class

-- A left outer join of the Vendors and Invoices tables
SELECT vendor_name, invoice_number, invoice_total
FROM vendors LEFT JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendor_name;

-- A left outer join
SELECT department_name, d.department_number, last_name
FROM ex. departments d 
    LEFT JOIN ex.employees e
    ON d.department_number = e.department_number
ORDER BY department_name;

-- A right outer join
SELECT department_name, e.department_number, last_name
FROM ex.departments d 
    RIGHT JOIN ex.employees e
    ON d.department_number = e.department_number
ORDER BY department_name;

-- Join three tables using left outer joins
SELECT department_name, last_name, project_number
FROM ex.departments d
    LEFT JOIN ex.employees e
        ON d.department_number = e.department_number
    LEFT JOIN ex.projects p
        ON e.employee_id = p.employee_id
ORDER BY department_name, last_name;

-- Combine an outer and an inner join
SELECT department_name, last_name, project_number
FROM ex.departments d
    JOIN ex.employees e
        ON d.department_number = e.department_number
    LEFT JOIN ex.projects p
        ON e.employee_id = p.employee_id
ORDER BY department_name, last_name;


-- The syntax for a join that uses the USING keyword
-- SELECT select_list
-- FROM table_1
--     [{LEFT|RIGHT} [OUTER]] JOIN table_2 
--         USING (join_column_1[, join_column_2]...)
--    [[{LEFT|RIGHT} [OUTER]] JOIN table_3 
--        USING (join_column_1[, join_column_2]...)]...


-- Use the USING keyword to join two tables
SELECT invoice_number, vendor_name
FROM vendors 
    JOIN invoices USING (vendor_id)
ORDER BY invoice_number;

-- Use the USING keyword to join three tables
SELECT department_name, last_name, project_number
FROM ex.departments
    JOIN ex.employees USING (department_number)
    LEFT JOIN ex.projects USING (employee_id)
ORDER BY department_name;


-- The syntax for a join that uses the NATURAL keyword
-- SELECT select_list
-- FROM table_1 
--      NATURAL JOIN table_2 
--     [NATURAL JOIN table_3]...

-- Use the NATURAL keyword to join tables
SELECT invoice_number, vendor_name
FROM vendors 
    NATURAL JOIN invoices
ORDER BY invoice_number;

-- Use the NATURAL keyword in a statement that joins three tables
SELECT department_name AS dept_name, last_name, project_number
FROM ex.departments
    NATURAL JOIN ex.employees
    LEFT JOIN ex.projects USING (employee_id)
ORDER BY department_name;


-- The explicit syntax for a cross join
-- SELECT select_list
-- FROM table_1 CROSS JOIN table_2;

-- A cross join that uses the explicit syntax
SELECT departments.department_number, department_name, employee_id, last_name
FROM ex.departments CROSS JOIN ex.employees
ORDER BY departments.department_number;

-- The implicit syntax for a cross join
-- SELECT select_list
-- FROM table_1, table_2

-- A cross join that uses the implicit syntax
SELECT departments.department_number, department_name,
    employee_id, last_name
FROM ex.departments, ex.employees
ORDER BY departments.department_number;
 
-- Terms to know about other types of joins
-- •	Outer join
-- •	Left outer join
-- •	Right outer join
-- •	Equijoin
-- •	Natural join
-- •	Cross join
-- •	Cartesian product

-- The syntax for a union operation
--     SELECT_statement_1
-- UNION [ALL]
--    SELECT_statement_2
-- [UNION [ALL]
--     SELECT_statement_3]...
-- [ORDER BY order_by_list]

-- Rules for a union
-- •	Each result set must return the same number of columns.
-- •	The corresponding columns in each result set must have compatible   data types.
-- •	The column names in the final result set are taken from the first SELECT clause.

USE ex;
-- A union that combines result sets from two different tables
   SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM ex.active_invoices
    WHERE invoice_date >= '2018-06-01'
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM ex.paid_invoices
    WHERE invoice_date >= '2018-06-01'
ORDER BY invoice_total DESC;


-- A union that combines result sets from a single table
    SELECT 'Active' AS source, invoice_number,
        invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0
UNION
    SELECT 'Paid' AS source, invoice_number,
        invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total <= 0
ORDER BY invoice_total DESC;

-- A union that combines result sets from the same two tables
   SELECT invoice_number, vendor_name,
        '33% Payment' AS payment_type,
        invoice_total AS total,
        invoice_total * 0.333 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total > 10000
UNION
    SELECT invoice_number, vendor_name,
        '50% Payment' AS payment_type,
        invoice_total AS total,
        invoice_total * 0.5 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total BETWEEN 500 AND 10000
UNION
    SELECT invoice_number, vendor_name,
        'Full amount' AS payment_type,
        invoice_total AS total,
        invoice_total AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total < 500
ORDER BY payment_type, vendor_name, invoice_number;

-- A union that simulates a full outer join
   SELECT department_name AS dept_name,
           d.department_number AS d_dept_no,
           e.department_number AS e_dept_no, last_name
    FROM ex.departments d 
        LEFT JOIN ex.employees e 
        ON d.department_number = e.department_number
UNION
    SELECT department_name AS dept_name,
           d.department_number AS d_dept_no,
           e.department_number AS e_dept_no, last_name
    FROM ex.departments d 
        RIGHT JOIN ex.employees e 
        ON d.department_number = e.department_number
ORDER BY dept_name;

-- Terms to know about unions
-- •	Union
-- •	Full outer join



