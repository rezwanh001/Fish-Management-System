----- PROJECT : Fish Management System 
spool G:/test.txt; 
--------------------------Drop all the tables--------------------------------
DROP TABLE Pond cascade constraints; 
DROP TABLE Owner cascade constraints; 
DROP TABLE Buyer cascade constraints; 
DROP TABLE account cascade constraints; 
DROP TABLE Fish cascade constraints; 
 

--------------------------Create all the tables--------------------------------
CREATE TABLE Fish(
	F_grade 	VARCHAR(15) NOT NULL,
	F_name 		VARCHAR(15),
	F_price		NUMBER(9,3),
	primary key(F_grade)
);

CREATE TABLE Buyer(
	B_id 		NUMBER(9) NOT NULL,
	B_name		VARCHAR(15),
	F_name 		VARCHAR(15),
	F_grade 	VARCHAR(15) NOT NULL,
	primary key(B_id),
	foreign key(F_grade) references Fish(F_grade) ON DELETE CASCADE
);

CREATE TABLE Owner(
	O_id 		NUMBER(9) NOT NULL,
	O_name 		VARCHAR(15),
	Profit 		NUMBER(9,3),
	Loss		NUMBER(9,3),
	B_id 		NUMBER(9) NOT NULL,
	primary key(O_id),
	foreign key(B_id) references Buyer(B_id) ON DELETE CASCADE
);

CREATE TABLE account( 
userid VARCHAR(15), 
password NUMBER(9) 
); 

CREATE TABLE Pond(
	P_id 		NUMBER(9) NOT NULL,
	Number_Emp	NUMBER(9),
	Foods		VARCHAR(15),
	Cost		NUMBER(9,3),
	F_grade		VARCHAR(15) NOT NULL,
	O_id		NUMBER(9) NOT NULL,
	primary key(P_id),
	foreign key(F_grade) references Fish(F_grade) ON DELETE CASCADE,
	foreign key(O_id) references Owner(O_id) ON DELETE CASCADE
); 

--------------------------Insert data into the tables--------------------------------
INSERT INTO Fish VALUES('small', 'prawn', 15.25);
INSERT INTO Fish VALUES('medium', 'rui', 75.50);
INSERT INTO Fish VALUES('large', 'katla', 95.25);

INSERT INTO Buyer VALUES(1, 'Abul', 'prawn', 'small');
INSERT INTO Buyer VALUES(2, 'Babul', 'rui', 'medium');
INSERT INTO Buyer VALUES(3, 'Kabul', 'katla', 'large');

INSERT INTO Owner VALUES(1, 'Mofiz', 5000.50, 00.00, 1);
INSERT INTO Owner VALUES(2, 'Tofiz', 00.00, 500.25, 2);
INSERT INTO Owner VALUES(3, 'Nasser', 00.00, 125.00, 3);

INSERT INTO account values('REZWAN',1407028); 
INSERT INTO account values('AYON',1407041); 
INSERT INTO account values('PRANTO',1407003);

INSERT INTO Pond VALUES(1, 12, 'TetraCichlid', 5252.58, 'small', 1);
INSERT INTO Pond VALUES(2, 09, 'TetraFin', 5200.58, 'medium', 2);
INSERT INTO Pond VALUES(3, 15, 'TetraMin', 6000.25, 'large', 3);

COMMIT; 

------------------------------- LOG IN --------------------------------------- 


PROMPT You need to login first.. 
PROMPT Enter your userid and password..

SET SERVEROUTPUT ON 

DECLARE 
row NUMBER(2); 
u1 account.userid%TYPE; 
p1 account.password%TYPE; 
BEGIN 
	u1:='&userid'; 
	p1:=&password; 
select count(*) INTO row from account 
where account.userid=u1 and account.password=p1; 
if row = 1 then 
	dbms_output.put_line ('Log in successful'); 
else 
	dbms_output.put_line ('Id or password did not match');
end if; 
EXCEPTION 
	WHEN others THEN NULL; 
END;
/ 
PAUSE Press ENTER to continue ... 

-- Describe all the Tables

DESCRIBE Fish;
DESCRIBE Buyer;
DESCRIBE Owner;
DESCRIBE Pond;

SELECT * FROM Fish;
SELECT * FROM Buyer;
SELECT * FROM Owner;
SELECT * FROM Pond;

ALTER TABLE pond RENAME COLUMN Number_Emp to Emp_Number;
describe pond;

alter table fish modify F_name VARCHAR(10);
describe fish;

delete from buyer where B_id = 2;
SELECT * FROM Fish;
SELECT * FROM Buyer;
SELECT * FROM Owner;
SELECT * FROM Pond;

