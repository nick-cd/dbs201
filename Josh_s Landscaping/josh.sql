DROP TABLE Customer CASCADE CONSTRAINTS;

DROP TABLE Invoice CASCADE CONSTRAINTS;
DROP TABLE Services CASCADE CONSTRAINTS;
DROP TABLE Service_Invoice CASCADE CONSTRAINTS;
DROP TABLE Employees CASCADE CONSTRAINTS;
DROP TABLE Team CASCADE CONSTRAINTS;
DROP TABLE Positions CASCADE CONSTRAINTS;
DROP TABLE Skill_Codes CASCADE CONSTRAINTS;
DROP TABLE Skills CASCADE CONSTRAINTS;
DROP TABLE Equipment CASCADE CONSTRAINTS;
DROP TABLE Equipment_Service CASCADE CONSTRAINTS;

DROP TABLE Sales_Assistant CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Classification CASCADE CONSTRAINTS;
DROP TABLE Suppliers CASCADE CONSTRAINTS;
DROP TABLE Item CASCADE CONSTRAINTS;
DROP TABLE Order_Item CASCADE CONSTRAINTS;

DROP VIEW Inventory_Report;
DROP VIEW Invoice_Statment;
DROP VIEW Team_List;
DROP VIEW Product_Sales_Report;
DROP VIEW Product_Report;


