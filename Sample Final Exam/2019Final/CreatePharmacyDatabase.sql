-- create the database
DROP DATABASE IF EXISTS pharmacy;
CREATE DATABASE pharmacy;

-- select the database
USE pharmacy;

-- create the tables
CREATE TABLE patient
(
  PatientID        		INT            		PRIMARY KEY,
  PatientFirstName   	VARCHAR(50),   
  PatientLastName   	VARCHAR(50) 
);

CREATE TABLE medication
(
  MedicationID        		INT            PRIMARY KEY,
  MedicationName   	VARCHAR(50) 
);

CREATE TABLE MedicationAdministrationRegime
(
  AdminRegimeID        		INT            PRIMARY KEY,
  AdminRegimeDescription   	VARCHAR(50) 
);

CREATE TABLE AdminTime
(
  AdminTimeID        		INT            PRIMARY KEY,
  HourOfDay			   		TIME,
  AdminRegimeID				INT,
  CONSTRAINT AdminRegime2_fk_id FOREIGN KEY (AdminRegimeID) REFERENCES MedicationAdministrationRegime (AdminRegimeID)
);

CREATE TABLE Prescription
(
    PrescriptionID        	INT            PRIMARY KEY,
    PatientID        		INT,            		
    MedicationID        	INT,
	AdminRegimeID        	INT,
    StartDate				DATE,
    EndDate					DATE,
	CONSTRAINT patient_fk_id FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    CONSTRAINT medication_fk_id FOREIGN KEY (MedicationID) REFERENCES Medication (MedicationID), 
    CONSTRAINT AdminRegime_fk_id FOREIGN KEY (AdminRegimeID) REFERENCES MedicationAdministrationRegime (AdminRegimeID)
);

CREATE TABLE MedAdminLog
(
    OrderID					INT PRIMARY KEY AUTO_INCREMENT,
    PrescriptionID        	INT,
    ScheduledAdminDay      	DATE,            		
    ScheduledAdminTime      TIME,
	ActualAdminTime        	TIME
);


INSERT INTO Patient VALUES 
(1,'Alice', 'Blue'), 
(2,'Bob', 'Costa'), 
(3,'Charlie', 'Darwin'), 
(4,'Derek', 'Eagle');

INSERT INTO Medication VALUES 
(1,'Tylenol'), 
(2,'Nyquil'), 
(3,'Ibuprofen'), 
(4,'Paracetamol');

INSERT INTO MedicationAdministrationRegime VALUES 
(1,'Morning and Night'), 
(2,'Every 4 hours'), 
(3,'Every 6 hours');

INSERT INTO AdminTime VALUES
(1,'09:00:00',1),
(2,'21:00:00',1),
(3,'12:00:00',2),
(4,'16:00:00',2),
(5,'20:00:00',2),
(6,'00:00:00',2),
(7,'04:00:00',2),
(8,'08:00:00',2),
(9,'08:00:00',3),
(10,'14:00:00',3),
(11,'20:00:00',3),
(12,'02:00:00',3);

INSERT INTO Prescription  VALUES (2,1,1,3, '2019-10-12',  '2019-10-15');
INSERT INTO Prescription  VALUES (3,1,3,2,	'2019-10-13',  '2019-10-16');	
INSERT INTO Prescription  VALUES (4,2,3,1,	'2019-10-14',  '2019-10-16');		
INSERT INTO Prescription  VALUES (5,4,2,2,	'2019-10-10',  '2019-10-11');			

SELECT * FROM prescription;
SELECT * FROM medication;
SELECT * FROM patient;
SELECT * FROM  MedicationAdministrationRegime;
SELECT * FROM AdminTime;

-- Q1

SELECT PatientFirstName, PatientLastName, COUNT(*) AS Num
FROM Patient pat INNER JOIN Prescription pre ON pat.PatientID = pre.PatientID
GROUP BY pat.PatientLastName
ORDER BY pat.PatientLastName ASC;