update Owner set Profit = 125.00, Loss = 00.00 where O_id = 3;
SELECT * FROM Owner;

ALTER TABLE Owner DROP COLUMN Loss;
SELECT * FROM Owner;

ALTER TABLE Owner ADD Loss NUMBER(5,3);
describe Owner;
SELECT * FROM Owner;
-------------------------Aggregate Function-------------------------------
SELECT F_price FROM Fish;
SELECT MAX(F_price) FROM Fish;
SELECT MAX(F_price) FROM Fish WHERE F_price < (SELECT MAX(F_price) FROM Fish); -- Second Max.

DESCRIBE Owner;
SELECT COUNT(*), COUNT(Profit) FROM Owner;

SELECT B_id FROM Owner;
SELECT Loss FROM Owner;

SELECT * FROM Fish;
SELECT * FROM Buyer;
SELECT * FROM Owner;
SELECT * FROM Pond;

update Owner set Profit = 125.50, Loss = 00.00 where O_id = 3;
update Owner set Profit = 00.00, Loss = 10.5 where O_id = 1;
SELECT * FROM Owner;

DESCRIBE Owner;
SELECT COUNT(*), COUNT(Profit) FROM Owner;
SELECT COUNT(*), SUM(Profit), AVG(Loss) FROM Owner;
SELECT AVG(NVL(Loss, 0)) FROM Owner;

DESCRIBE Pond;
SELECT * FROM Pond;
SELECT COUNT(Emp_Number), COUNT(DISTINCT Emp_Number), COUNT(ALL Emp_Number) FROM Pond;

DESCRIBE Fish;
DESCRIBE Buyer;
DESCRIBE Owner;
DESCRIBE Pond;
--------------------------Insert data into the tables--------------------------------
INSERT INTO Fish VALUES('Ssmall', 'Pangash', 35.25);
INSERT INTO Fish VALUES('Mmedium', 'Elish', 125.50);
INSERT INTO Fish VALUES('Llarge', 'SilverCup', 45.25);
SELECT * FROM Fish;

INSERT INTO Buyer VALUES(4, 'AAbul', 'Pangash', 'Ssmall');
INSERT INTO Buyer VALUES(5, 'BBabul', 'Elish', 'Mmedium');
INSERT INTO Buyer VALUES(6, 'BKabul', 'SilverCup', 'Llarge');
SELECT * FROM Buyer;

INSERT INTO Owner VALUES(4, 'MMofiz', 5000.50, 4, 0.00);
INSERT INTO Owner VALUES(5, 'TTofiz', 00.00, 5, 50.25);
INSERT INTO Owner VALUES(6, 'NNasser', 00.00, 6, 13.00);
SELECT * FROM Owner;


INSERT INTO Pond VALUES(4, 19, 'TTetraCichlid', 5200.58, 'Ssmall', 4);
INSERT INTO Pond VALUES(5, 23, 'TTetraFin', 6200.58, 'Mmedium', 5);
INSERT INTO Pond VALUES(6, 11, 'TTetraMin', 7000.25, 'Llarge', 6);
SELECT * FROM Pond;

SELECT * FROM Fish;
SELECT * FROM Buyer;
SELECT * FROM Owner;
SELECT * FROM Pond;

SELECT Cost, COUNT(Cost) FROM Pond GROUP BY Cost;
SELECT Cost, COUNT(Cost) FROM Pond WHERE Emp_Number >= 19 GROUP BY Cost;
SELECT Cost, COUNT(Cost) FROM Pond GROUP BY Cost HAVING Cost >= 5000;
SELECT Cost FROM Pond GROUP BY Cost HAVING COUNT(Emp_Number) <= 1;
SELECT B_id ,B_name FROM Buyer WHERE F_name IN('Pangash', 'SilverCup');
SELECT B_id, B_name FROM Buyer WHERE F_name = 'Elish';

----------------------------------SET OPERATION----------------------------------------------
--UNION
SELECT P_id, Foods FROM Pond WHERE P_id > 1
UNION
SELECT p.P_id, p.Foods FROM Pond p
	WHERE p.P_id IN (SELECT o.P_id FROM Pond o, Buyer b WHERE o.P_id = b.B_id AND b.B_name = 'Kabul');

SELECT P_id, Foods FROM Pond WHERE P_id = 1 OR P_id = 5
UNION
SELECT p.P_id, p.Foods FROM Pond p
	WHERE p.P_id IN (SELECT o.P_id FROM Pond o, Buyer b WHERE o.P_id = b.B_id AND b.B_name = 'Kabul');

