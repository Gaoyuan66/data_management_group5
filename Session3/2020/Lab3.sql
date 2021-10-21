-- Lab 3
USE ap;
-- 1.
SELECT 
    v.vendor_name
  , i.invoice_date
  , i.invoice_number
  , li.invoice_sequence
  , li.line_item_amount
FROM vendors v
JOIN invoices i
ON v.vendor_id = i.vendor_id
JOIN invoice_line_items li
ON i.invoice_id = li.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence
;

-- 2
SELECT 
  v1.vendor_id
, v1.vendor_name
, CONCAT(v1.vendor_contact_first_name," ",v1.vendor_contact_last_name) AS contact_name
FROM vendors v1
JOIN vendors v2
ON v1.vendor_id <> v2.vendor_id 
AND v1.vendor_contact_last_name = v2.vendor_contact_last_name
ORDER BY v1.vendor_contact_last_name
;

-- 3
SELECT
  a.account_number
, account_description
, invoice_id
FROM general_ledger_accounts a
LEFT JOIN invoice_line_items li
ON a.account_number = li.account_number
WHERE invoice_id IS NULL
;

-- 4
SELECT 
  account_description
, COUNT(a.account_number) AS count_line
, SUM(line_item_amount) AS sum_line_item_amount
FROM general_ledger_accounts a
JOIN invoice_line_items li
ON a.account_number = li.account_number
GROUP BY a.account_number
HAVING count_line>1
ORDER BY sum_line_item_amount DESC
;


-- 5
SELECT 
  account_description
, COUNT(a.account_number) AS count_line
, SUM(line_item_amount) AS sum_line_item_amount
FROM general_ledger_accounts a
JOIN invoice_line_items li
ON a.account_number = li.account_number
JOIN invoices i
ON i.invoice_date BETWEEN "2018-04-01" AND "2018-06-30"
AND i.invoice_id = li.invoice_id
GROUP BY a.account_number
HAVING count_line>1
ORDER BY sum_line_item_amount DESC
;

-- 6
SELECT 
  IF(GROUPING(terms_id) = 1, 'Grand Totals', terms_id) AS terms_id
, IF(GROUPING(vendor_id) = 1, 'Terms ID Totals', vendor_id) AS vendor_id
, MAX(payment_date) AS last_payment_date
, SUM(invoice_total - payment_total - credit_total) sum_balance_due
FROM invoices i
GROUP BY terms_id, vendor_id
WITH ROLLUP
;

-- 7

SELECT 
invoice_number
, invoice_total
FROM invoices i
WHERE payment_total > (
  SELECT AVG(payment_total)
  FROM invoices i
  WHERE payment_total>0
  )
ORDER BY invoice_total DESC
;


-- 8
SELECT
v.vendor_name
, i.invoice_id
, invoice_sequence
, line_item_amount
FROM Invoice_Line_Items li 
JOIN invoices i
ON li.invoice_id = i.invoice_id
JOIN vendors v
ON i.vendor_id = v.vendor_id
WHERE i.invoice_id IN
(
SELECT DISTINCT
invoice_id
FROM Invoice_Line_Items li
WHERE li.invoice_sequence>1
)
ORDER BY vendor_name, invoice_id, invoice_sequence
;

-- 9
SELECT
vendor_name
, invoice_number
, invoice_date
, invoice_total
FROM vendors v
JOIN invoices i
ON v.vendor_id = i.vendor_id
WHERE invoice_date = (
SELECT MIN(invoice_date) FROM invoices i2 where i2.vendor_id = v.vendor_id
)
ORDER BY vendor_name
;

-- 10
SELECT
vendor_name
, invoice_number
, invoice_date
, invoice_total
FROM vendors v
JOIN invoices i
ON v.vendor_id = i.vendor_id
JOIN (
SELECT vendor_id, MIN(invoice_date) AS ealiest_date
FROM invoices
GROUP BY vendor_id
) e_d 
ON invoice_date = ealiest_date
AND e_d.vendor_id = i.vendor_id
ORDER BY vendor_name
;

-- 11
SELECT
vendor_name
, i1.invoice_number
, i1.invoice_date
, i1.invoice_total
FROM vendors v
JOIN invoices i1
ON v.vendor_id = i1.vendor_id
LEFT OUTER JOIN invoices i2
ON i1.invoice_date > i2.invoice_date
AND i1.vendor_id = i2.vendor_id
WHERE i2.invoice_date IS NULL
ORDER BY vendor_name
;

-- 12
CREATE VIEW open_items AS 
SELECT vendor_name
, invoice_number
, invoice_total
, (invoice_total - payment_total - credit_total) AS balance_due 
FROM invoices i
JOIN vendors v
ON i.vendor_id = v.vendor_id
;

-- 13
SELECT *
FROM open_items
WHERE balance_due>1000