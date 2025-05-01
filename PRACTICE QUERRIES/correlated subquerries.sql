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

select * from da06dept

--Average salary of all departments
select AVG(Salary) from da06emp;

--Employee whose salary > than average salary of department
select empname from da06emp where salary > (select avg(salary) from da06emp);

--Employee whose salary > than average salary of department using group by
SELECT empname FROM da06emp GROUP BY empname, salary HAVING salary > (SELECT AVG(salary) FROM da06emp); 

--select maximum salary by department
select deptid,max(salary) as maxsalary from da06emp group by deptid --easy form
select DeptID, max(Salary) as maxsalary from (select DeptID,salary from da06emp) as da06dept group by DeptID;--using subquery

--Correlated queries. 
--Find employees whose salary is greater than the average salary of their own department.

SELECT * 
FROM da06emp e
WHERE e.salary > (
  SELECT AVG(salary)
  FROM da06emp 
  WHERE DeptID = e.DeptID
  GROUP BY DeptID
);

SELECT EmpName, Salary, DeptID,
       (SELECT DeptName FROM Da06dept WHERE Da06dept.deptID = Da06emp.DeptID) AS DeptName,
       (SELECT AVG(salary) FROM Da06emp de WHERE de.deptID = Da06emp.DeptID) AS avg_salary
FROM Da06emp
WHERE Salary > (SELECT AVG(salary) FROM Da06emp de WHERE de.DeptID = Da06emp.DeptID);