--INTERSECT
SELECT P_id, Foods FROM Pond WHERE P_id = 1 OR P_id = 5
INTERSECT
SELECT p.P_id, p.Foods FROM Pond p
	WHERE p.P_id IN (SELECT o.P_id FROM Pond o, Buyer b WHERE o.P_id = b.B_id AND b.B_name = 'Abul');

--UNION and INTERSECT
SELECT P_id, Foods FROM Pond WHERE P_id > 1
UNION
SELECT p.P_id, p.Foods FROM Pond p
	WHERE p.P_id IN (SELECT o.P_id FROM Pond o, Buyer b WHERE o.P_id = b.B_id AND b.B_name = 'Kabul')
INTERSECT
SELECT P_id, Foods
FROM Pond
WHERE P_id = 6;

--------------------------------------------JOIN-----------------------------------------------
SELECT b.B_id, b.B_name , o.O_name
	FROM Owner o, Buyer b
	WHERE o.B_id = b.B_id;

SELECT b.B_id, b.B_name , o.Profit
	FROM Owner o JOIN Buyer b
	ON o.B_id = b.B_id;

--Natural Join
SELECT b.B_name , o.Profit
	FROM Owner o NATURAL JOIN Buyer b;

SELECT Buyer.B_name , Owner.Profit
	FROM Owner  JOIN Buyer 
	USING (B_id);
	
SELECT Buyer.B_name , Owner.O_name
	FROM Owner NATURAL JOIN Buyer ;

--Inner Join
SELECT Fish.F_name, Buyer.B_name
	FROM Fish JOIN Buyer
	ON Fish.F_name = Buyer.F_name;

SELECT F_name, Buyer.B_name
	FROM Fish JOIN Buyer
	USING (F_name);
--Cross Join
SELECT b.B_name , o.Profit
	FROM Owner o CROSS JOIN Buyer b;
--Inner Join
SELECT b.B_name, o.O_name
	FROM Buyer b INNER JOIN Owner o
	ON b.B_id = o.O_id;
--Outer Join
SELECT b.B_id , b.B_name, o.O_name
	FROM Buyer b LEFT OUTER JOIN Owner o
	ON b.B_id = o.O_id;
SELECT b.B_id , b.B_name, o.O_name
	FROM Buyer b RIGHT OUTER JOIN Owner o
	ON b.B_id = o.O_id;
SELECT b.B_id , b.B_name, o.O_name
	FROM Buyer b FULL OUTER JOIN Owner o
	ON b.B_id = o.O_id;


------------------------------------PL/SQL------------------------------------------------
INSERT INTO Fish VALUES('Very small', 'Pangash', 15.25);
INSERT INTO Buyer VALUES(7, 'Abul', 'Pangash', 'Very small');
INSERT INTO Owner VALUES(7, 'Mofiz', 2050.50, 4, 0.00);
INSERT INTO Pond VALUES(7, 9, 'TetraCichlid', 200.58, 'Very small', 7);


SET SERVEROUTPUT ON
DECLARE
	Fish_grade  Fish.F_grade%type := 'small';
	Fish_name  Fish.F_name%type ;
	Fish_price Fish.F_price%type;
BEGIN 
	SELECT F_grade, F_name, F_price INTO Fish_grade,Fish_name, Fish_price 
	FROM Fish 
	WHERE F_grade = Fish_grade;

	DBMS_OUTPUT.PUT_LINE('Grade : ' || Fish_grade || ',  Name : ' || Fish_name || ',  Price : ' || Fish_price);
END;
/

SET SERVEROUTPUT ON;
DECLARE 
	Max_Owner_no Owner.O_id%type;
BEGIN
	SELECT MAX(O_id) INTO Max_Owner_no
	FROM Owner;
	DBMS_OUTPUT.PUT_LINE('Maximum Owner: '||Max_Owner_no);
END;
/

SET SERVEROUTPUT ON;
DECLARE 
	Fish_grade VARCHAR(15) := 'SoSmall';
	Fish_name VARCHAR(10) := 'Mi-Cup';
	Fish_price NUMBER(9,3) := 12.3;
BEGIN
	INSERT INTO Fish(F_grade,F_name, F_price)
	VALUES(Fish_grade, Fish_name, Fish_price);
	IF (SQL%NOTFOUND)
	THEN
		dbms_output.put_line('Insert error?!');
	END IF;
END;
/
SELECT * FROM Fish;

------------------------------CURSOR --------------------------------------------
SET SERVEROUTPUT ON;
DECLARE 
	CURSOR fish_cur IS SELECT F_grade, F_name FROM Fish;
	fish_record fish_cur%ROWTYPE;
