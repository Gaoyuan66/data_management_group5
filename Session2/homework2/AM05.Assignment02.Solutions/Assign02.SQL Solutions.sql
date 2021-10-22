-- Question 1

-- solution 1
INSERT INTO categories
VALUES (DEFAULT, 'Brass');
-- solution 2
INSERT INTO categories (category_name)
VALUES ('Brass');

-- Question 2
UPDATE categories
SET category_name = 'Woodwinds'
WHERE category_id = 5;

-- Question 3
DELETE FROM categories
WHERE category_id = 5;

-- Question 4
INSERT INTO products 
    (category_id, product_code, product_name, description, list_price, date_added)
VALUES 
    (4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 779.99, NOW());


-- Question 5
UPDATE products
SET discount_percent = 35
WHERE product_code = 'dgx_640';

-- Question 6
DELETE FROM products
WHERE category_id = 4;

DELETE FROM categories
WHERE category_id = 4;


-- Question 7
INSERT INTO customers 
  (email_address, password, first_name, last_name)
VALUES
  ('rick@raven.com', '', 'Rick', 'Raven');

-- Question 8
UPDATE customers
SET password = 'secret'
WHERE email_address = 'rick@raven.com'


-- Question 9
UPDATE customers
SET password = 'reset'
LIMIT 100; 

