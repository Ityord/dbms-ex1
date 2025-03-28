1. -- a. Employee Table
CREATE TABLE Employee (
  Fname       VARCHAR2(30),
  mname       VARCHAR2(30),
  lname       VARCHAR2(30)  NOT NULL,
  Ssn         VARCHAR2(9)   NOT NULL,
  Bdate       DATE,
  address     VARCHAR2(50),
  gender      CHAR(1),
  salary      NUMBER,
  Super_Ssn   VARCHAR2(9),
  Dept_num    NUMBER        NOT NULL
);

-- b. Department Table
CREATE TABLE Department (
  Dept_num      NUMBER PRIMARY KEY,  -- assuming Dept_num is the primary key
  Dept_name     VARCHAR2(30)  UNIQUE,
  Mgr_Ssn       VARCHAR2(9),
  Mgr_startdate DATE
);

-- c. Department_locations Table
CREATE TABLE Department_locations (
  Dept_num NUMBER,
  location VARCHAR2(50),
  CONSTRAINT pk_dept_locations PRIMARY KEY (Dept_num, location),
  CONSTRAINT fk_dept_locations FOREIGN KEY (Dept_num)
      REFERENCES Department(Dept_num)
);

-- d. Project Table
CREATE TABLE Project (
  Proj_num      NUMBER PRIMARY KEY,
  Proj_name     VARCHAR2(50),
  Proj_location VARCHAR2(50),
  Dept_num      NUMBER,
  CONSTRAINT fk_project_dept FOREIGN KEY (Dept_num)
      REFERENCES Department(Dept_num)
);

-- e. Employee_Project Table
CREATE TABLE Employee_Project (
  Ssn      VARCHAR2(9),
  Proj_num NUMBER,
  Hours    NUMBER,
  CONSTRAINT pk_emp_proj PRIMARY KEY (Ssn, Proj_num),
  CONSTRAINT fk_emp_proj_emp FOREIGN KEY (Ssn)
      REFERENCES Employee(Ssn),
  CONSTRAINT fk_emp_proj_proj FOREIGN KEY (Proj_num)
      REFERENCES Project(Proj_num)
);

