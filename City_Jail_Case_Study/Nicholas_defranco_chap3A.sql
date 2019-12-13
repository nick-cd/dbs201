-- Chapter 3A

-- For testing purposes ...

DROP TABLE Aliases;
DROP TABLE Sentences;
DROP TABLE Prob_officers;
DROP TABLE Crime_charges;
DROP TABLE Crime_officers;
DROP TABLE Officers;
DROP TABLE Appeals;
DROP TABLE Crime_codes;
DROP TABLE Crimes;
DROP TABLE Criminals;

-- CREATE TABLE commands with default values specified in chap. 3
-- excludes all constraints (constraints in chapter 4).

CREATE TABLE Criminals
  (Criminal_ID NUMBER(6, 0),
  "Last" VARCHAR(15),
  "First" VARCHAR(10),
  Street VARCHAR(30),
  City VARCHAR(20),
  "State" CHAR(2),
  Zip CHAR(5),
  Phone CHAR(10),
  V_status CHAR(1) DEFAULT 'N',
  P_status CHAR(1) DEFAULT 'N');

CREATE TABLE Aliases
  (Alias_ID NUMBER(6),
  Criminal_ID NUMBER(6, 0),
  "Alias" VARCHAR(10));
  
CREATE TABLE Crimes 
  (Crime_ID NUMBER(9, 0),
  Criminal_ID NUMBER(6, 0),
  Classification CHAR(1),
  Date_charged DATE,
  Status CHAR(2),
  Hearing_date DATE);
  -- Appeal_cut_date -> did not place this coloumn in here as I was not sure
  -- how to create a computed coloumn from an already existing coloumn. This
  -- coloumn is created in the chapter 4 sql file.
  
  
CREATE TABLE Sentences
  (Sentence_ID NUMBER(6),
  Criminal_ID NUMBER(6),
  "Type" CHAR(1),
  Prob_ID NUMBER(5),
  Start_date DATE,
  End_date DATE,
  Violations Number(3));
  
CREATE TABLE Prob_officers
  (Prob_ID NUMBER(5),
  "Last" VARCHAR(15),
  "First" VARCHAR(10),
  Street VARCHAR(30),
  City VARCHAR(20),
  "State" CHAR(2),
  Zip CHAR(5),
  Phone CHAR(10),
  Email VARCHAR(30),
  Status CHAR(1));
  
CREATE TABLE Crime_charges
  (Charge_ID NUMBER(10, 0),
  Crime_ID NUMBER(9, 0),
  Crime_code NUMBER(3, 0),
  Charge_status CHAR(2),
  Fine_amount NUMBER(7, 2),
  Court_fee NUMBER(7, 2),
  Amount_fee NUMBER(7, 2),
  Pay_due_date DATE);
  
CREATE TABLE Crime_officers
  (Crime_ID NUMBER(9, 0),
  Officer_ID NUMBER(8, 0));
  
CREATE TABLE Officers
  (Officer_ID NUMBER(8, 0),
  "Last" VARCHAR(15),
  "First" VARCHAR(10),
  Precinct CHAR(4),
  Badge VARCHAR(14),
  Phone CHAR(10),
  Status CHAR(1) DEFAULT 'A');
  
CREATE TABLE Appeals
  (Appeal_ID NUMBER(5),
  Crime_ID NUMBER(9, 0),
  Filing_date DATE,
  Hearing_date DATE,
  Status CHAR(1) DEFAULT 'P');
  
CREATE TABLE Crime_codes
  (Crime_code NUMBER(3, 0),
  Code_description VARCHAR(30));
  
-- For testing purposes ...

DESC Criminals;
DESC Aliases;
DESC Crimes;
DESC Sentences;
DESC Prob_officers;
DESC Crime_charges;
DESC Crime_officers;
DESC Officers;
DESC Appeals;
DESC Crime_codes;
