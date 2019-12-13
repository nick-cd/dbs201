DROP TABLE employees CASCADE CONSTRAINTS;
CREATE TABLE Employees (
 EMPNO               NUMBER(4),
 LNAME               VARCHAR2(20),
 FNAME               VARCHAR2(15),
 JOB                 VARCHAR2(9),
 HIREDATE            DATE,
 DEPTNO              NUMBER(2) NOT NULL,
 MTHSAL              NUMBER(7,2),
 BONUS               NUMBER(6,2),
 MGR                 NUMBER(4),
 CONSTRAINT employees_empno_PK PRIMARY KEY (EMPNO));
INSERT INTO employees VALUES (7839,'KING','BEN', 'GTECH2',TO_DATE('17-NOV-91','DD-MON-YY'),10,6000,3000,NULL);
INSERT INTO employees VALUES (8888,'JONES','LARRY','MTech2',TO_DATE('17-NOV-98','DD-MON-YY'),10,4200,1200,7839);
INSERT INTO employees VALUES (7344,'SMITH','SAM','GTech1',TO_DATE('17-NOV-95','DD-MON-YY'),20,4900,1500,7839);
INSERT INTO employees VALUES (7355,'POTTS','JIM','GTech1',TO_DATE('17-NOV-95','DD-MON-YY'),20,4900,1900,7839);
INSERT INTO employees VALUES (8844,'STUART','SUE','MTech1',TO_DATE('17-NOV-98','DD-MON-YY'),10,3700,NULL,8888);
COMMIT;
CREATE TABLE WebHits
  (wpage VARCHAR2(20),
   whdate DATE,
   Total NUMBER(6) );
DECLARE
  vdate DATE;
  vtot NUMBER(6);
  cnt1 NUMBER(6);
  cnt2 NUMBER(6);
BEGIN
  vdate := TO_DATE('01-NOV-2014','DD-MON-YYYY');
  vtot := 100;
  CNT1 := 20;
  CNT2 := -20;
  FOR x IN 1..3 LOOP
     FOR y IN 1..10 LOOP
       INSERT INTO webhits VALUES ('PRD0201', vdate, vtot);
        vdate := vdate +1;
        vtot := vtot + CNT1;
     END LOOP;
     FOR z IN 1..10 LOOP
       INSERT INTO webhits VALUES ('PRD0201', vdate, vtot);
        vdate := vdate +1;
        vtot := vtot + CNT2;
     END LOOP;
  END LOOP;
  vdate := TO_DATE('01-NOV-2014','DD-MON-YYYY');
  vtot := 500;
  CNT1 := 20;
  CNT2 := -20;
  FOR x IN 1..3 LOOP
     FOR y IN 1..7 LOOP
       INSERT INTO webhits VALUES ('PRD0485', vdate, vtot);
        vdate := vdate +1;
        vtot := vtot + CNT1;
     END LOOP;
     FOR z IN 1..13 LOOP
       INSERT INTO webhits VALUES ('PRD0485', vdate, vtot);
        vdate := vdate +1;
        vtot := vtot + CNT2;
     END LOOP;
  END LOOP;
 COMMIT;
END;
/