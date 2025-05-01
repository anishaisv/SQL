create database Sales2
use Sales2

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1001, 'Widget A', 20.00),
(1002, 'Widget B', 30.00),
(1003, 'Widget C', 40.00),
(1004, 'Widget D', 50.00);

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Bob Johnson'),
(104, 'Alice Brown'),
(105, 'Mary Davis');

-- Create the Orders table
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

-- Insert data into Orders table
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


select * from Products
select * from Customers
select * from Orders

--1. Subquery with IN
--Complete the following query to find the names of customers who have ordered products with a price greater than $40.

SELECT CustomerName 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    WHERE ProductID IN (SELECT ProductID FROM Products WHERE Price> 40)
);

--2. Subquery with EXISTS
--Complete the following query to find the names of customers who have placed at least one order for more than 5 units of any product.

SELECT CustomerName
FROM Customers c 
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID 
    AND o.Quantity > 5
);


SELECT 'hardcode' --CustomerName 
FROM Customers c 
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID 
    AND o.Quantity > 5
);
SELECT CustomerName

FROM Customers

WHERE CustomerID IN (

    SELECT CustomerID

    FROM Orders

    WHERE Quantity > 5

);
 
 --3. Subquery with ALL
--Complete the following query to find customers whose total order amount is greater than all orders placed by customer 'John Doe.'

SELECT CustomerName, Total 
FROM Orders 
WHERE Total > ALL (
    SELECT Total 
    FROM Orders 
    WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE CustomerName= 'John Doe')
);

select * from da06emp
select * from da06dept

--Find employees whose salary is equal to the maximum salary in the company.
select empname from da06emp where salary = (select max(salary) from da06emp) 

--Find employees who earn more than any employee in the HR department.

select empname from da06emp where salary> (select max(salary) from da06emp 
Where DeptId = (select deptid from da06dept where deptname ='HR')

group by deptid
);


--Get the highest-paid employee(s) in each department using correlated subquery.
select * from da06emp d where salary= (select max(salary) from da06emp e where e.deptid=d.deptid group by e.deptid);