-- f. Dependent Table
-- Note: The attribute "Dept_name" is used as provided. In many similar designs,
-- a dependent’s name (rather than a department name) is stored.
CREATE TABLE Dependent (
  Ssn         VARCHAR2(9),
  Dept_name   VARCHAR2(30),
  gender      CHAR(1),
  bdate       DATE,
  relationship VARCHAR2(30),
  CONSTRAINT fk_dependent_emp FOREIGN KEY (Ssn)
      REFERENCES Employee(Ssn)
);
2. INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (1, 'Marketing', NULL, TO_DATE('2020-01-15','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (2, 'Sales', NULL, TO_DATE('2020-02-20','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (3, 'HR', NULL, TO_DATE('2020-03-10','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (4, 'IT', NULL, TO_DATE('2020-04-05','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (5, 'Finance', NULL, TO_DATE('2020-05-25','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (6, 'Operations', NULL, TO_DATE('2020-06-30','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (7, 'R&D', NULL, TO_DATE('2020-07-15','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (8, 'CustomerService', NULL, TO_DATE('2020-08-10','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (9, 'Logistics', NULL, TO_DATE('2020-09-05','YYYY-MM-DD'));

INSERT INTO Department (Dept_num, Dept_name, Mgr_Ssn, Mgr_startdate)
VALUES (10, 'Admin', NULL, TO_DATE('2020-10-01','YYYY-MM-DD'));

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('John', 'A', 'Doe', '111111111', TO_DATE('1985-05-10','YYYY-MM-DD'), '123 Main St', 'M', 4000, NULL, 1);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Jane', 'B', 'Smith', '222222222', TO_DATE('1988-07-20','YYYY-MM-DD'), '456 Elm St', 'F', 3500, '111111111', 2);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Robert', 'C', 'Brown', '333333333', TO_DATE('1978-12-01','YYYY-MM-DD'), '789 Oak Ave', 'M', 5000, '111111111', 3);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Emily', 'D', 'Davis', '444444444', TO_DATE('1992-03-15','YYYY-MM-DD'), '321 Pine Rd', 'F', 4500, '222222222', 4);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Michael', 'E', 'Wilson', '555555555', TO_DATE('1980-08-25','YYYY-MM-DD'), '654 Cedar Ln', 'M', 6000, NULL, 5);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Sarah', 'F', 'Miller', '666666666', TO_DATE('1983-11-30','YYYY-MM-DD'), '987 Birch Blvd', 'F', 3200, '555555555', 6);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('David', 'G', 'Taylor', '777777777', TO_DATE('1975-06-18','YYYY-MM-DD'), '159 Maple St', 'M', 5500, '333333333', 7);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Laura', 'H', 'Anderson', '888888888', TO_DATE('1990-09-09','YYYY-MM-DD'), '753 Walnut Ave', 'F', 4800, '444444444', 8);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Daniel', 'I', 'Thomas', '999999999', TO_DATE('1987-02-28','YYYY-MM-DD'), '852 Spruce Dr', 'M', 5200, '777777777', 9);

INSERT INTO Employee (Fname, mname, lname, Ssn, Bdate, address, gender, salary, Super_Ssn, Dept_num)
VALUES ('Olivia', 'J', 'Jackson', '101010101', TO_DATE('1995-12-12','YYYY-MM-DD'), '951 Poplar Ct', 'F', 3100, '888888888', 10);

INSERT INTO Department_locations (Dept_num, location)
VALUES (1, 'Surathkal');

INSERT INTO Department_locations (Dept_num, location)
VALUES (2, 'Bangalore');

INSERT INTO Department_locations (Dept_num, location)
VALUES (3, 'Mysore');

INSERT INTO Department_locations (Dept_num, location)
VALUES (4, 'Hubli');

INSERT INTO Department_locations (Dept_num, location)
VALUES (5, 'Mangalore');

INSERT INTO Department_locations (Dept_num, location)
VALUES (6, 'Belgaum');

INSERT INTO Department_locations (Dept_num, location)
VALUES (7, 'Shimoga');

INSERT INTO Department_locations (Dept_num, location)
VALUES (8, 'Davangere');

INSERT INTO Department_locations (Dept_num, location)
VALUES (9, 'Gulbarga');

INSERT INTO Department_locations (Dept_num, location)
VALUES (10, 'Bidar');

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (1, 'Alpha', 'Surathkal', 1);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (2, 'Beta', 'Bangalore', 2);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (3, 'Gamma', 'Mysore', 3);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (4, 'Delta', 'Hubli', 4);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (5, 'Epsilon', 'Mangalore', 5);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (6, 'Zeta', 'Belgaum', 6);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (7, 'Eta', 'Shimoga', 7);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (8, 'Theta', 'Davangere', 8);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (9, 'Iota', 'Gulbarga', 9);

INSERT INTO Project (Proj_num, Proj_name, Proj_location, Dept_num)
VALUES (10, 'SUPER', 'Bidar', 10);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('111111111', 1, 20);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('222222222', 2, 25);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('333333333', 3, 30);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('444444444', 4, 15);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('555555555', 5, 40);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('666666666', 6, 35);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('777777777', 7, 28);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('888888888', 8, 32);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('999999999', 9, 22);

INSERT INTO Employee_Project (Ssn, Proj_num, Hours)
VALUES ('101010101', 10, 18);

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('111111111', 'Marketing', 'M', TO_DATE('2010-05-20','YYYY-MM-DD'), 'Child');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('222222222', 'Sales', 'F', TO_DATE('2012-08-15','YYYY-MM-DD'), 'Spouse');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('333333333', 'HR', 'M', TO_DATE('2008-11-10','YYYY-MM-DD'), 'Child');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('444444444', 'IT', 'F', TO_DATE('2015-01-05','YYYY-MM-DD'), 'Child');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('555555555', 'Finance', 'M', TO_DATE('2005-03-25','YYYY-MM-DD'), 'Spouse');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('666666666', 'Operations', 'F', TO_DATE('2011-07-30','YYYY-MM-DD'), 'Child');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('777777777', 'R&D', 'M', TO_DATE('2009-09-12','YYYY-MM-DD'), 'Child');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('888888888', 'CustomerService', 'F', TO_DATE('2013-04-18','YYYY-MM-DD'), 'Spouse');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('999999999', 'Logistics', 'M', TO_DATE('2007-12-22','YYYY-MM-DD'), 'Child');

INSERT INTO Dependent (Ssn, Dept_name, gender, bdate, relationship)
VALUES ('101010101', 'Admin', 'F', TO_DATE('2016-06-06','YYYY-MM-DD'), 'Child');

2. ALTER TABLE Employee
ADD (blood_group VARCHAR2(10),
     hobbies     VARCHAR2(50));

3. ALTER TABLE Employee
MODIFY (blood_group VARCHAR2(15));

4. ALTER TABLE Employee
DROP COLUMN hobbies;

5. ALTER TABLE Employee
RENAME TO Employee_details;

7. UPDATE Employee_details
SET salary = salary + 1000;
8. UPDATE Employee_details
SET salary = salary + 500
WHERE salary < 5000;
9. UPDATE Employee_details
SET salary = salary + 100
WHERE salary < 10000
  AND Bdate < TO_DATE('1990-01-01','YYYY-MM-DD');
10. UPDATE Employee_details
SET salary = salary + 100
WHERE salary < 10000
   OR Bdate < TO_DATE('1990-01-01','YYYY-MM-DD');
11. UPDATE Employee_details
SET salary = salary + 100
WHERE salary BETWEEN 1000 AND 5000
  AND Bdate < TO_DATE('1990-01-01','YYYY-MM-DD');
12. UPDATE Employee_details
SET salary = salary + 100
WHERE salary IN (1000, 3000, 5000);
13. UPDATE Employee_details
SET phone = '0000'
WHERE phone IS NULL;
14. UPDATE Employee_details
SET salary = salary + 100
WHERE salary NOT BETWEEN 1000 AND 5000
  AND Bdate < TO_DATE('1990-01-01','YYYY-MM-DD');
15. UPDATE Employee_details
SET salary = salary + 100
WHERE salary IN (1000, 3000, 5000);
16. DELETE FROM Employee_details
WHERE Bdate < TO_DATE('1970-01-01','YYYY-MM-DD');
17. SELECT Fname, mname, lname,
       TRUNC(MONTHS_BETWEEN(SYSDATE, Bdate)/12) AS Age
FROM Employee_details;
18. SELECT Fname, lname, salary
FROM Employee_details;
19. SELECT Bdate, salary
FROM Employee_details
WHERE lname = 'Smith';
20. SELECT Proj_location
FROM Project
WHERE Proj_name = 'SUPER';
21. SELECT *
FROM Dependent
WHERE Ssn = '482928';
22. SELECT *
FROM Employee_details
WHERE salary > 2000
  AND Bdate < TO_DATE('1990-01-01','YYYY-MM-DD');
23. SELECT *
FROM Employee_details
WHERE Dept_num = 1;
24. SELECT *
FROM Project
WHERE Dept_num = 5;
25. SELECT e.Fname, e.mname, e.lname, e.Ssn, e.salary, d.Dept_name
FROM Employee_details e
JOIN Department d ON e.Dept_num = d.Dept_num;
26. SELECT e.Fname, e.lname, p.Proj_name, p.Proj_location
FROM Employee_details e
JOIN Employee_Project ep ON e.Ssn = ep.Ssn
JOIN Project p ON ep.Proj_num = p.Proj_num;
27. SELECT e.*
FROM Employee_details e
JOIN Department d ON e.Dept_num = d.Dept_num
WHERE d.Dept_name = 'Marketing';
28. SELECT p.*
FROM Project p
JOIN Department d ON p.Dept_num = d.Dept_num
WHERE d.Dept_name = 'Sales';
29. SELECT d.*
FROM Dependent d
JOIN Employee_details e ON d.Ssn = e.Ssn
WHERE e.lname = 'Smith';
30. SELECT dl.location
FROM Department_locations dl
JOIN Department d ON dl.Dept_num = d.Dept_num
WHERE d.Dept_name = 'Marketing';
31. SELECT e.*
FROM Employee_details e
JOIN Department_locations dl ON e.Dept_num = dl.Dept_num
WHERE dl.location = 'Surathkal';
32. SELECT *
FROM Employee_details
ORDER BY salary DESC;
33. SELECT *
FROM Dependent
ORDER BY Dept_name DESC;
