-- Add a table to the ex (examples) database 
USE ex;
DROP TABLE IF EXISTS calls_911;

-- Specify the format of the table we would like to create
CREATE TABLE calls_911 (
    call_id INT PRIMARY KEY auto_increment,
    call_date DATE,
    call_time TIME,
    event_descrip	VARCHAR(255),
    event_address	VARCHAR(50),
    resp_agency		VARCHAR(40),
    event_id		VARCHAR(20),
    original_text 	VARCHAR(300) NOT NULL);
 
 -- Insert some original data from the feed from the Monroe County NY emergency services datafeed
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 515 E Main on 10/05/19 at  11:42 AM (CTYP192801309)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with unknown injuries at 351 Joseph on 10/06/19 at  11:39 AM (CTYP192801298)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at Aldine St/Wellington on 10/03/19 at  11:37 AM (CTYP192801293)');
INSERT INTO calls_911 (original_text) VALUES ('New York State Police responded to complaint of dangerous condition at Sb Rt 590 To Wb Rt 4 on 10/06/19 at  11:36 AM (NYSP192801289)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Sb Rt 590 To Wb Rt 4 on 10/02/19 at  11:36 AM (RTOC192801290)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with unknown injuries at E Broad St/Exchange on 10/04/19 at  11:36 AM (CTYP192801288)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 14 Market St, Brockport on 10/07/19 at  11:20 AM (BROP192801255)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to dumpster fire at 80 Cuba on 10/02/19 at  11:18 AM (CTYF192801253)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 134 Monroe Av, Brockport on 10/06/19 at  11:10 AM (BROP192801240)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 207 Rutgers on 10/06/19 at  10:57 AM (CTYP192801197)');
INSERT INTO calls_911 (original_text) VALUES ('Brighton Police responded to complaint of dangerous condition at Brighton Henrta T L Rd/W Henrietta Rd, on 10/04/19 at  10:54 AM (BRIP192801185)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Brighton Henrta T L Rd/W Henrietta Rd, on 10/02/19 at  10:54 AM (RTOC192801186)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at Chestnut St/Lawn on 10/05/19 at  10:54 AM (CTYP192801184)');
INSERT INTO calls_911 (original_text) VALUES ('Gates Police responded to parking complaint at 2150 Chili Av, Gates on 10/03/19 at  10:51 AM (GATP192801176)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 98 Ambrose on 10/03/19 at  10:46 AM (CTYP192801155)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 630 N Clinton on 10/06/19 at  10:45 AM (CTYP192801147)');
INSERT INTO calls_911 (original_text) VALUES ('Henrietta Fire responded to mva with injuries at 01 Miracle Mile Dr, Henrietta on 10/05/19 at  10:41 AM (HENF192801131)');
INSERT INTO calls_911 (original_text) VALUES ('Penfield Fire responded to complaint of smoke odor at 3768 Atlantic Av, Penfield on 10/03/19 at  10:40 AM (PENF192801126)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 1 Miracle Mile Dr, Henrietta on 10/02/19 at  10:39 AM (MCOP192801123)');
INSERT INTO calls_911 (original_text) VALUES ('Ridge Road Fire responded to mva with injuries at 4265 Mt Read Bl, Greece on 10/06/19 at  10:38 AM (RROF192801116)');
INSERT INTO calls_911 (original_text) VALUES ('Greece Police responded to mva with known injury at 4265 Mt Read Bl, Greece on 10/04/19 at  10:38 AM (GREP192801115)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe Ambulance responded to mva with injuries at 4265 Mt Read Bl, Greece on 10/06/19 at  10:37 AM (MONE192801112)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with known injury at 745 Calkins Rd, Henrietta on 10/05/19 at  10:34 AM (MCOP192801097)');
INSERT INTO calls_911 (original_text) VALUES ('Henrietta Fire responded to mva with injuries at 745 Calkins Rd, Henrietta on 10/05/19 at  10:34 AM (HENF192801098)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 16 Henry on 10/07/19 at  10:32 AM (CTYP192801091)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to complaint of smoke odor at 154 Manor on 10/04/19 at  10:31 AM (CTYF192801087)');
INSERT INTO calls_911 (original_text) VALUES ('Irondequoit Police responded to mva with unknown injuries at On Culver Rd At Rt 104, Irondequoit on 10/05/19 at  10:29 AM (IROP192801082)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 3768 Atlantic Av, Penfield on 10/02/19 at  10:27 AM (MCOP192801074)');
INSERT INTO calls_911 (original_text) VALUES ('Penfield Fire responded to wires burning in a tree at 3768 Atlantic Av, Penfield on 10/04/19 at  10:27 AM (PENF192801075)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 40 Ramona on 10/04/19 at  10:23 AM (CTYP192801062)');
INSERT INTO calls_911 (original_text) VALUES ('Greece Police responded to hit and run at 3701 Mt Read Bl, Greece on 10/04/19 at  10:22 AM (GREP192801053)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to hit and run at 1350 Turk Hill Rd, Perinton on 10/03/19 at  10:22 AM (MCOP192801058)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to mva with injuries at Brighton Pk/E Henrietta on 10/04/19 at  10:08 AM (CTYF192801018)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with known injury at Brighton Pk/E Henrietta on 10/04/19 at  10:08 AM (CTYP192801017)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to hit and run at 1000 E Henrietta Rd, Brighton on 10/05/19 at  10:07 AM (MCOP192801013)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with unknown injuries at Brighton Pk/E Henrietta on 10/06/19 at  10:06 AM (CTYP192801010)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to complaint of dangerous condition at W Ridge Rd/Sweden Walker Rd, Clarkson on 10/05/19 at  10:03 AM (MCOP192801003)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to traffic light problems at Lake Rd/Rt 18-Roosevelt Hw, Hamlin on 10/06/19 at  10:02 AM (RTOC192800994)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to traffic light problems at W Ridge Rd/Sweden Walker Rd, Clarkson on 10/02/19 at  10:00 AM (RTOC192800985)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to traffic light problems at Redman Rd/W Ridge Rd, Clarkson on 10/05/19 at  09:57 AM (RTOC192800970)');
INSERT INTO calls_911 (original_text) VALUES ('Irondequoit Police responded to problems at school crossings at 150 Colebrook Dr, Irondequoit on 10/03/19 at  09:57 AM (IROP192800971)');
INSERT INTO calls_911 (original_text) VALUES ('Irondequoit Police responded to problems at school crossings at 210 Colebrook Dr, Irondequoit on 10/03/19 at  09:50 AM (IROP192800950)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to dumpster fire at 1261 South on 10/02/19 at  09:49 AM (CTYF192800947)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 16 N Goodman on 10/07/19 at  09:44 AM (CTYP192800934)');
INSERT INTO calls_911 (original_text) VALUES ('Gates Police responded to mva with unknown injuries at Buffalo Rd/Howard Rd, Gates on 10/05/19 at  09:42 AM (GATP192800923)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 45 College St, Brockport on 10/07/19 at  09:40 AM (BROP192800919)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 35 Monroe Av, Brockport on 10/03/19 at  09:32 AM (BROP192800898)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Sb Rt 390 At Exit 11, Rush on 10/04/19 at  09:28 AM (MCOP192800886)');
INSERT INTO calls_911 (original_text) VALUES ('New York State Police responded to complaint of dangerous condition at Wb Rt 490 Eo S Goodman on 10/03/19 at  09:27 AM (NYSP192800881)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Wb Rt 490 Eo S Goodman on 10/05/19 at  09:27 AM (RTOC192800882)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to MVA rollover at Eb Rt 490 At S Clinton on 10/07/19 at  09:18 AM (CTYF192800844)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with known injury at Joseph Av/Upper Falls on 10/07/19 at  09:16 AM (CTYP192800838)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to MVA auto - pedestrian at Joseph Av/Upper Falls on 10/02/19 at  09:16 AM (CTYF192800839)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to dumpster fire at 1503 E Main on 10/04/19 at  09:13 AM (CTYF192800831)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to hit and run at Linden Av/Rt 441, Pittsford on 10/07/19 at  09:03 AM (MCOP192800810)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Sb Rt 590 At Browncroft on 10/04/19 at  08:56 AM (RTOC192800787)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to hit and run at 1350 Jefferson Rd, Henrietta on 10/03/19 at  08:56 AM (MCOP192800788)');
INSERT INTO calls_911 (original_text) VALUES ('New York State Police responded to complaint of dangerous condition at Sb Rt 590 At Browncroft on 10/06/19 at  08:56 AM (NYSP192800786)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 22 Flint on 10/05/19 at  08:53 AM (CTYP192800781)');
INSERT INTO calls_911 (original_text) VALUES ('Webster Police responded to hit and run at 989 Hickory Hollow, Webster on 10/04/19 at  08:49 AM (WEBP192800774)');
INSERT INTO calls_911 (original_text) VALUES ('Gates Police responded to hit and run at Manitou Rd/Spencerport Rd, Gates on 10/03/19 at  08:47 AM (GATP192800767)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Sb Rt 390 At E Henrietta Rd, Brighton on 10/04/19 at  08:46 AM (MCOP192800764)');
INSERT INTO calls_911 (original_text) VALUES ('Irondequoit Police responded to problems at school crossings at 125 Kings Hw S, Irondequoit on 10/03/19 at  08:46 AM (IROP192800763)');
INSERT INTO calls_911 (original_text) VALUES ('Irondequoit Police responded to problems at school crossings at 130 Brett Rd, on 10/03/19 at  08:44 AM (IROP192800760)');
INSERT INTO calls_911 (original_text) VALUES ('Brighton Police responded to mva with known injury at On S Winton Rd At Rt 590, Brighton on 10/05/19 at  08:34 AM (BRIP192800727)');
INSERT INTO calls_911 (original_text) VALUES ('Brighton Fire responded to mva with injuries at On S Winton Rd At Rt 590, Brighton on 10/07/19 at  08:34 AM (BRIF192800728)');
INSERT INTO calls_911 (original_text) VALUES ('Brighton Ambulance responded to mva with injuries at On S Winton Rd At Rt 590, Brighton on 10/04/19 at  08:33 AM (BRIE192800723)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 89 Meigs on 10/06/19 at  08:30 AM (CTYP192800716)');
INSERT INTO calls_911 (original_text) VALUES ('Gates Police responded to hit and run at 1612 Buffalo Rd, Gates on 10/04/19 at  08:30 AM (GATP192800719)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 64 Sanford on 10/07/19 at  08:29 AM (CTYP192800706)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Jefferson Rd/S Winton Rd, Henrietta on 10/04/19 at  08:29 AM (MCOP192800708)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 3100 S Winton Rd, Henrietta on 10/03/19 at  08:28 AM (MCOP192800703)');
INSERT INTO calls_911 (original_text) VALUES ('Webster Police responded to mva with unknown injuries at On Basket Rd At Rt 104, Webster on 10/06/19 at  08:28 AM (WEBP192800701)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 7244 Fourth Section Rd, Sweden on 10/02/19 at  08:12 AM (MCOP192800666)');
INSERT INTO calls_911 (original_text) VALUES ('Greece Police responded to mva with unknown injuries at On Ridgeway Av At Rt 390, Greece on 10/03/19 at  08:10 AM (GREP192800662)');
INSERT INTO calls_911 (original_text) VALUES ('Irondequoit Police responded to problems at school crossings at 31 Empire Bl, Irondequoit on 10/06/19 at  08:10 AM (IROP192800663)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 363 E Ridge on 10/06/19 at  08:09 AM (CTYP192800661)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Eb Rt 490 At Buffalo Rd, Gates on 10/06/19 at  08:07 AM (RTOC192800656)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to complaint of dangerous condition at Eb Rt 490 At Buffalo Rd, Gates on 10/04/19 at  08:07 AM (MCOP192800655)');
INSERT INTO calls_911 (original_text) VALUES ('Greece Police responded to complaint of dangerous condition at W Ridge Rd/Tully La, Greece on 10/03/19 at  08:07 AM (GREP192800654)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Sb Rt 390 At Lexington Av, Gates on 10/02/19 at  07:58 AM (MCOP192800632)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 15 Airline Dr, Chili on 10/07/19 at  07:53 AM (MCOP192800626)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to hit and run at On Rt 96 At Rt 490 Basin Exit, Perinton on 10/05/19 at  07:52 AM (MCOP192800624)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at S Goodman St/Uniman on 10/06/19 at  07:50 AM (CTYP192800620)');
INSERT INTO calls_911 (original_text) VALUES ('Brighton Police responded to complaint of dangerous condition at 1100 S Winton Rd, Brighton on 10/06/19 at  07:47 AM (BRIP192800617)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with unknown injuries at 1445 Clifford on 10/02/19 at  07:34 AM (CTYP192800587)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to traffic light problems at Marsh Rd/Rt 31F, East Rochester on 10/02/19 at  07:28 AM (RTOC192800577)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at 1157 Scottsville on 10/03/19 at  07:28 AM (RTOC192800578)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with unknown injuries at 101 Lydia on 10/02/19 at  07:12 AM (CTYP192800555)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to hit and run at Nb Rt 390 At Lexington Av, Gates on 10/07/19 at  07:06 AM (MCOP192800546)');
INSERT INTO calls_911 (original_text) VALUES ('Gates Fire responded to dumpster fire at Nb Rt 390 At Lexington Av, Gates on 10/02/19 at  07:06 AM (GATF192800547)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 106 Attridge Rd, Chili on 10/02/19 at  07:05 AM (MCOP192800542)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to parking complaint at 10 Manhattan Square on 10/07/19 at  07:00 AM (CTYP192800536)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 656 Portland on 10/03/19 at  06:59 AM (CTYP192800535)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 45 Fayette St, Brockport on 10/05/19 at  06:53 AM (BROP192800526)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Sb Rt 390 At Airport, Gates on 10/06/19 at  06:53 AM (MCOP192800525)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at 780 Honeoye Falls 5 Pts Rd, Rush on 10/06/19 at  06:51 AM (MCOP192800521)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 30 Barry St, Brockport on 10/05/19 at  06:50 AM (BROP192800520)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at 275 Westfall on 10/03/19 at  06:24 AM (RTOC192800505)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to complaint of dangerous condition at 275 Westfall on 10/03/19 at  06:24 AM (CTYP192800504)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to complaint of smoke odor at 150 Highland on 10/06/19 at  06:12 AM (CTYF192800497)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to complaint of dangerous condition at Eb Rt 531 Eo Union St, Ogden on 10/05/19 at  06:10 AM (MCOP192800494)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Sb Scottsville Rd At Rt 390, Chili on 10/03/19 at  06:01 AM (RTOC192800485)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to complaint of dangerous condition at Sb Scottsville Rd At Rt 390, Chili on 10/06/19 at  06:01 AM (MCOP192800484)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Sb Rt 390 At Scottsville Rd, Chili on 10/02/19 at  05:57 AM (MCOP192800483)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to wires burning in a tree at 252 Edgerton on 10/03/19 at  05:19 AM (CTYF192800460)');
INSERT INTO calls_911 (original_text) VALUES ('Brockport Police responded to parking complaint at 35 Lincoln St, Brockport on 10/06/19 at  05:03 AM (BROP192800448)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to dumpster fire at 275 Hutchison on 10/05/19 at  04:33 AM (CTYF192800430)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Fire responded to complaint of smoke odor at 328 E Main on 10/06/19 at  02:53 AM (CTYF192800326)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Nb Rt 390 So Lexington Av, Gates on 10/03/19 at  02:52 AM (MCOP192800324)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to mva with unknown injuries at Wb Rt 490 At Exit 25, Pittsford on 10/02/19 at  02:39 AM (MCOP192800306)');
INSERT INTO calls_911 (original_text) VALUES ('Pittsford Fire responded to vehicle fire at Wb Rt 490 At Exit 25, Pittsford on 10/05/19 at  02:39 AM (PITF192800307)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to mva with unknown injuries at 58 Lehigh on 10/05/19 at  01:58 AM (CTYP192800241)');
INSERT INTO calls_911 (original_text) VALUES ('Monroe County Police responded to complaint of dangerous condition at Sb Rt 390 At Lyell Av, Gates on 10/06/19 at  01:56 AM (MCOP192800235)');
INSERT INTO calls_911 (original_text) VALUES ('Regional Traffic Operations Center responded to complaint of dangerous condition at Sb Rt 390 At Lyell Av, Gates on 10/07/19 at  01:56 AM (RTOC192800236)');
INSERT INTO calls_911 (original_text) VALUES ('Rochester City Police responded to hit and run at 255 Alexander on 10/06/19 at  01:39 PM (CTYP192800211)');