BEGIN
OPEN fish_cur;
	LOOP
		FETCH fish_cur INTO fish_record;
		EXIT WHEN fish_cur%ROWCOUNT > 6;
		DBMS_OUTPUT.PUT_LINE('Fish Grade: ' || fish_record.F_grade || '   Fish Name: ' || fish_record.F_name);
	END LOOP;
	CLOSE fish_cur;
END;
/

---------------------------PL/SQL Procedure------------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE getown IS
	Owner_id Owner.O_id%type;
	Owner_name Owner.O_name%type;
BEGIN
	Owner_id := 7;
	SELECT O_name INTO Owner_name
	FROM Owner
	WHERE O_id = Owner_id;
	DBMS_OUTPUT.PUT_LINE('Name : '|| Owner_name);
END;
/
SHOW ERRORS;

BEGIN
	getown;
END;
/
SELECT * from Owner;

------- ADD_OWNER into OWNER Table
CREATE OR REPLACE PROCEDURE ADD_OWNER(
	Owner_id Owner.O_id%type,
	Owner_name Owner.O_name%type) IS
BEGIN 
	INSERT INTO Owner(O_id, O_name)
	VALUES (Owner_id, Owner_name);
	COMMIT;
END ADD_OWNER;
/
SHOW ERRORS;

SELECT * from Owner;
-- Average Loss Function
CREATE OR REPLACE FUNCTION avg_Loss RETURN NUMBER IS
	avg_ls Owner.Loss%type;
BEGIN
	SELECT AVG(Loss) INTO avg_ls 
	FROM Owner;
	RETURN avg_ls;
END;
/
SET SERVEROUTPUT ON
BEGIN
	dbms_output.put_line('Average Loss: ' || avg_Loss);
END;
/

-- Total Sum Function
CREATE OR REPLACE FUNCTION sum_Loss RETURN NUMBER IS
	sum_ls Owner.Loss%type;
BEGIN
	SELECT SUM(Loss) INTO sum_ls 
	FROM Owner;
	RETURN sum_ls;
END;
/
SET SERVEROUTPUT ON
BEGIN
	dbms_output.put_line('Total Loss: ' || sum_Loss);
END;
/

-- Get Annual Loss From Profit
CREATE OR REPLACE FUNCTION get_annual_Loss(
  Proft  IN Owner.Profit%TYPE,
  ls IN Owner.Loss%TYPE)
 RETURN NUMBER IS
BEGIN
  RETURN (NVL(Proft,0) * 12 + (NVL(ls,0) * nvl(Proft,0) * 12));
END get_annual_Loss;
/

SELECT O_id, O_name,
       get_annual_Loss(Profit,Loss) "Annual Loss"
FROM   Owner
WHERE B_id=3
/

---------------------Trigger, Transaction Management, Date----------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER check_Profit BEFORE INSERT OR UPDATE ON Owner
FOR EACH ROW
DECLARE
   c_min constant number(9,3) := 0000.0;
   c_max constant number(9,3) := 5005.0;
BEGIN
  IF :new.Profit > c_min AND :new.Profit < c_max THEN
  :new.Profit := 1250.0;
  DBMS_OUTPUT.PUT_LINE('New Profit : ' || :new.Profit);
  -- RAISE_APPLICATION_ERROR(-2000,'New Profit is too small or large');
END IF;
END;
/
SELECT * FROM Owner;

-- USE OF TRIGGER
INSERT INTO Owner VALUES(8, 'John', 200.0, 7, 00.0);
SELECT Profit FROM Owner;

SELECT * FROM Owner;

----------------------------ROLLBACK-------------------------
ROLLBACK;
SELECT * FROM Owner;

-- PROCEDURE FOR INSERTING VALUE
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE add_fish(f_grade Fish.F_grade%type, f_name Fish.F_name%type,f_price Fish.F_price%type) IS 
BEGIN
    INSERT INTO Fish VALUES (f_grade, f_name, f_price);
    DBMS_OUTPUT.PUT_LINE('User added successfully');
END;
/
SHOW ERRORS;

-------------------------------------------------------SAVEPOINT---------------------------------------------------
BEGIN
add_fish('Very Large', 'Pangash',55.25); 
END;
/

SELECT * FROM Fish;

SAVEPOINT P1;

BEGIN
add_fish('Very Very Large', 'Pangash', 127.25); 
END;
/
SELECT * FROM Fish;

ROLLBACK TO P1;
ROLLBACK;

---------------------------------------------------------DATE--------------------------------------------------

SELECT SYSDATE FROM FISH;
SELECT CURRENT_DATE FROM Pond;
SELECT SYSTIMESTAMP FROM FISH;

-- Project Test Query

SELECT b.B_name , o.O_name
	FROM Owner o, Buyer b, Fish f
	WHERE b.B_id = o.O_id AND f.F_grade = 'small';


spool off;