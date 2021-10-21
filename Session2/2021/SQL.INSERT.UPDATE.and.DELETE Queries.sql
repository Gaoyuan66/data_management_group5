-- ************************************************************************
-- The following SQL queries demonstrate the  most important features of 
-- the INSERT, DELETE, and UPDATE queries. The queries closely follow the 
-- examples given in chapter 5 of Murach's MySQL (3rd Edition). 
--
-- Run each query individually to see results in the Results Grid, using
-- (a) "Execute the statement under the keyboard cursor" button 
-- (b) Pressing Ctrl-Enter (on Windows)
--
-- Prepared by David Tilson 22-September-2019
-- ************************************************************************

USE ap; 
-- Note you should reinstall the ap database if you have made changes to
-- it and want to run these examples again

-- MySQL's SQL_SAFE_UPDATES setting prevents you running UPDATE and DELETE
-- queries without specifying a PK or FK in the WHERE clause
-- I turn it off here (and reenable it at the end of this file)
SET SQL_SAFE_UPDATES = 0;

-- ************************************************************************
-- ************************************************************************
--								INSERT QUERIES
-- ************************************************************************
-- ************************************************************************

DESCRIBE invoices; -- see which fields allow NULLS and have default values
SELECT * FROM invoices; -- note largest invoice_id is 114

-- INSERT a single row without a column list
-- Note that fields must be in exactly same order as shown in metadata
INSERT INTO invoices VALUES
(115, 97, '456789', '2018-08-01', 8344.50, 0, 0, 1, '2018-08-31', NULL);

-- ************************************************************************
-- INSERT a single row with a column list (more flexible)
-- Note that list does not include
-- (a) invoice_id since it is auto generated if one is not provided
-- (b) payment_total and credit_total since they have default values specified
-- (c) payment_due as it allows NULLs

-- Also note that the columns are specified in a different order than before
-- That is fine as long as the values are specified in the matching order
INSERT INTO invoices 
	(vendor_id, invoice_number, invoice_total, terms_id, invoice_date, invoice_due_date)
VALUES
	(97, '456789',  8344.50, 1, '2018-08-01', '2018-08-31');
 
 -- ************************************************************************
-- Multiple rows can be inserted at once. Note that the DEFAULT keyword 
-- inserts the default value for a field including an auto_incrementing column 
INSERT INTO invoices VALUES
(117, 97, '456701', '2018-08-02', 270.50, 0, 0, 1, '2018-09-01', NULL),
(118, 97, '456791', '2018-08-03', 4390.00, 0, 0, 1, '2018-09-02', NULL),
(DEFAULT, 97, '456792', '2018-08-03', 565.60, DEFAULT, DEFAULT, 1, '2018-09-02', NULL);

-- ************************************************************************
SELECT * FROM invoice_archive; -- Check that invoice_archive table is empty

-- This query identifies invoices with no outstanding balance
SELECT * FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;

-- We can use INSERT INTO to copy these rows of the invoice table to the invoice_archive table
-- The embedded SELECT query is a "subquery" and takes advantage of the fact that the input
-- and output of queries are "relations." So, the output of one can be the input of another 
INSERT INTO invoice_archive
SELECT * 
FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;

SELECT * FROM invoice_archive; -- Check that the rows are in invoice_archive


-- ************************************************************************
-- ************************************************************************
--								UPDATE QUERIES
-- ************************************************************************
-- ************************************************************************

-- The UPDATE statement is used to change values already stored in database tables

-- First look at the row of data we want to change payment_total is 1762.16 and 
-- payment_date is 2018-07-30. Running such a query is useful for ensuring that
-- the WHERE clause you will  -- use in the UPDATE statement filters the intended row(s)
SELECT * FROM invoices WHERE invoice_number = '97/522';

UPDATE invoices
SET payment_date = '2018-09-21',
	payment_total = 19451.18
WHERE invoice_number = '97/522';