-- Q2
SELECT PatientLastName, COUNT(*) AS Num
FROM Patient pat LEFT OUTER JOIN Prescription pre ON pat.PatientID = pre.PatientID
GROUP BY pat.PatientLastName
ORDER BY pat.PatientLastName ASC;

-- Q3
SELECT PatientLastName, COUNT(pre.MedicationID) AS Num
FROM Patient pat LEFT OUTER JOIN Prescription pre ON pat.PatientID = pre.PatientID
GROUP BY pat.PatientLastName
ORDER BY pat.PatientLastName ASC;

-- Q5
SELECT HourOfDay, COUNT(*) AS NumRegimes
FROM AdminTime
GROUP BY HourOfDay
HAVING COUNT(*) > 1;

-- Q6
SELECT AVG(x.NumRegimes) AS AvgOfNumRegimes
FROM (SELECT HourOfDay, COUNT(*) AS NumRegimes
FROM AdminTime
GROUP BY HourOfDay 
HAVING COUNT(*) <2 )  AS x;

-- Q7
SELECT COUNT(PatientLastName) AS NumPatientNames
FROM Prescription pre INNER JOIN Patient pat
ON pre.PatientID = pat.PatientID;

-- Q8
SELECT PatientLastName 
FROM Patient pat WHERE NOT EXISTS 
(SELECT * FROM Prescription pre
WHERE pre.PatientID = pat.PatientID);

-- Q9
SELECT PatientLastName, PrescriptionID
FROM Patient pat LEFT OUTER JOIN Prescription pre 
ON pat.PatientID = pre.PatientID
WHERE PrescriptionID IS NULL;

-- Q10
SELECT HourOfDay, PatientLastName, MedicationName
FROM AdminTime at, Patient pat , Medication med, Prescription pre
WHERE 
	at.AdminRegimeID = pre.AdminRegimeID
AND med.MedicationID = pre.MedicationID 
AND pat.PatientID 	 = pre.PatientID
AND pre.StartDate <= '2019-10-12' 
AND pre.EndDate   > '2019-10-12';


-- Q11
INSERT INTO MedAdminLog  (PrescriptionID, ScheduledAdminDay, ScheduledAdminTime)
SELECT PrescriptionID, STR_TO_DATE('10/14/2019', '%m/%d/%Y'),  HourOfDay
FROM AdminTime, Prescription 
WHERE AdminTime.AdminRegimeID = Prescription.AdminRegimeID
AND Prescription.StartDate <= '2019-10-14'
AND Prescription.EndDate > '2019-10-14';

SELECT * FROM MedAdminLog;


-- Q12

DROP VIEW vDaysMedPrescribed;
CREATE VIEW vDaysMedPrescribed AS 
SELECT MedicationID, AdminRegimeID, 
(EndDate-StartDate+1) AS DaysPrescribed
FROM Prescription;

SELECT * FROM vDaysMedPrescribed;

DROP VIEW vRegimeDosesPerDay;
CREATE VIEW vRegimeDosesPerDay AS 
SELECT AdminRegimeID, COUNT(HourOfDay) AS timesPerDay 
FROM AdminTime
GROUP BY AdminRegimeID;

SELECT * FROM vRegimeDosesPerDay;

-- Solution for Q12
CREATE OR REPLACE VIEW vDosesPrescribed AS
SELECT days.*, timesPerDay, DaysPrescribed * timesPerDay AS dosesPrescribed
FROM vDaysMedPrescribed days, vRegimeDosesPerDay doses
WHERE days.AdminRegimeID =  doses.AdminRegimeID;

SELECT * FROM vDosesPrescribed; 

-- Q13
SELECT MedicationName, SUM(dosesPrescribed) AS SumOfDosesPrescribed
FROM Medication LEFT OUTER JOIN vDosesPrescribed 
ON Medication.MedicationID = vDosesPrescribed.MedicationID
GROUP BY MedicationName
ORDER BY MedicationName;




