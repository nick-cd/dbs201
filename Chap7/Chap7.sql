-- CHAPTER 7 pg 254

/*
Please look at word document sent with sql script for descriptions
*/
  
-- Every department will have their own role that will be assigned
-- to all employees in that department

-- Criminal Records role creation
CREATE ROLE criminal_records;

GRANT SELECT, INSERT, UPDATE
  ON criminals
  TO criminal_records;

GRANT SELECT, INSERT, UPDATE
  ON officers
  TO criminal_records;
  
GRANT SELECT, INSERT, UPDATE
  ON crime_charges
  TO criminal_records;
    
GRANT SELECT, UPDATE
  ON crime_codes
  TO criminal_records;
  
-----------------------------------
-- court recording role creation
CREATE ROLE court_recording;

GRANT SELECT, INSERT, UPDATE
  ON appeals
  TO court_recording;
  
GRANT SELECT,
      UPDATE(appeal_cut_date)
  ON crimes
  TO court_recording;
  
GRANT SELECT,
      UPDATE(p_status)
  ON criminals
  TO court_recording;
  
GRANT SELECT, INSERT, UPDATE
  ON prob_officers
  TO court_recording;

-----------------------------------
-- crimes analysis role creation
CREATE ROLE crimes_analysis;

GRANT SELECT
  ON criminals
  TO crimes_analysis;
  
GRANT SELECT
  ON aliases
  TO crimes_analysis;
  
GRANT SELECT
  ON crime_charges
  TO crime_analysis;
  
GRANT SELECT
  ON crime_codes
  TO crime_analysis;
  
GRANT SELECT
  ON crimes
  TO crime_analysis;

-----------------------------------
-- data officer role creation
CREATE ROLE data_officer;

GRANT DELETE 
  ON crimes
  TO data_officers;
  
GRANT DELETE 
  ON sentences
  TO data_officers;
  
GRANT DELETE
  ON appeals
  TO data_officers;
  
GRANT DELETE
  ON crime_charges
  TO data_officers;
  
GRANT DELETE
  ON prob_officers
  TO data_officers;
  
-----------------------------------