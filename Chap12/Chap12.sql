-- 494

-- 1
              
SELECT first || ' ' || last "Name", o.Officer_ID, SUM
  FROM Officers o, (SELECT Officer_ID, COUNT(Crime_ID) SUM
                      FROM Crime_officers
                      GROUP BY Officer_ID
                      HAVING COUNT(Crime_ID) > (SELECT AVG(COUNT(Crime_ID))
                                                  FROM Crime_officers
                                                  GROUP BY Officer_ID)) co
  WHERE o.Officer_ID = co.Officer_ID;
              
                      
-- 2
SELECT first || ' ' || last "Name", Criminal_ID, SUM
  FROM Criminals JOIN (SELECT Criminal_ID, COUNT(Crime_ID) SUM
                        FROM Crimes
                        GROUP BY Criminal_ID
                        HAVING COUNT(Crime_ID) < (SELECT AVG(COUNT(Crime_ID))
                                                    FROM Crimes
                                                    GROUP BY Criminal_ID)) USING(Criminal_ID)
  WHERE V_Status = 'N';
                              
-- 3
SELECT Appeal_ID, Crime_id, Hearing_date, Filing_date,
    (Hearing_date - Filing_date) "Days difference", Status
  FROM Appeals
  WHERE hearing_date - filing_date < (SELECT AVG(hearing_date - filing_date)
                                        FROM Appeals);

-- 4
SELECT first || ' ' || last "Name"
  FROM Prob_officers p, (SELECT Prob_ID, COUNT(Criminal_ID)
                        FROM Sentences
                        WHERE Type = 'P'
                        GROUP BY Prob_ID
                        HAVING COUNT(Criminal_ID) < (SELECT AVG(COUNT(Criminal_ID))
                                                      FROM Sentences
                                                      GROUP BY Prob_ID)) s
  WHERE p.Prob_ID = s.Prob_ID;
                                
-- 5

SELECT Crime_ID
  FROM Crimes JOIN Appeals USING(Crime_ID)
  GROUP BY Crime_ID
  HAVING COUNT(Appeal_ID) = (SELECT MAX(COUNT(Appeal_ID))
                              FROM Appeals
                              GROUP BY Crime_ID);
  
-- 6

SELECT *
  FROM Crime_Charges
  WHERE (NVL(Amount_paid, 0)) < (SELECT AVG((NVL(Amount_paid, 0)))
                                      FROM Crime_Charges)
    AND NVL(fine_amount, 0) > (SELECT AVG((NVL(fine_amount, 0)))
                              FROM Crime_charges);
  
-- 7
-- in case criminal was involved in more than one recorded crime, distinct will
-- ensure that that criminal will only be mentioned once.
SELECT DISTINCT Criminal_ID, first || ' ' || last "Name" 
  FROM Criminals JOIN Crimes USING(Criminal_ID) 
    JOIN Crime_charges USING(Crime_ID)
  WHERE Crime_code IN (SELECT Crime_code
                        FROM Crime_charges
                        WHERE Crime_ID = 10089)
  ORDER BY Criminal_ID;

-- 8
SELECT first || ' ' || last "Name"
  FROM Criminals
  WHERE EXISTS (SELECT Criminal_ID
                  FROM Sentences
                  WHERE Type = 'P'
                    AND Criminals.Criminal_ID = Sentences.Criminal_ID);

               
-- 9
SELECT first || ' ' || last "Name"
  FROM Officers o1, (SELECT Officer_ID
                      FROM Crime_officers
                      GROUP BY Officer_ID
                      HAVING COUNT(Crime_ID) = (SELECT MAX(COUNT(Crime_ID))
                                                  FROM Crime_officers
                                                  GROUP BY Officer_ID)) o2
  WHERE o1.Officer_ID = o2.Officer_ID;

  
-- 10
MERGE INTO Criminals_dw c1
  USING Criminals c2
    ON(c1.Criminal_ID = c2.Criminal_ID)
  WHEN MATCHED THEN
    UPDATE SET c1.Last = c2.Last, c1.First = c2.First, 
      c1.Street = c2.Street, c1.City = c2.City,
      c1.State = c2.State, c1.Zip = c2.Zip, c1.Phone = c2.Phone,
      c1.V_status = c2.V_status, c1.P_status = c2.P_status;