-- Check that the data is in expected field
select * from calls_911;

-- Here I build up some the logic I used to parse the data in the original text
-- First I would like to extract the event_id. I notc that it is the only text in parentheses
-- So, I use the following to extract this
-- In regex . means any character (except new line) and * means repeated zero or more times
-- Notice that the "(" is a special character in Regular Expressions. So, when I am searching for 
-- it I need to 'escape' it with two backward slashes "\\" 
SELECT 
    regexp_substr(original_text, '\\(.*\\)') AS event_id1 
FROM calls_911;

-- That's pretty good but it includes the parentheses. -- I got rid of the right one using the 
-- substring function and trim to get rid of the right one
SELECT 
    trim(")" FROM substring(regexp_substr(original_text, '\\(.*\\)'), 2) ) AS event_id 
FROM calls_911;


-- Next I set about extracting the date using the following. It finds two groups of or one or two 
-- digits \\d{1,2} followed by one group of two digits. Each group is separated by an forward slash "/" 
-- which I had to escape 
SELECT 
    regexp_substr(original_text, '\\d{1,2}\\/\\d{1,2}\\/\\d{2}') AS call_date 
FROM calls_911;
-- Later we might want to convert this to a proper DATE data type

-- Extracting the event description relies on the fact that it is alway between the word 'to' and 'at'
-- This first attempt systematically found a later occurence of the word 'at'
SELECT
	regexp_substr(original_text, '\\sto\\s(.*)at') AS event_descrip_1
