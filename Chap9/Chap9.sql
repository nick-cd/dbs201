--pg 346

-- 1

SELECT c.Criminal_ID, c.First || ' ' || c.Last "Name", 
    ch.Fine_amount, ch.Crime_code
  FROM Criminals c, Crime_charges ch, Crimes cr
  WHERE c.Criminal_ID = cr.Criminal_ID
    AND cr.Crime_ID = ch.Crime_ID;
    
SELECT Criminal_ID, c.First || ' ' || c.Last "Name", 
    ch.Fine_amount, ch.Crime_code
  FROM Criminals c JOIN Crimes cr USING(Criminal_ID) 
    JOIN Crime_charges ch USING(Crime_ID);
    
    
-- 2
  

SELECT c.Criminal_ID, c.First || ' ' || c.Last "Name",
    cr.Classification, cr.Status, cr.Date_charged, 
    a.Filing_date, a.Status
  FROM Criminals c, Crimes cr, Appeals a
  WHERE c.Criminal_ID = cr.Criminal_ID
    AND cr.Crime_ID = a.Crime_ID(+); -- Outer join!
    
SELECT Criminal_ID, c.First || ' ' || c.Last "Name",
    cr.Classification, cr.Status, cr.Date_charged,
    a.Filing_date, a.Status
  FROM Criminals c JOIN Crimes cr USING(Criminal_ID)
    LEFT OUTER JOIN Appeals a
      ON cr.Crime_ID = a.Crime_ID;
    
-- 3

SELECT c.Criminal_ID, c.First || ' ' || c.Last "Name",
    cr.Classification, cr.Date_charged, ch.Crime_Code, 
    ch.Fine_amount
  FROM Criminals c, Crimes cr, Crime_charges ch
  WHERE cr.Classification = 'O'
    AND c.Criminal_ID = cr.Criminal_ID 
    AND cr.Crime_ID = ch.Crime_ID
  ORDER BY c.Criminal_ID, cr.Date_Charged;
  
  
SELECT Criminal_ID, c.First || ' ' || c.Last "Name",
    cr.Classification, cr.Date_charged, ch.Crime_Code, 
    ch.Fine_amount
  FROM criminals c JOIN Crimes cr USING(Criminal_ID)
    JOIN Crime_charges ch USING(Crime_ID)
  WHERE cr.Classification = 'O'
  ORDER BY Criminal_ID, cr.Date_Charged;
  
  
-- 4
SELECT c.Criminal_ID, c.First || ' ' || c.Last "Name",
    c.V_status, c.P_status, a.Alias
  FROM Criminals c, Aliases a
  WHERE c.Criminal_ID = a.Criminal_ID(+)
  ORDER BY "Name";
  
SELECT Criminal_ID, First || ' ' || Last "Name",
    V_status, P_status, a.Alias
  FROM Criminals c LEFT OUTER JOIN Aliases a 
    USING(Criminal_ID)   
  ORDER BY "Name";                  
  
  
-- 5

SELECT c.First || ' ' || c.Last "Name", 
    s.Start_date, s.End_date, p.Con_freq
  FROM Criminals c, Sentences s, Prob_contact p
  WHERE c.Criminal_ID = s.Criminal_ID
    AND ABS(s.End_date - s.Start_date) BETWEEN p.Low_amt AND p.High_amt
    AND s.Type = 'P'
  ORDER BY "Name", s.Start_date;
    
    
SELECT c.First || ' ' || c.Last "Name", 
    s.Start_date, s.End_date, p.Con_freq
  FROM Criminals c JOIN Sentences s USING(Criminal_ID)
    JOIN Prob_contact p ON ABS(s.End_date - s.Start_date) 
      BETWEEN p.Low_amt AND p.High_amt
  WHERE s.Type = 'P'
  ORDER BY "Name", s.Start_date;
  
-- 6
-- Self join!
  
SELECT p.First || ' ' || p.Last "Name", 
    s.First || ' ' || s.Last "Supervisor Name"
  FROM Prob_officers p, Prob_officers s
  WHERE s.Prob_ID = p.Mgr_ID;


SELECT p.First || ' ' || p.Last "Name", 
    s.First || ' ' || s.Last "Supervisor Name"
  FROM Prob_officers p JOIN Prob_officers s
    ON s.Prob_ID = p.Mgr_ID;
    
