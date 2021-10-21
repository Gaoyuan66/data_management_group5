/*
The following SQL queries introduce the most important features of 
subqueries. The queries closesly follow the examples given in 
chapter  of Murach's MySQL (3rd Edition). 

Run each query individually to see results in the Results Grid, using
(a) "Execute the statement under the keyboard cursor" button 
(b) Pressing Ctrl-Enter (on Windows)

Prepared by David Tilson 28 -September-2019 
*/

-- A subquery in the WHERE clause
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_total > 
    (SELECT AVG(invoice_total)
     FROM invoices)
ORDER BY invoice_total; 

-- Value returned by the subquery (1879.741316)
SELECT AVG(invoice_total)
     FROM invoices; 

-- A query that uses an inner join
SELECT invoice_number, invoice_date, invoice_total
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
WHERE vendor_state = 'CA'
ORDER BY invoice_date;


-- The same query restated with a subquery
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE vendor_id IN
    (SELECT vendor_id
     FROM vendors
     WHERE vendor_state = 'CA')
ORDER BY invoice_date; 


-- The syntax of a WHERE clause that uses an IN phrase
-- WHERE test_expression [NOT] IN (subquery)
-- A query that gets vendors without invoices
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE vendor_id NOT IN
    (SELECT DISTINCT vendor_id
     FROM invoices)
ORDER BY vendor_id;

-- The result of the subquery that gets distinct vendor ids with invoices
-- The result set that gets vendors without invoices

-- The same query restated without a subquery
SELECT v.vendor_id, vendor_name, vendor_state
FROM vendors v LEFT JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE i.vendor_id IS NULL
ORDER BY v.vendor_id;

-- The syntax of a WHERE clause that uses a comparison operator
-- WHERE expression comparison_operator [SOME|ANY|ALL] (subquery)
-- A query with a subquery in a WHERE condition
SELECT invoice_number, invoice_date, 
    invoice_total - payment_total - credit_total AS balance_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0 
  AND invoice_total - payment_total - credit_total <
    (SELECT AVG(invoice_total - payment_total - credit_total)
     FROM invoices
     WHERE invoice_total - payment_total - credit_total > 0)
ORDER BY invoice_total DESC;

-- The value returned by the subquery
-- The result set 2910.947273

-- A query that uses ALL
-- Get invoices larger than the largest invoice for vendor 34
SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total > ALL
    (SELECT invoice_total
     FROM invoices
     WHERE vendor_id = 34)
ORDER BY vendor_name; 

-- A query that uses ANY
-- Get invoices smaller than largest invoice for vendor 115
SELECT vendor_name, invoice_number, invoice_total
FROM vendors JOIN invoices
  ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_total < ANY
    (SELECT invoice_total
     FROM invoices
     WHERE vendor_id = 115);


-- A query that uses a correlated subquery
-- Get each invoice amount that's higher than
-- the vendor's average invoice amount
SELECT vendor_id, invoice_number, invoice_total
FROM invoices i
WHERE invoice_total >
    (SELECT AVG(invoice_total)
     FROM invoices
     WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total;

-- The value returned by the subquery 
-- for vendor 95 (28.501667)
SELECT AVG(invoice_total)
FROM invoices
WHERE vendor_id = 95;

-- The syntax of a subquery that uses the EXISTS operator
-- WHERE [NOT] EXISTS (subquery)
-- A query that gets vendors without invoices
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE NOT EXISTS
    (SELECT * 
     FROM invoices
     WHERE vendor_id = vendors.vendor_id);

-- A subquery in the SELECT clause
-- Get the most recent invoice date for each vendor
SELECT vendor_name,
    (SELECT MAX(invoice_date) FROM invoices
     WHERE vendor_id = vendors.vendor_id) AS latest_inv
FROM vendors
ORDER BY latest_inv DESC;


-- The same query restated using a join
SELECT vendor_name, MAX(invoice_date) AS latest_inv
FROM vendors v 
    LEFT JOIN invoices i ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY latest_inv DESC;

-- Get the largest invoice total for the top vendor in each state
-- A query that uses an inline view
SELECT vendor_state,
    MAX(sum_of_invoices) AS max_sum_of_invoices
FROM
(
     SELECT vendor_state, vendor_name,
         SUM(invoice_total) AS sum_of_invoices
     FROM vendors v JOIN invoices i 
         ON v.vendor_id = i.vendor_id
     GROUP BY vendor_state, vendor_name
) t
GROUP BY vendor_state
ORDER BY vendor_state;

-- Create a VIEW equivalent to the subquery 
-- in the previous query
CREATE VIEW invoice_totals_by_vendor_V AS
     SELECT vendor_state, vendor_name,
         SUM(invoice_total) AS sum_of_invoices
     FROM vendors v JOIN invoices i 
         ON v.vendor_id = i.vendor_id
     GROUP BY vendor_state, vendor_name;

-- Show what the view returns
SELECT * FROM invoice_totals_by_vendor_V;

-- Get the largest invoice total for the top vendor in each state
-- A query that uses a VIEW
SELECT vendor_state,
    MAX(sum_of_invoices) AS max_sum_of_invoices
FROM invoice_totals_by_vendor_V
GROUP BY vendor_state
ORDER BY vendor_state;


-- Same query coded again with a common table expression (CTE)
WITH invoice_totals_by_vendor AS 
(
     SELECT vendor_state, vendor_name,
         SUM(invoice_total) AS sum_of_invoices
     FROM vendors v JOIN invoices i 
         ON v.vendor_id = i.vendor_id
     GROUP BY vendor_state, vendor_name
)
SELECT vendor_state,
    MAX(sum_of_invoices) AS max_sum_of_invoices
FROM invoice_totals_by_vendor
GROUP BY vendor_state
ORDER BY vendor_state;




-- Not covered in AM05 Class 3... but still a goo example to look at

-- A complex query that uses three subqueries
-- It is designed to retreive the vendor from each state that has the largest
-- invoice total. 
SELECT t1.vendor_state, vendor_name, t1.sum_of_invoices
FROM
    (
        -- invoice totals by vendor
        SELECT vendor_state, vendor_name,
            SUM(invoice_total) AS sum_of_invoices
        FROM vendors v JOIN invoices i 
            ON v.vendor_id = i.vendor_id
        GROUP BY vendor_state, vendor_name
    ) t1
JOIN
        (
            -- top invoice totals by state
            SELECT vendor_state,  
                   MAX(sum_of_invoices)
                   AS sum_of_invoices
            FROM
            (
                 -- invoice totals by vendor
                 SELECT vendor_state, vendor_name,
                     SUM(invoice_total)
                     AS sum_of_invoices
                 FROM vendors v JOIN invoices i 
                     ON v.vendor_id = i.vendor_id
                 GROUP BY vendor_state, vendor_name
            ) t2
            GROUP BY vendor_state
        ) t3
    ON t1.vendor_state = t3.vendor_state AND 
       t1.sum_of_invoices = t3.sum_of_invoices
ORDER BY vendor_state; 


/* A procedure for building complex queries
•	State the problem to be solved by the query in English.
•	Use pseudocode to outline the query.
•	Code the subqueries and test them to be sure that they return the correct data.
•	Code and test the final query.
*/