FROM calls_911; 

-- This version adds a "?" as a lazy qualifier to find the shortest possible match
SELECT
	regexp_substr(original_text, '\\sto\\s(.*?)at') AS event_descrip_2
FROM calls_911; 

/* 
--------------------------------------------------------------------------
During the lab session you should
1. Remove the "to " at the beginning and the " at" from the end 
2. Capture the address, the time, and the responding agency
3. Update the table with the values you have extracted. 
You may need to convert some data types along the way.
See lab assignment for other questions.
--------------------------------------------------------------------------
*/ 

-- ---------------------------------------------------------------------
-- 		POSSIBLE SOLUTIONS TO ASSIGNMENT QUESTIONS
-- ---------------------------------------------------------------------

-- Test extracting the data using one SELECT query
SELECT 
    trim(")" FROM substring(regexp_substr(original_text, '\\(.*\\)'), 2) ) AS event_id,
	regexp_substr(original_text, '\\d{1,2}\\/\\d{1,2}\\/\\d{2}') AS call_date,
    regexp_substr(original_text, '\\d{2}:\\d{2}\\s(A|P)M') AS call_time,
    trim("responded" FROM regexp_substr(original_text, '^.*\\sresponded') ) AS resp_agency,
	trim(" on" FROM substring(regexp_substr(original_text, 'at\\s.*\\son'), 4) ) AS event_address,
	trim(" at" FROM substring(regexp_substr(original_text, '\\sto\\s(.*?)at'), 4) ) AS event_descrip
