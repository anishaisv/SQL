-- Create Employee table
CREATE TABLE da06emp (
   EmpID INT,
   EmpName VARCHAR(50),
   DeptID INT,
   Salary INT
);-- Create Department table
CREATE TABLE da06dept (
   DeptID INT,
   DeptName VARCHAR(50)
);INSERT INTO Da06emp VALUES (1, 'John', 101, 50000);
INSERT INTO Da06emp VALUES (2, 'Sara', 102, 60000);
INSERT INTO Da06emp VALUES (3, 'Tom', 101, 45000);
INSERT INTO Da06emp VALUES (4, 'Linda', 103, 70000);
INSERT INTO Da06emp VALUES (5, 'James', 102, 55000);INSERT INTO Da06dept VALUES (101, 'HR');
INSERT INTO Da06dept VALUES (102, 'IT');
INSERT INTO Da06dept VALUES (103, 'Finance');

--Subqueries
select * from da06emp
select AVG(Salary) from da06emp;
select empname from da06emp where salary > (select avg(salary) from da06emp);
SELECT empname FROM da06emp GROUP BY empname, salary HAVING salary > (SELECT AVG(salary) FROM da06emp); 