-- Check that the update has been made using the SELECT query above
SELECT * FROM invoices WHERE invoice_number = '97/522';


-- ************************************************************************
-- I follow similar logic for to change terms for vendor_id = 95
-- This changes the value of one column for multiple rows
SELECT * FROM invoices WHERE vendor_id = 95; -- Six invoices all with terms_id = 2 

UPDATE invoices
SET terms_id = 1
WHERE vendor_id = 95;

SELECT * FROM invoices WHERE vendor_id = 95; -- Six invoices all with terms_id = 1 

-- ************************************************************************
-- Increase the credit total by 100 for invoice_number '97/522' 
-- First I check the current value (it is 200.00)
SELECT * FROM invoices WHERE invoice_number = '97/522';

-- Run the update query using an expression
UPDATE invoices
SET credit_total = credit_total +100
WHERE invoice_number = '97/522';

-- Check the new value for credit_total (it is now 300.00)
SELECT * FROM invoices WHERE invoice_number = '97/522';

-- ************************************************************************
-- We can also use subqueries in an UPDATE statement. In this case we want 
-- to update all the invoices for a particular vendor (Pacific Bell)
-- Let's test the sub query first ... what is the vendor_id for this vendor? 
SELECT vendor_id FROM vendors
WHERE vendor_name = 'Pacific Bell';

-- Write the query to test current value of terms_id for this vendor
-- LEFT AS AN EXERCISE FOR YOU ... there should be 6 rows all with terms_id = 1

-- The UPDATE query itself takes the vendor_id from the subquery and uses it in the WHERE 
-- clause of the  UPDATE query
UPDATE invoices 
SET terms_id = 3
WHERE vendor_id = 
	(SELECT vendor_id
	FROM vendors
	WHERE vendor_name = 'Pacific Bell');

-- If you check the invoices table for you will see the changes
-- LEFT AS AN EXERCISE FOR YOU ... there should be 6 rows all with terms_id = 3

-- Using the IN phrase in the WHERE clause allows you do a similar update
-- for vendors in several states 
UPDATE invoices 
SET terms_id = 1
WHERE vendor_id IN 
	(SELECT vendor_id
    FROM vendors
    WHERE vendor_state IN ('CA', 'AZ', 'NV')); 
    
    
-- ************************************************************************
-- ************************************************************************
-- 								DELETE QUERIES
-- ************************************************************************
-- ************************************************************************

-- I want to delete the entry in the general_ledger_accounts table for 
-- account_number 306. I first run a select query to make sure I will
-- only change what I think I am going to
SELECT * from general_ledger_accounts
WHERE account_number = 306;

-- This is the actual DELETE query. Notice that it uses the same WHERE
-- clause that I used in the SELECT query above
DELETE FROM general_ledger_accounts
WHERE account_number = 306;

-- I leave it an an exercise for you to run the above SELECT query above to 
-- confirm that the row has been removed

-- ************************************************************************
-- I recomend that you create SELECT queries to check the row(s) defined by
-- the WHERE clauses in the following DELETE queries. Use them to check the
-- contents of the targeted rows before and after the DELETE queries to 
-- ensure you know what they are doing.

-- This will delete one line item specified by the compound condition
DELETE FROM invoice_line_items
WHERE invoice_id = 78 AND invoice_sequence = 2;

-- This will delete all the line items corresponding to invoice_id = 12
-- It deletes four rows
DELETE FROM invoice_line_items
WHERE invoice_id = 12; 

-- This query deletes all the line items for all invoices for vendor_id = 115
-- To make sure you know what is going on I recommend you run the subquery on its own
-- and then construct a SELECT query that returns the line items that will be deleted

DELETE FROM invoice_line_items
WHERE invoice_id IN 
(
SELECT invoice_id 
FROM invoices
WHERE vendor_id = 115
);

-- Reenable SAFE UPDATES
SET SQL_SAFE_UPDATES = 1;