FROM calls_911;

-- Now it looks like we have all the data extracted as strings but not all are in the 
-- correct data types for putting in the table

-- The STR_TO_DATE function can convert strings to dates
-- This works for dates in the given format. See the documentation for more on how to specify formats
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format 
SELECT STR_TO_DATE("2017,8,14 10,40,10", "%Y,%m,%d %h,%i,%s");

-- Create a specification of this function to convert the strings returned
-- from the previous query into an actual date format 
-- Search MySQL documentation of other online resources if needed
-- e.g. https://www.w3schools.com/sql/func_mysql_str_to_date.asp
SELECT STR_TO_DATE("4/14/17" , "%m/%d/%y");

-- MySQL's SQL_SAFE_UPDATES setting prevents you running UPDATE and DELETE
-- queries without specifying a PK or FK in the WHERE clause
-- I turn it off here (and reenable it at the end of this file)
SET SQL_SAFE_UPDATES = 0;

-- The following UPDATE query extracts the data from the original text field and updates the corresponding
-- fields in the table. The call_date and call_time fields converted to TIME or DATE using 
-- the STR_TO_DATE function. Note that I had to cast the results from regexp_substr to CHAR type before
-- using STR_TO_DATE. 
UPDATE calls_911
SET 
call_date = STR_TO_DATE(cast(regexp_substr(original_text, '\\d{1,2}\\/\\d{1,2}\\/\\d{2}') AS CHAR(20)),"%m/%d/%y"),
call_time = STR_TO_DATE(cast(regexp_substr(original_text, '\\d{2}:\\d{2}\\s(A|P)M') AS CHAR(10)),'%h:%i %p'),
event_id = trim(")" FROM substring(regexp_substr(original_text, '\\(.*\\)'), 2) ),
resp_agency = trim("responded" FROM regexp_substr(original_text, '^.*\\sresponded') ),
event_address = trim(" on" FROM substring(regexp_substr(original_text, 'at\\s.*\\son'), 4) ),
event_descrip =	trim(" at" FROM substring(regexp_substr(original_text, '\\sto\\s(.*?)at'), 4) );

-- check that all the values are in the right place
select * from calls_911;


-- Question 2
-- Create an SQL query to report the 5 events types that have the largest number of occurrences in the database. 
-- Your results, which should be provided in descending order, should look something like the table below. 
SELECT event_descrip AS 'Event Description', COUNT(event_descrip) AS 'Number of Calls'
FROM calls_911
GROUP BY event_descrip
ORDER BY 'Number of Calls' DESC
LIMIT 5;


-- Question3.
-- 	Create an SQL query to report the 5 responding agencies that responded to the largest number of calls
--  over the two dates in the database. Summarize the number of calls by date, and calculate the total. Provide
--  results in descending order (the question is answered below using an Excel Pivot Table). 
-- It is acceptable to submit the results as three tables, one for the total number of calls 
-- on each date and one for the total across the two days. Submit your SQL code and screenshot(s) of your results.

-- Explore how many calls are answered by each agency 
SELECT resp_agency AS Agency, COUNT(resp_agency) AS 'Number of Calls'
FROM calls_911
GROUP BY resp_agency
ORDER BY COUNT(resp_agency) DESC; 


SET SQL_SAFE_UPDATES = 1;