-- Customer table creation
CREATE TABLE Customer 
  (Customer_ID NUMBER(6, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Firstname VARCHAR(10) NOT NULL,
  Lastname VARCHAR(15) NOT NULL,
  Street VARCHAR(30),
  Postal_code CHAR(6),
  Phone_num CHAR(10) NOT NULL,
  City VARCHAR(20),
  Province CHAR(2),
  Email VARCHAR(35),
  Zip CHAR(5));
  
ALTER TABLE Customer
  ADD CONSTRAINT customer_province_ck 
    CHECK (Province IN('ON', 'QC', 'NS', 'NB', 'MB', 'BC', 
      'PE', 'SK', 'AB', 'NL'));

-----------------------------------------------------------
-- Service portion

-- Services table creation
CREATE TABLE Services
  (Service_Code CHAR(2),
  Description VARCHAR(20) NOT NULL,
  Hourly_Charge NUMBER(4,2) NOT NULL,
    CONSTRAINT services_service_code_pk PRIMARY KEY(Service_Code)); 
    
-- Invoice table creation
CREATE TABLE Invoice 
  (Invoice_ID NUMBER(6, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Customer_ID NUMBER(6, 0) NOT NULL,
  Team_ID NUMBER(6, 0) NOT NULL,
  Invoice_date DATE DEFAULT SYSDATE NOT NULL);
-- Invoice table alterations
ALTER TABLE Invoice
  ADD CONSTRAINT invoice_customer_id_fk FOREIGN KEY(Customer_ID)
    REFERENCES Customer (Customer_ID);

CREATE TABLE Service_Invoice
  (Invoice_ID NUMBER(6, 0) NOT NULL,
  Service_Code CHAR(2) NOT NULL,
  Work_Duration NUMBER(4, 2) NOT NULL,
    CONSTRAINT service_invoice_id_fk FOREIGN KEY(Invoice_ID)
      REFERENCES Invoice(Invoice_ID),
    CONSTRAINT service_invoice_code_fk FOREIGN KEY(Service_Code)
      REFERENCES Services(Service_Code));
  
-- Equipment table creation
CREATE TABLE Equipment
  (Equip_ID NUMBER(4, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Description VARCHAR(30) NOT NULL,
  Amount NUMBER(3, 0) NOT NULL);
    
-- Equipment/Service table creation
CREATE TABLE Equipment_Service
  (Service_Code CHAR(2) NOT NULL,
  Equip_ID NUMBER(4, 0) NOT NULL,
    CONSTRAINT equipment_service_code_fk FOREIGN KEY(Service_Code)
      REFERENCES Services (Service_Code),
    CONSTRAINT equipment_service_equip_id_fk FOREIGN KEY(Equip_ID)
      REFERENCES Equipment(Equip_ID));
      


-- Team table creation
CREATE TABLE Team
  (Team_ID NUMBER(6, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Description VARCHAR(25) NOT NULL);
    
-- Invoice alteration
ALTER TABLE Invoice
  ADD CONSTRAINT invoice_team_id_fk FOREIGN KEY(Team_ID)
    REFERENCES Team(Team_ID);
    
-- positions table creation
CREATE TABLE Positions
  (Code CHAR(2),
  Description VARCHAR(20) NOT NULL,
    CONSTRAINT positions_code_pk PRIMARY KEY(Code));

-- employees table creation
CREATE TABLE Employees
  (OHIP VARCHAR(9) NOT NULL UNIQUE,
  Firstname VARCHAR(10) NOT NULL,
  Lastname VARCHAR(15) NOT NULL,
  Team_ID NUMBER(2) NOT NULL,
  Position_Code CHAR(2) NOT NULL,
  Emp_ID NUMBER(4) GENERATED AS IDENTITY PRIMARY KEY,
  Phone_Number CHAR(10) NOT NULL,
  Start_Date DATE DEFAULT SYSDATE,
    CONSTRAINT employees_position_code_fk FOREIGN KEY(Position_Code)
      REFERENCES Positions(Code),
    CONSTRAINT employees_team_id_fk FOREIGN KEY(Team_ID)
      REFERENCES Team(Team_ID));
      


-- skill codes table creation
CREATE TABLE Skill_Codes
  (Code CHAR(3),
  Description VARCHAR(20) NOT NULL,
    CONSTRAINT skill_codes_code_pk PRIMARY KEY(Code));
    
-- skills table creation
CREATE TABLE Skills
  (Emp_ID NUMBER(4) NOT NULL,
  Skill_code CHAR(3) NOT NULL,
    CONSTRAINT skills_emp_id_fk FOREIGN KEY(Emp_ID)
      REFERENCES Employees(Emp_ID),
    CONSTRAINT skills_skill_code_fk FOREIGN KEY(Skill_code)
      REFERENCES Skill_Codes(Code));
      
      
---------------------------------------------------------------
-- Store Portion

-- sales assistant creation
CREATE TABLE Sales_Assistant
  (Sales_Assistant_ID NUMBER(6, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Firstname VARCHAR(15) NOT NULL,
  Lastname VARCHAR(15) NOT NULL);

-- order table creation
CREATE TABLE Orders
  (Order_ID NUMBER(6, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Order_date DATE NOT NULL,
  Customer_ID NUMBER(6, 0) NOT NULL,
  Sales_Assistant_ID NUMBER(6, 0) NOT NULL,
    CONSTRAINT order_customer_id_fk FOREIGN KEY(Customer_ID)
      REFERENCES Customer(Customer_ID),
    CONSTRAINT order_sales_assistant_id_fk FOREIGN KEY(Sales_Assistant_ID)
      REFERENCES Sales_Assistant(Sales_Assistant_ID));

ALTER TABLE Orders
  MODIFY Order_date DEFAULT SYSDATE;

-- classification table creation
CREATE TABLE Classification
  (Code CHAR(2),
  Description VARCHAR(20) NOT NULL,
  Markup NUMBER(4, 2) NOT NULL,
    CONSTRAINT classification_code_pk PRIMARY KEY(Code));
    
-- Supplier table creation
CREATE TABLE Suppliers
  (Supplier_ID NUMBER(2) GENERATED AS IDENTITY PRIMARY KEY,
  Description VARCHAR(30) NOT NULL);
    
-- item table creation
CREATE TABLE Item 
  (Item_ID NUMBER(3, 0) GENERATED AS IDENTITY PRIMARY KEY,
  Description VARCHAR(25) NOT NULL,
  Aisle NUMBER(2, 0) NOT NULL,
  Supplier_ID NUMBER(2) NOT NULL,
  Stock NUMBER(2, 0) NOT NULL,
  Classification_Code CHAR(2) NOT NULL,
  Cost NUMBER(5, 2) NOT NULL,
    CONSTRAINT item_classification_code_fk FOREIGN KEY(Classification_Code)
      REFERENCES Classification(Code),
    CONSTRAINT item_supplier_id_fk FOREIGN KEY(Supplier_ID)
      REFERENCES Suppliers(Supplier_ID),
    CONSTRAINT item_aisle_ck CHECK (Aisle BETWEEN 1 AND 20));
      
-- Order/Item table creation
CREATE TABLE Order_Item
  (Order_ID NUMBER(6, 0) NOT NULL,
  Item_ID NUMBER(6, 0) NOT NULL,
  Amt_Ordered NUMBER(2, 0) NOT NULL,
  Quoted_price NUMBER(4, 2) NOT NULL,
    CONSTRAINT order_item_order_id_fk FOREIGN KEY(Order_ID)
      REFERENCES Orders(Order_ID),
    CONSTRAINT order_item_item_id_fk FOREIGN KEY(Item_ID)
      REFERENCES Item(Item_ID));

-------------------------------------------
-- generic service info
-- Code, Description, price
INSERT INTO Services
  VALUES('LC', 'Lawn Cutting', 25.00);
  
INSERT INTO Services
  VALUES('LW', 'Lawn Weeding', 35.00);
  
INSERT INTO Services
  VALUES('LF', 'Lawn Fertilizing', 15.00);
  
INSERT INTO Services
  VALUES('TG', 'Tree Pruning', 45.00);
  
INSERT INTO Services
  VALUES('GW', 'Garden Weeding', 25.00);
  
INSERT INTO Services
  VALUES('GP', 'Garden Planting', 30.00);
  
INSERT INTO Services
  VALUES('GF', 'Garden Fertilizing', 10.00);

-- Equipment insertions
-- ID, Description, amount
INSERT INTO Equipment
  VALUES(DEFAULT, '20 hp John Deer tractor/mower', 5); -- ID #1
  
INSERT INTO Equipment
  VALUES(DEFAULT, '2 hp Johnson grass trimmer', 4); -- ID #2
  
INSERT INTO Equipment
  VALUES(DEFAULT, 'Haggmann garden-tiller', 6); -- ID #3
  
INSERT INTO Equipment
  VALUES(DEFAULT, '10" tree pruning shears', 9); -- ID #4
  
-- equipment per service
-- Service_Code, Equipment_ID
INSERT INTO Equipment_Service
  VALUES('LC', 1);
  
INSERT INTO Equipment_Service
  VALUES('LC', 2);
  
INSERT INTO Equipment_Service
  VALUES('LW', 4);
  
INSERT INTO Equipment_Service
  VALUES('TG', 4);

INSERT INTO Equipment_Service
  VALUES('GW', 4);
  
INSERT INTO Equipment_Service
  VALUES('GP', 3);

-- team creations
-- Team_ID, Description
INSERT INTO Team
  VALUES(DEFAULT, 'General Contracting');
  
INSERT INTO Team
  VALUES(DEFAULT, 'Pruning and Planting');
  
INSERT INTO Team
  VALUES(DEFAULT, 'General Maintenance');
  
  
-- position creations
-- Code, Description
INSERT INTO Positions
  VALUES('SU', 'Supervisor');

-- Code, Description
INSERT INTO Positions
  VALUES('LC', 'LAWN CARE');

-- Employee inserts
-- OHIP, first, last, team_ID, Position_Code, Emp_ID, Phone, Date started
INSERT INTO Employees
  VALUES('219032002', 'Cindy', 'Lee', 1, 'SU', 
    DEFAULT, '9053381234', '1-Jan-07');
    
INSERT INTO Employees
  VALUES('34111991', 'Amy', 'Smith', 1, 'LC', 
    DEFAULT, '9053381234', '30-Jun-01');
    
INSERT INTO Employees
  VALUES('325443001', 'Paula', 'Corelli', 2, 'LC',
    DEFAULT, '4164584562', '30-Jun-02');
    
INSERT INTO Employees
  VALUES('54222991', 'Paul', 'Huang', 2, 'SU',
    DEFAULT, '4169324533', '30-Jun-05');
    
INSERT INTO Employees
  VALUES('43524532', 'Maria', 'Wong', 3, 'LC',
    DEFAULT, '9053455366', '23-Aug-03');
    
INSERT INTO Employees
  VALUES('32543555', 'Phil', 'Ramirez', 3, 'SU',
    DEFAULT, '4164356599', '3-Mar-17');
    
-- Skill code creation
-- Code, Description
INSERT INTO Skill_Codes
  VALUES('EL', 'Electrical');
  
INSERT INTO Skill_Codes
  VALUES('PL', 'Plumbing');
  
INSERT INTO Skill_Codes
  VALUES('GC', 'General Contracter');
  
INSERT INTO Skill_Codes
  VALUES('IR', 'Irrigation');
  
INSERT INTO Skill_Codes
  VALUES('LM', 'Lawn Maintenance');
  
INSERT INTO Skill_Codes
  VALUES('PR', 'Pruning');
  
INSERT INTO Skill_Codes
  VALUES('FR', 'Fertilizing');
  
INSERT INTO Skill_Codes
  VALUES('AL', '"A" License');
  

-- Assigning skill codes to employees
-- Emp_ID, Skill_Code
INSERT INTO Skills
  VALUES(1, 'EL');
  
INSERT INTO Skills
  VALUES(1, 'PL');
  
INSERT INTO Skills
  VALUES(1, 'GC');
  
INSERT INTO Skills
  VALUES(2, 'IR');
  
INSERT INTO Skills
  VALUES(2, 'LM');
  
INSERT INTO Skills
  VALUES(3, 'PR');
  
INSERT INTO Skills
  VALUES(3, 'IR');
  
INSERT INTO Skills
  VALUES(3, 'FR');
  
INSERT INTO Skills
  VALUES(4, 'AL');
  
INSERT INTO Skills
  VALUES(4, 'EL');
  
INSERT INTO Skills
  VALUES(4, 'GC');
  
INSERT INTO Skills
  VALUES(5, 'PR');
  
INSERT INTO Skills
  VALUES(5, 'LM');
  
INSERT INTO Skills
  VALUES(6, 'IR');
  
INSERT INTO Skills
  VALUES(6, 'PL');
  
INSERT INTO Skills
  VALUES(6, 'EL');
  
------------------------------------------

-- Customers
-- ID, first, last, address, postal code, phone, city, 
-- province, email, zip
INSERT INTO Customer
  VALUES(DEFAULT, 'Nick', 'Defranco', '123 main', 'L0L0L0', '9056663333',
          NULL, NULL, NULL, NULL);
          
INSERT INTO Customer
  VALUES(DEFAULT, 'Nicole', 'Cusi', '0X000001F', 'P2P4P6', '9050123456',
          'Toronto', NULL, NULL, '45226');
          
INSERT INTO Customer
  VALUES(DEFAULT, 'Steven', 'Bouttarath', '1234', 'J5J3J1', '2892468888', 
          'Ottawa', 'ON', 'stevenisgood@math.com', NULL);

INSERT INTO Customer
  VALUES(DEFAULT, 'Yehya', 'Musse', '4321', 'T0T0T0', '4165556666',
          'Some where', NULL, NULL, '79854');

-- Nick got put as customer id# 1 and invoice id# 1
-- Invoice_ID, Customer_ID, Team_ID, Invoice_Date
INSERT INTO Invoice
  VALUES(DEFAULT, 1, 3, '04-Jul-19');

-- invoice #1 (again belongs to Nick) will be assigned services
-- that he wanted
-- Invoice ID, Service_Code, Work_Duration
INSERT INTO Service_Invoice
  VALUES(1, 'LC', 0.75);
  
INSERT INTO Service_Invoice
  VALUES(1, 'GW', 1.15);
  
INSERT INTO Service_Invoice
  VALUES(1, 'GP', 0.25);
  
INSERT INTO Service_Invoice
  VALUES(1, 'GF', 0.50);
  
-------------------------------------  

-- Nicole's turn
  
-- Invoice_ID, Customer_ID, Team_ID, Invoice_Date
INSERT INTO Invoice
  VALUES(DEFAULT, 2, 2, '5-Jul-19');

-- Invoice ID, Service_Code, Work_Duration
INSERT INTO Service_Invoice
  VALUES(2, 'LC', 0.75);
  
INSERT INTO Service_Invoice
  VALUES(2, 'LW', 1.15);
  
INSERT INTO Service_Invoice
  VALUES(2, 'LF', 0.25);
  
INSERT INTO Service_Invoice
  VALUES(2, 'TG', 0.50);  
  
---------------------------------------------

-- Yehya's turn
-- Invoice_ID, Customer_ID, Team_ID, Invoice_Date
INSERT INTO Invoice
  VALUES(DEFAULT, 4, 1, DEFAULT);
  
-- Invoice ID, Service_Code, Work_Duration
INSERT INTO Service_Invoice
  VALUES(3, 'LC', 0.75);
  
INSERT INTO Service_Invoice
  VALUES(3, 'GW', 1.15);
  
INSERT INTO Service_Invoice
  VALUES(3, 'GP', 0.25);
  
INSERT INTO Service_Invoice
  VALUES(3, 'GF', 0.50);
  
--------------------------------------

-- Store portion

-- Sales
-- Sales Assistant ID, first, last
INSERT INTO Sales_Assistant
  VALUES(DEFAULT, 'Paul', 'Smith');
  
INSERT INTO Sales_Assistant
  VALUES(DEFAULT, 'Maria', 'Wong');


-- possible Classifications
-- Code, Description, Markup
INSERT INTO Classification
  VALUES('GT', 'Garden Tools', 0.30);
  
INSERT INTO Classification
  VALUES('SB', 'Shrubs', 0.50);
  
INSERT INTO Classification
  VALUES('FT', 'Fertilizers', 0.25);
  
INSERT INTO Classification
  VALUES('SP', 'Sprinklers', 0.40);
  
-- Suppliers
-- Supplier_ID, Description
INSERT INTO Suppliers
  VALUES(DEFAULT, 'Sheffield-Gander Inc.');
  
INSERT INTO Suppliers
  VALUES(DEFAULT, 'Husky Inc.');
  
INSERT INTO Suppliers
  VALUES(DEFAULT, 'Northwood Farms Inc.');
  
INSERT INTO Suppliers
  VALUES(DEFAULT, 'Sherwood Nursery');
  
INSERT INTO Suppliers
  VALUES(DEFAULT, 'Diemar Garden Center');
  
  
-- Items
-- Item_ID, Description, Aisle, Supplier_ID, Stock, 
-- Classification_Code, Cost
INSERT INTO Item
  VALUES(DEFAULT, '6 foot garden rake', 1, 1, 5, 'GT', 9.23);
  
INSERT INTO Item
  VALUES(DEFAULT, 'Golden cedar sapling', 5, 3, 23, 'SB', 23.33);
  
INSERT INTO Item
  VALUES(DEFAULT, 'Premium lawn fertilizer', 6, 4, 4, 'FT', 15.00);
  
INSERT INTO Item
  VALUES(DEFAULT, '120 foot watering hose', 3, 5, 9, 'SP', 25.00);

-- Steven's turn! recieving help from Paul Smith
-- Order_ID, Order_date, Customer_ID, Sales_Assistant_ID
INSERT INTO Orders
  VALUES(DEFAULT, DEFAULT, 3, 1);
  
-- Feels like planting today (golden cedar sapling)
-- Order_ID, Item_ID, Amt_Ordered, Quoted_price
INSERT INTO Order_Item
  VALUES(1, 2, 2, 20.00);
  
-- Needs to water them with a hose of course! (... not sure
-- why he needs three hoses though)
INSERT INTO Order_Item
  VALUES(1, 4, 3, 25.00);

----------------------------------------

-- View 1 -- NOTE: could not get grouping to work on this view meaning getting
-- SUM was not working either
-- and joining equipments table caused problems with output.
CREATE VIEW Invoice_Statment AS
  SELECT i.Invoice_ID, i.Invoice_Date, i.Team_ID "Work Team", 
      e.Description "Equipment", 
      c.Customer_ID||'-'||c.Firstname||' '||c.Lastname "Customer",
      c.Street||' '||c.City||','||c.Province||' '||c.Postal_Code "Address",
      s.Service_Code, s.Description, s.Hourly_Charge, 
      si.Work_Duration, (s.Hourly_Charge * si.Work_Duration) AS Total_Charge
    FROM Invoice i, Customer c, Service_Invoice si, 
      Services s, Equipment e, Equipment_Service es
    WHERE i.Invoice_ID = 2
      AND i.Invoice_ID = si.Invoice_ID
      AND si.Service_Code = s.Service_Code
      AND s.Service_Code = es.Service_Code
      AND es.Equip_ID = e.Equip_ID
      AND c.Customer_ID = i.Customer_ID;

      
-- View 2 -- NOTE: could not get grouping to work on this view
CREATE VIEW Team_List AS
  SELECT t.Team_ID, t.Description, p.Description "Position", 
      e.Firstname||' '||e.Lastname "Name", e.Emp_ID, e.OHIP, e.Phone_Number,
      e.Start_Date, sc.Description "Skills"
    FROM Team t, Positions p, Employees e, Skill_codes sc,
      Skills s
    WHERE t.Team_ID = e.Team_ID
      AND p.Code = e.Position_Code
      AND sc.Code = s.Skill_Code
      AND s.Emp_ID = e.Emp_ID
      AND t.Team_ID = 1;

-- View 3
-- Used Quoted_Price field in Order_Item instead of cost in Items table
-- as the price for a item could vary among customers (some may get discounts).
CREATE VIEW Product_Sales_Report AS
  SELECT c.Code, i.Item_ID "Product ID", i.description "Product", 
    (oi.Quoted_Price * (1 + c.Markup)) AS Charge,
    oi.Amt_Ordered "Qty", o.Order_ID "Invoice ID", o.Order_Date "Invoice Date",
    s.Sales_Assistant_ID||'-'||s.Firstname||' '||s.Lastname "Sales Assistant",
    o.Customer_ID "Cust. NO."
    FROM Classification c, Item i, Order_Item oi, 
      Sales_Assistant s, Orders o
    WHERE c.Code = i.Classification_Code
      AND oi.Item_ID = i.Item_ID
      AND oi.Order_ID = o.Order_ID
      AND o.Sales_Assistant_ID = s.Sales_Assistant_ID;

-- View 4
CREATE VIEW Product_Report AS
  SELECT c.Code, c.description "Class", i.item_ID "Product ID", i.description, 
    i.Cost, c.Markup, TO_CHAR(i.Cost * (1 + c.Markup), '999.99') AS Charge
    FROM Classification c, Item i
    WHERE c.Code = i.Classification_Code;
  
-- View 5
CREATE VIEW Inventory_Report AS
  SELECT i.Item_ID, i.Description, i.stock "Inventory", i.Aisle, 
      s.Description "Supplier"
    FROM Item i, Suppliers s
    WHERE i.Supplier_ID = s.Supplier_ID;
  
--------------------------------------------------
-- Roles
-- All roles require special permission from the admin(the owner) to be able
-- to delete rows, alter tables, create indexs, 

-- Manages information regarding employees
CREATE ROLE HR;

-- Manages new employees that get hired as well as changing 
-- information on existing employees.
GRANT SELECT, INSERT, UPDATE
  ON Employees
  TO HR;
  
-- Must be able to add and modify data to match employees with the correct 
-- skills
GRANT SELECT, INSERT, UPDATE
  ON Skills
  TO HR;
  
-- Amount of teams should not change very often so the admin(the owner) can
-- handle that. Only needs to be able to query to be able to verify that the
-- employee was placed on the correct team.
GRANT SELECT 
  ON Team
  TO HR;
  
-- Should not need to change types of positions avaiable(should not change 
-- often, owner can handle that) Only needs to be able to query to be able to 
-- verify that the employee has the correct position.
GRANT SELECT
  ON Positions;

-- Similar reason as above two, Only needs to be able to query to be able to 
-- verify that the employee has the correct skills associated with them.
GRANT SELECT
  ON Skill_Codes
  TO HR
  
-- Logs all information about the services completed for customers
CREATE ROLE BOOKKEEPER;

-- Requires full permission on invoices table to log any invoice that comes
GRANT SELECT, UPDATE, INSERT
  ON Invoice
  TO BOOKKEEPER;
  
-- Requires full permission on service_invoice table to determine what services
-- the one invoice requires. 
GRANT SELECT, INSERT, UPDATE
  ON Service_Invoice
  TO BOOKKEEPER;
  
-- Should not need to change any general information about a service
GRANT SELECT
  ON Services
  TO BOOKKEEPER;
  
-- Should not need to change any general information about equipment
GRANT SELECT
  ON Equipment
  TO BOOKKEEPER;
  
-- Should not need to change what tools are used with what services
GRANT SELECT
  ON EQUIPMENT_SERVICE
  TO BOOKKEEPER;
  
  
  
CREATE ROLE SALES_ASSISTANT;

-- These columns may change more often then the other columns in the table,
-- other information kept on this table should be allowed to be touched by
-- Sales assistants
GRANT SELECT,
    UPDATE(Aisle, Stock, Cost)
  ON Item
  TO SALES_ASSISTANT
-- Admin (the owner) will handle information about adding new items, 
-- the owner will talk with suppliers, so he will know that information the
-- best.

-- Needed to verify classification as the sales rep might forget what the code
-- means, as well as the table has data about the markup that is associated with
-- the item class which is required to calculate a price for the customer.
GRANT SELECT
  ON Classification
  TO SALES_ASSISTANT;
  
-- requires full access to orders table to log all orders they take
GRANT SELECT, INSERT, UPDATE
  ON Orders
  TO SALES_ASSISTANT;
  
-- Requires access to customers table to log new customers
GRANT SELECT, INSERT, UPDATE
  ON Customer
  TO SALES_ASSISTANT;
  
-- Requires access to table that has information about each specific 
-- item in a invoice
GRANT SELECT, INSERT, UPDATE
  ON Order_Item
  TO SALES_ASSISTANT;
  
COMMIT;