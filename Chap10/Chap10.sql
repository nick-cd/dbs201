-- 400

-- 1

SELECT Crime_ID, Classification, Date_charged, Hearing_date, 
    (Hearing_date - Date_charged)
  FROM Crimes
  WHERE (Hearing_date - Date_charged) > 14;
  
-- 2

SELECT SUBSTR(Precinct, 2, 1) "Second Letter of Precinct Code", Precinct
  FROM Officers
  WHERE Status = 'A'
  ORDER BY "Second Letter of Precinct Code";
  
-- 3

SELECT Criminal_ID, UPPER(Last || ' ' || First) "Name", Sentence_ID,
    TO_CHAR(Start_date, 'MONTH DD, YYYY'), 
    ABS(ROUND(MONTHS_BETWEEN(Start_date, End_date)))
  FROM Criminals c JOIN Sentences s USING(Criminal_ID)
  ORDER BY Sentence_ID;
  
--4
SELECT Last || ' ' || First "Name", Charge_ID, 
    TO_CHAR((Fine_amount + Court_fee), '$9999.99') "Total Amount Owed", 
    TO_CHAR(NVL(Amount_paid, 0), '$990.99') "Amount Paid", 
    TO_CHAR(((Fine_amount + Court_fee) - NVL(Amount_paid, 0)), 
    '$9990.99') "Amount Owed", Pay_due_date
  FROM Criminals JOIN Crimes USING(Criminal_ID) 
    JOIN Crime_charges USING(Crime_ID)
  WHERE ((Fine_amount + Court_fee) - NVL(Amount_paid, 0)) > 0;
  
-- 5
SELECT Last || ' ' || First "Name", Start_date, 
    ADD_MONTHS(Start_date, 2) "Review Date"
  FROM Criminals JOIN Sentences USING(Criminal_ID)
  WHERE ABS(MONTHS_BETWEEN(Start_date, End_date)) > 2
    AND Type = 'P';
    
-- 6

INSERT INTO Appeals
  VALUES(APPEALS_ID_SEQ.NEXTVAL, &crime_id, TO_DATE('&filing_date', 'MM DD YYYY'),
    TO_DATE('&hearing_date', 'MM DD YYYY'), DEFAULT);
    

    