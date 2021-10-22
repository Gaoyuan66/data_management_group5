-- DISTINCT can be omitted since empID is PK
SELECT 
  COUNT(DISTINCT empID) AS num_of_employee 
FROM employee
;


DESC employee;


SELECT 
  COUNT(DISTINCT empSurname) AS unique_surname
FROM employee
;


-- INSTR function is an alternative
SELECT *
FROM employee
WHERE empSurname LIKE "%chi%"
;

DESC move;


-- Regard "No Reason"(NULL) as the top reason
SELECT 
  reasonForDelay, 
  COUNT(*) AS num
FROM move
GROUP BY reasonForDelay
ORDER BY num DESC
LIMIT 5
;

DESC employee;

SELECT 
  moveEmp.empID,
  empFirstName,
  empSurname,
  COUNT(*) AS num_of_moves
FROM moveEmp 
LEFT JOIN employee
ON moveEmp.empID=employee.empID
GROUP BY moveEmp.empID
ORDER BY num_of_moves DESC
LIMIT 5
;

SELECT 
  move.moveID,
  empID
FROM move
INNER JOIN moveEmp 
ON move.moveID = moveEmp.moveID
WHERE reasonForDelay = "CHANGED TO BED 2TA"
AND tPortTypeId = "STRETCHER"
;

SELECT 
  move.moveID,
  empID
FROM move
INNER JOIN moveEmp 
ON move.moveID = moveEmp.moveID
WHERE move.moveID= 2638253;

SELECT COUNT(*)
FROM move
WHERE UPPER(toUnitID) = "ED XRAY NORTH"
AND UPPER(fromUnitID) = "ED";
DESC tportType;

CREATE OR REPLACE VIEW edMove AS
SELECT 
  move.*
FROM move
LEFT JOIN tportType
ON move.tportTypeID = tportType.tportTypeID
WHERE reqUrgent = 0
AND equipType = "STRETCHER" 
AND ((toUnitID = "ED XRAY NORTH" AND UPPER(fromUnitID) = "ED")
OR (toUnitID = "ED" AND UPPER(fromUnitID) = "ED XRAY NORTH"))
;
SELECT COUNT(*) 
FROM edMOVE
;

CREATE OR REPLACE VIEW edMove AS
SELECT 
  move.*,
  WEEKDAY(reqTime) AS reqDOW,
  TIMESTAMPDIFF(MINUTE, dispatchTime, completionTime) AS moveDur
FROM move
LEFT JOIN tportType
ON move.tportTypeID = tportType.tportTypeID
WHERE reqUrgent = 0
AND equipType = "STRETCHER" 
AND ((toUnitID = "ED XRAY NORTH" AND UPPER(fromUnitID) = "ED")
OR (toUnitID = "ED" AND UPPER(fromUnitID) = "ED XRAY NORTH"))
;
SELECT moveID, reqTime, reqDOW, moveDur
FROM edMove
ORDER BY reqTime;


SELECT 
  reqDOW,
  AVG(moveDur) AS average_time
FROM edMove
GROUP BY reqDOW
ORDER BY reqDOW
;


-- Although question does not specify,
-- I use edMove to make the results relevant to following question
SELECT 
  reqDOW,
  COUNT(DISTINCT empID)/COUNT(DISTINCT CAST(reqTime AS DATE)) avg_num_of_employee
FROM edMove
LEFT JOIN moveEmp 
ON edMove.moveID = moveEmp.moveID
WHERE edMove.dispatchTime < "2021-07-24" -- up to 07-23
GROUP BY reqDOW
ORDER BY reqDOW
;

SELECT 
  reqDOW,
  COUNT(DISTINCT empID)/COUNT(DISTINCT CAST(reqTime AS DATE)) avg_num_of_employee,
  COUNT(DISTINCT patID)/COUNT(DISTINCT CAST(reqTime AS DATE)) avg_num_of_patient,
  COUNT(DISTINCT edMove.moveID)/COUNT(DISTINCT CAST(reqTime AS DATE)) avg_num_of_move
FROM edMove
LEFT JOIN moveEmp 
ON edMove.moveID = moveEmp.moveID
WHERE edMove.dispatchTime < "2021-07-24" -- up to 07-23
GROUP BY reqDOW
ORDER BY reqDOW
;



