-- ===============================================
-- DATABASE: Employee and Sales Subqueries Practice
-- Description: Sample SQL queries for practicing
-- subqueries, correlated subqueries
-- ===============================================

-- ================================
-- SECTION 1: Employee & Department
-- ================================

-- Create Employee table
CREATE TABLE da06emp (
    EmpID INT,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary INT
);

-- Create Department table
CREATE TABLE da06dept (
    DeptID INT,
    DeptName VARCHAR(50)
);

-- Insert sample data into Employee
INSERT INTO da06emp VALUES (1, 'John', 101, 50000);
INSERT INTO da06emp VALUES (2, 'Sara', 102, 60000);
INSERT INTO da06emp VALUES (3, 'Tom', 101, 45000);
INSERT INTO da06emp VALUES (4, 'Linda', 103, 70000);
INSERT INTO da06emp VALUES (5, 'James', 102, 55000);

-- Insert sample data into Department
INSERT INTO da06dept VALUES (101, 'HR');
INSERT INTO da06dept VALUES (102, 'IT');
INSERT INTO da06dept VALUES (103, 'Finance');

-- View tables
SELECT * FROM da06emp;
SELECT * FROM da06dept;

-- Average salary of all employees
SELECT AVG(Salary) AS avg_salary FROM da06emp;

-- Employees earning above average salary
SELECT EmpName 
FROM da06emp 
WHERE Salary > (SELECT AVG(Salary) FROM da06emp);

-- Using GROUP BY with subquery
SELECT EmpName 
FROM da06emp 
GROUP BY EmpName, Salary 
HAVING Salary > (SELECT AVG(Salary) FROM da06emp);

-- Maximum salary by department
SELECT DeptID, MAX(Salary) AS max_salary 
FROM da06emp 
GROUP BY DeptID;

-- Using subquery
SELECT DeptID, MAX(Salary) AS max_salary 
FROM (SELECT DeptID, Salary FROM da06emp) AS sub 
GROUP BY DeptID;

-- Correlated subquery: Employees earning more than average in their own department
SELECT * 
FROM da06emp e
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM da06emp 
    WHERE DeptID = e.DeptID
);

-- Add Department name and average salary for context
SELECT EmpName, Salary, DeptID,
       (SELECT DeptName FROM da06dept WHERE da06dept.DeptID = da06emp.DeptID) AS DeptName,
       (SELECT AVG(Salary) FROM da06emp de WHERE de.DeptID = da06emp.DeptID) AS avg_salary
FROM da06emp
WHERE Salary > (
    SELECT AVG(Salary) FROM da06emp de WHERE de.DeptID = da06emp.DeptID
);

-- Employee(s) with maximum salary in the company
SELECT EmpName 
FROM da06emp 
WHERE Salary = (SELECT MAX(Salary) FROM da06emp);

-- Employees earning more than any employee in the HR department
SELECT EmpName 
FROM da06emp 
WHERE Salary > (
    SELECT MAX(Salary) 
    FROM da06emp 
    WHERE DeptID = (SELECT DeptID FROM da06dept WHERE DeptName = 'HR')
);

-- Highest-paid employee(s) in each department (correlated subquery)
SELECT * 
FROM da06emp d 
WHERE Salary = (
    SELECT MAX(Salary) 
    FROM da06emp e 
    WHERE e.DeptID = d.DeptID
);

-- ================================
-- SECTION 2: Sales Database Setup
-- ================================

-- Create Sales2 database
CREATE DATABASE Sales2;
USE Sales2;

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

-- Insert Products
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1001, 'Widget A', 20.00),
(1002, 'Widget B', 30.00),
(1003, 'Widget C', 40.00),
(1004, 'Widget D', 50.00);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert Customers
INSERT INTO Customers (CustomerID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Bob Johnson'),
(104, 'Alice Brown'),
(105, 'Mary Davis');

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    Total DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Orders
INSERT INTO Orders (OrderID, OrderDate, CustomerID, ProductID, Quantity, Total)
VALUES
(1, '2023-12-01', 101, 1001, 10, 200.00),
(2, '2023-12-02', 102, 1002, 5, 150.00),
(3, '2023-12-03', 103, 1001, 3, 60.00),
(4, '2023-12-03', 104, 1003, 8, 240.00),
(5, '2023-12-05', 101, 1001, 15, 300.00),
(6, '2023-12-06', 102, 1004, 7, 350.00),
(7, '2023-12-07', 103, 1002, 6, 180.00),
(8, '2023-12-08', 104, 1003, 10, 400.00),
(9, '2023-12-09', 105, 1001, 12, 240.00);

-- View tables
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- ================================
-- SECTION 3: Sales Subqueries
-- ================================

-- 1. Customers who ordered products with price > $40
SELECT CustomerName 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    WHERE ProductID IN (
        SELECT ProductID FROM Products WHERE Price > 40
    )
);

-- 2. Customers who placed at least one order for more than 5 units
SELECT CustomerName
FROM Customers c 
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID 
    AND o.Quantity > 5
);

-- 3. Customers whose total order amount is greater than all of John Doe's orders
SELECT CustomerName, Total 
FROM Orders 
WHERE Total > ALL (
    SELECT Total 
    FROM Orders 
    WHERE CustomerID = (
        SELECT CustomerID FROM Customers WHERE CustomerName = 'John Doe'
    )
);
