DESC crimes;

-- 1
SELECT *
  FROM aliases
  WHERE alias LIKE 'B%';
  
SELECT * FROM crimes;
  
-- 2
SELECT crime_id, criminal_id, date_charged, classification
  FROM crimes
  WHERE date_charged BETWEEN '30-09-08' AND '01-11-08';
    
-- 3
SELECT crime_id, criminal_id, date_charged, status
  FROM crimes
  WHERE status IN ('CA', 'IA');
  
-- 4
SELECT crime_id, criminal_id, date_charged, classification
  FROM crimes
  WHERE classification = 'F';
  
-- 5
SELECT crime_id, criminal_id, date_charged, hearing_date
  FROM crimes
  WHERE date_charged + 14 < hearing_date;

-- 6
SELECT criminal_id, last, zip
  FROM criminals
  WHERE zip = 23510
  ORDER BY criminal_id;

-- 7
SELECT crime_id, criminal_id, date_charged, hearing_date
  FROM crimes
  WHERE hearing_date IS NULL;
  
-- 8
SELECT sentence_id, criminal_id, prob_id
  FROM sentences
  WHERE prob_id IS NOT NULL
  ORDER BY prob_id, criminal_id;
  
-- 9
SELECT crime_id, criminal_id, classification, status
  FROM crimes
  WHERE classification = 'M' 
    AND Status = 'IA';
    
-- 10
SELECT charge_id, crime_id, fine_amount, court_fee, 
    amount_paid, (court_fee - amount_paid) AS amount_owed
  FROM crime_charges
  WHERE court_fee - amount_paid > 0;
  
-- 11
SELECT officer_id, last, precinct, status
  FROM officers
  WHERE precinct IN('OCVW', 'GHNT') AND status = 'A'
  ORDER BY precinct, last;
  