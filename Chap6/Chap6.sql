-- for testing ...

SELECT *
  FROM crimes;
  
SELECT *
  FROM criminals;
  
DESC crimes;
DESC criminals;

DROP SEQUENCE criminals_criminal_id_seq;
DROP SEQUENCE crimes_crime_id_seq;

DELETE crimes
  WHERE crime_id = 1;

--------------------------------------------

-- criminal id sequence
CREATE SEQUENCE criminals_criminal_id_seq
  INCREMENT BY 1
  START WITH 1017
  NOCACHE
  NOCYCLE;
  
-- crime id sequence
CREATE SEQUENCE crimes_crime_id_seq
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOCYCLE;

-- set sequence as default for criminal_id column in criminals table
ALTER TABLE criminals
  MODIFY (criminal_id DEFAULT 
    criminals_criminal_id_seq.NEXTVAL);
    
-- set sequence as default for crime_id column in crimes table
ALTER TABLE crimes
  MODIFY (crime_id DEFAULT
    crimes_crime_id_seq.NEXTVAL);
    
    
-- insertions to test sequences
INSERT INTO criminals
  VALUES(DEFAULT, 'Capps', 'Johnny', '123 main', 
    'Toronto', 'ON', '44504', '9054443333', DEFAULT,
      DEFAULT, 'Y');
      
INSERT INTO crimes
  VALUES(DEFAULT, criminals_criminal_id_seq.CURRVAL,
    'F', SYSDATE, 'CL', NULL, NULL, DEFAULT);
    
-- 2
/*
Each of these columns will have a large amount of distinct
values. For this reason, I have decided to use a B-Tree Index.
*/

CREATE INDEX criminals_last_idx
  ON criminals(last);
  
CREATE INDEX criminals_street_idx
  ON criminals(street);
  
CREATE INDEX criminals_phone_idx
  ON criminals(phone);

/*
  
-- 3 - bitmap index
bitmap indexes are generally used with coloumns that
have a small amount of distinct values

I belive this can be especially useful with columns storing the data
with the CHAR data type with a check constraint. These coloumns are
forced to have only one of a few, very specific values.

These columns include:

in criminals table
--> state
--> v_status
--> p_status

crimes table
--> classification
--> status

-- 4

I believe the city jail database would be easier to use with 
synonyms. This is because with synonyms, I am able to simplfy 
my names for my tables making them easier to remember as I am 
able to reference the same table with a dirrent but simpler name. 
Futhermore, a synonym can be used as an object for which we can 
substitute whatever object we wish into it. This allows users 
to reuse sql code as if the same logic is required on many 
objects, they would only need to change what object the 
synonym references.
    
*/
