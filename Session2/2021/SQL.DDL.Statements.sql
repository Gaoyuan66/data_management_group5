-- ************************************************************************
-- The following SQL queries demonstrate the  most important features of 
-- the SQL Data Definition Language (DDL). The queries closely follow the 
-- examples given in chapter 11 of Murach's MySQL (3rd Edition). 
--
-- Run each query individually to see results in the Results Grid, using
-- (a) "Execute the statement under the keyboard cursor" button 
-- (b) Pressing Ctrl-Enter (on Windows)
--
-- Prepared by David Tilson 22-September-2019
-- ************************************************************************

-- Look at a list of the existing databases on our server
SHOW DATABASES; 

-- Drop the am_05 database (if you have already created one). The inclusion of "IF EXISTS" 
-- prevents an error if it did not already exist
DROP DATABASE IF EXISTS am05_demo;

-- Run the following statement and run it if you want to see the type of error you get
-- trying to drop a database that does not exist
DROP DATABASE am05_does_not_exist;

-- Create a new database to explore SQL DDL 
CREATE DATABASE IF NOT EXISTS am05_demo;
SHOW DATABASES; -- Check that it now exists

USE am05_demo; -- USE the database for he following statements
SHOW TABLES;   -- Check that there are no tables in it

-- Create a simple version of the vendors table
CREATE TABLE vendors
(
	vendor_id 		INT,
    vendor_name 	VARCHAR(50)
);

SHOW TABLES; -- We should be able to see this new table

-- DROP this table and create a slightly more sophisticated version
-- Shows how we can 
-- (a) Require a field to contain unique values
-- (b) Not allow a field to contain NULL values
-- (c) Generate unique numbers in sequence (AUTO_INCREMENT)... useful for Primary Keys
DROP TABLE vendors;
CREATE TABLE vendors
(
	vendor_id 		INT				NOT NULL	UNIQUE	AUTO_INCREMENT,
    vendor_name 	VARCHAR(50)		NOT NULL	UNIQUE
);

DESCRIBE vendors; -- View the metadata associated with the table

-- Create slightly more sophisticate version of invoices table. Shows how we can set a default 
-- value for a field if one is not specified for a newly inserted row. Also shows more data types
CREATE TABLE invoices
(
	invoices_id 		INT				NOT NULL	UNIQUE,
    vendor_id			INT				NOT NULL,
    vendor_name 		VARCHAR(50)		NOT NULL, 
    invoice_date		DATE, 
    invoice_total		DECIMAL(9,2)	NOT NULL,
    payment_total		DECIMAL(9,2)				DEFAULT 0
);

SHOW TABLES;

DESCRIBE invoices; -- View the metadata associated with the table

------------------------------------------------------------
-- Specifying a PRIMARY KEY (PK) CONSTRAINT at column level
------------------------------------------------------------
DROP TABLE IF EXISTS vendors; -- drop vendors table
-- Create vendors table defining PK constraint at column-level 
CREATE TABLE vendors
(
	vendor_id 		INT				NOT NULL	PRIMARY KEY	AUTO_INCREMENT,
    vendor_name 	VARCHAR(50)		NOT NULL	UNIQUE
);
DESCRIBE vendors;

------------------------------------------------------------
-- Specifying a PRIMARY KEY (PK) CONSTRAINT at table level
------------------------------------------------------------
DROP TABLE IF EXISTS vendors; -- drop vendors table
-- Create vendor table defining PK constraint at column-level 
--
-- PK and UNIQUE CONSTRAINTS define at table level
-- Allows the constraints to be give names (helps when errors occur)
-- Notice naming convention used for constraints
-- (a) name of table \ column
-- (b) two-letter abbreviation for name of constraint type
-- 
-- Note that my specifying a field as the PRIMARY KEY it
-- automatically takes on the NOT NULL and UNIQUE constraints
CREATE TABLE vendors
(
	vendor_id 		INT				NOT NULL	AUTO_INCREMENT,
    vendor_name 	VARCHAR(50)		NOT NULL,
    CONSTRAINT vendors_pk PRIMARY KEY(vendor_id),
    CONSTRAINT vendors_name_uq UNIQUE (vendor_name)
);
DESCRIBE vendors;


-- This table includes the definition of a composite key
CREATE TABLE invoice_line_items
(
	invoice_id				INT				NOT NULL,
    invoice_sequence		INT				NOT NULL, 
    line_item_description	VARCHAR(100) 	NOT NULL, 
    CONSTRAINT line_items_pk PRIMARY KEY (invoice_id, invoice_sequence)
);
DESCRIBE invoice_line_items;


------------------------------------------------------------
-- Specifying a FOREIGN KEY (FK) CONSTRAINT at table level
------------------------------------------------------------
DROP TABLE IF EXISTS invoices; 
CREATE TABLE invoices
(
	invoices_id 		INT				PRIMARY KEY,
    vendor_id			INT				NOT NULL,
    vendor_number 		VARCHAR(50)		NOT NULL	UNIQUE,
    CONSTRAINT	invoices_fk_vendors FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id)
);
DESCRIBE invoices;

-- Test FK constraint by trying to insert data into invoices. MySQL should trow an error.  
-- The FK constraint is violated since there is no vendor in the vendors table with vendor_id 
-- equal to a value of one. 
INSERT INTO invoices
VALUES (1,1,'1');

-- Insert a vendor into the vendor table first
-- and checkt that it is there
INSERT INTO vendors (vendor_name)
VALUES ('LBS');
SELECT * FROM vendors;

-- This time data can be inserted into invoices
-- since there is a vendor with vendor_id = 1 in the vendor table
INSERT INTO invoices
VALUES (1,1,'1');
SELECT * from invoices; -- check that the record is there

-- If you try to drop the vendors table the existence of a record in the invoices table
-- that refers to the vendors table will prevent you from deleting it
DROP TABLE vendors;

-- But you can drop the other two tables
DROP TABLE invoices, invoice_line_items;
SHOW TABLES;

-- And then the vendors table since the invoices table does not refer to it anymore
DROP TABLE vendors;

-- Drop the database and confirm that it has gone
DROP DATABASE am05_demo; 
SHOW DATABASES;






