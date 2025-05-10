-- ===============================================
-- DATABASE: User Data Analysis and Joins Practice
-- Description: Sample SQL queries for practicing
-- GRouping, Aggregate function, joins, and more
-- ===============================================

-- ================================
-- SECTION 1: User Data Analysis
-- ================================

-- View all user data
SELECT * FROM user_data;

-- Account names and followers, sorted by followers (highest first)
SELECT Account_Name, Followers
FROM user_data
ORDER BY Followers DESC;

-- Female users who joined before 2020
SELECT Account_Name
FROM user_data
WHERE Gender = 'Female' AND Date_Joined < '2020-01-01';

-- Accounts with more than 100 posts but fewer than 500 likes
SELECT Account_Name, Posts, Likes
FROM user_data
WHERE Posts > 100 AND Likes < 500;

-- Count users who joined after 2020
SELECT COUNT(*) AS User_Count
FROM user_data
WHERE Date_Joined > '2020-01-01';

-- Total likes grouped by gender
SELECT Gender, SUM(Likes) AS Total_Likes
FROM user_data
GROUP BY Gender;

-- Total number of posts
SELECT SUM(Posts) AS Total_Posts
FROM user_data;

-- Average likes for users with more than 200 followers
SELECT AVG(Likes) AS Avg_Likes
FROM user_data
WHERE Followers > 200
GROUP BY Followers;

-- Top 3 accounts by number of likes
SELECT TOP 3 Account_Name, Likes
FROM user_data
ORDER BY Likes DESC;

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
-- SECTION 3: Joins Practice
-- ================================

-- Example 1: Join Users with their Posts and Likes information
SELECT u.Account_Name, u.Followers, p.Posts, p.Likes
FROM user_data u
JOIN posts p ON u.Account_Name = p.Account_Name
ORDER BY u.Followers DESC;

-- Example 2: Join Customers with their Orders and Products (Sales Data)
SELECT c.CustomerName, o.OrderDate, p.ProductName, o.Quantity, o.Total
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
ORDER BY o.OrderDate DESC;

-- Example 3: Join Users and Departments (Hypothetical example based on departments)
SELECT u.Account_Name, d.DeptName
FROM user_data u
JOIN departments d ON u.DeptID = d.DeptID
ORDER BY u.Account_Name;
