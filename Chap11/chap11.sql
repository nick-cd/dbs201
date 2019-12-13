-- 447

-- 1
SELECT AVG(COUNT(Crime_ID))
  FROM Crime_officers
  GROUP BY Officer_ID;

-- 2
SELECT status, COUNT(Crime_ID) "Amount"
  FROM crimes
  GROUP BY status;
  
-- 3
SELECT MAX(COUNT(Crime_ID)) "Max"
  FROM Crimes
  GROUP BY Criminal_ID;

-- 4
SELECT MIN(Fine_amount) "Lowest amount"
  FROM Crime_charges;
  
SELECT *
  FROM Crime_Charges;
  
-- 5
SELECT c.Criminal_ID, first || ' ' || last "Name", Amount
  FROM Criminals c, (SELECT Criminal_ID, COUNT(Criminal_ID) Amount
                        FROM Sentences
                        GROUP BY Criminal_ID
                        HAVING COUNT(Criminal_ID) > 1) s
  WHERE c.Criminal_ID = s.Criminal_ID;
  
  
SELECT *
  FROM Sentences;

-- 6

SELECT Precinct, COUNT(Charge_status) 
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
    JOIN Crime_officers USING(Crime_ID)
    JOIN Officers USING(Officer_ID)
  WHERE Charge_status = 'GL'
  GROUP BY Precinct
  HAVING COUNT(Charge_status) >= 7;
  
SELECT *
  FROM Crime_Charges;

-- 7

SELECT Classification, 
    SUM(NVL(Fine_amount, 0) + NVL(Court_fee, 0)) "Total Collections", 
    SUM(NVL(Fine_amount, 0) + NVL(Court_fee, 0) - NVL(Amount_paid, 0)) "Total Amount Owed"
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
  GROUP BY Classification;
  
  
  
SELECT *
  FROM Crime_charges;
  
SELECT *
  FROM Crimes;
  
-- 9
-- lists total num of charges by classification 
-- AND charge status with grand total
SELECT Classification, Charge_status, COUNT(Charge_ID)
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
  GROUP BY GROUPING SETS((Classification, Charge_status), ());
--                   Groups by Classification AND Charge_status
  
-- 10
-- subtotal for status and classification with a grand total
SELECT Charge_status, Classification, COUNT(Charge_ID)
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
  GROUP BY CUBE(Charge_status, Classification)
  ORDER BY Charge_status;
  
SELECT Classification, Charge_status, COUNT(Charge_ID)
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
  GROUP BY ROLLUP(Classification, Charge_status);
  
-- 11
-- subtotal of classification

SELECT Classification, Charge_status, COUNT(Charge_ID)
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
  GROUP BY CUBE(classification), Charge_status
  ORDER BY Classification;
  
-- partial rollup
SELECT Classification, Charge_status, COUNT(Charge_ID)
  FROM Crime_charges JOIN Crimes USING(Crime_ID)
  GROUP BY ROLLUP(Classification), Charge_status;