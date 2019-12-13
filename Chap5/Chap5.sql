-- interative script to allow user to input data
-- to be added to a new row
INSERT INTO Criminals
  VALUES('&Criminal_ID', '&Last', '&First', '&Street', '&City',
            '&State','&Zip', '&Phone', '&v_status', '&p_status');
            
INSERT INTO Criminals
  VALUES('&Criminal_ID', '&Last', '&First', '&Street', '&City',
            '&State','&Zip', '&Phone', '&v_status', '&p_status');
            
INSERT INTO Criminals
  VALUES('&Criminal_ID', '&Last', '&First', '&Street', '&City',
            '&State','&Zip', '&Phone', '&v_status', '&p_status');
            
-- verifying rows have been added
SELECT *
  FROM Criminals;
  
-- adding new column
ALTER TABLE Criminals
  ADD Mail_flag CHAR(1);
  
-- verifying the new column has been added
DESC Criminals;
  
-- setting all criminals to have a value of Y in 
-- Mail_flag field
UPDATE Criminals
  SET Mail_flag = 'Y';
  
-- setting Mail_flag to be N if street column is empty
UPDATE Criminals
  SET Mail_flag = 'N'
  WHERE Street IS NULL;
  
-- changing phone number for criminal 1016
UPDATE Criminals
  SET Phone = 7225659032
  WHERE Criminal_ID = 1016;
  
-- removing criminal 1017
DELETE FROM Criminals
  WHERE Criminal_ID = 1017;
  
  
-- constraint errors 
  
-- status column CHECK constraint will fail
-- status can only be:
  -- CL
  -- CA
  -- IA
INSERT INTO Crimes(crime_id, criminal_id, classification, date_charged, status)
  VALUES(100, 1010, 'M', '15-07-09', 'PD');
  
-- status column CHECK constraint will fail
-- status can only be:
  -- CL
  -- CA
  -- IA
INSERT INTO Crimes(crime_id, criminal_id, classification, date_charged, status)
  VALUES(130, 1016, 'M', '15-07-09', 'PD');
  
-- classification column CHECK constraint will fail
-- classification can only be:
  -- F
  -- M
  -- O
  -- U
INSERT INTO Crimes(crime_id, criminal_id, classification, date_charged, status)
  VALUES(100, 1016, 'P', '15-07-09', 'CL');