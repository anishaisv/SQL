-- ======================================================
-- SCRIPT: Data Cleaning and Transformations in SQL
-- Description: Demonstrates data type conversions, 
--              dirty data identification, cleaning, 
--              and conditional logic in SQL.
-- ======================================================

-- ======================================================
-- SECTION 1: View Existing Tables
-- ======================================================
SELECT * FROM Products;
SELECT * FROM Orders;

-- ======================================================
-- SECTION 2: Data Type Conversions
-- ======================================================

-- 1. Convert product price from DECIMAL to INT
SELECT ProductID, ProductName, CAST(Price AS INT) AS RoundedPrice
FROM Products;

-- 2. Convert total order amount from DECIMAL to VARCHAR
SELECT OrderID, CAST(Total AS VARCHAR) AS TotalAsText
FROM Orders;

-- View data types before and after conversion using SQL_VARIANT_PROPERTY
SELECT 
    OrderID,
    Total,
    SQL_VARIANT_PROPERTY(Total, 'BaseType') AS BeforeDataType,
    CAST(Total AS VARCHAR(10)) AS TotalAsText,
    SQL_VARIANT_PROPERTY(CAST(Total AS VARCHAR(10)), 'BaseType') AS AfterDataType
FROM Orders;

-- ======================================================
-- SECTION 3: Create and Populate Customers Table (TempDB)
-- ======================================================

USE tempdb;

CREATE TABLE Customers (
    CustID INT,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    DOB DATE,
    Country VARCHAR(50),
    Phone VARCHAR(20)
);

INSERT INTO Customers VALUES
(1, 'John Doe', 'john@example.com', '1980-05-20', 'USA', '1234567890'),
(2, 'sara K', 'SARA@example.COM', NULL, 'usa', '9876543210'),
(3, 'M!ke 77', NULL, '1992-11-30', 'India', '99999'),
(4, 'Linda', 'linda@example.com', '1975-07-25', NULL, NULL),
(5, 'John Doe', 'john@example.com', '1980-05-20', 'USA', '1234567890'); -- duplicate

SELECT * FROM Customers;

-- ======================================================
-- SECTION 4: Identify Dirty Data
-- ======================================================

-- Find rows with NULLs in important fields
SELECT * FROM Customers WHERE Email IS NULL OR Country IS NULL;

-- Find duplicate entries
SELECT FullName, Email, COUNT(*)
FROM Customers
GROUP BY FullName, Email
HAVING COUNT(*) > 1;

-- Find invalid characters in names
SELECT * FROM Customers WHERE FullName LIKE '%[^a-zA-Z ]%';

-- Find inconsistent country casing
SELECT DISTINCT Country FROM Customers;

-- ======================================================
-- SECTION 5: Clean the Data
-- ======================================================

-- Update NULL countries to 'Unknown'
UPDATE Customers SET Country = 'Unknown' WHERE Country IS NULL;

-- Standardize country names to uppercase
UPDATE Customers SET Country = UPPER(Country);

-- Remove duplicate records (keep the lowest CustID)
DELETE FROM Customers
WHERE CustID NOT IN (
    SELECT MIN(CustID)
    FROM Customers
    GROUP BY FullName, Email
);

-- ======================================================
-- SECTION 6: Handle Strings and Invalid Characters
-- ======================================================

-- Trim and format names (example only, INITCAP is not native in all SQL engines)
SELECT TRIM(FullName) AS CleanName
--, INITCAP(FullName) AS ProperCase -- Uncomment if supported by your SQL version
FROM Customers;

-- Remove invalid characters from names
-- REGEXP_REPLACE syntax varies by SQL engine (works in PostgreSQL)
-- Replace with appropriate function for your SQL server
-- Example for PostgreSQL:
-- SELECT REGEXP_REPLACE(FullName, '[^a-zA-Z ]', '', 'g') AS CleanName FROM Customers;

-- For SQL Server:
-- SELECT FullName FROM Customers WHERE FullName LIKE '%[^a-zA-Z ]%' -- identification only

-- ======================================================
-- SECTION 7: Working with Dates
-- ======================================================

-- Calculate age from date of birth
-- SQL Server version (using DATEDIFF)
SELECT FullName, DOB,
       DATEDIFF(YEAR, DOB, GETDATE()) AS Age
FROM Customers
WHERE DOB IS NOT NULL;

-- PostgreSQL version:
-- SELECT FullName, DOB, EXTRACT(YEAR FROM AGE(CURRENT_DATE, DOB)) AS Age FROM Customers;

-- ======================================================
-- SECTION 8: Handling NULLs and Defaults
-- ======================================================

-- Replace NULL phone numbers with 'NA'
SELECT COALESCE(Phone, 'NA') AS PhoneNumber FROM Customers;

-- ======================================================
-- SECTION 9: Advanced CASE Logic – User Categories
-- ======================================================

-- Sample: Categorizing users based on followers and posts
SELECT 
    User_ID,
    Account_Name,
    User_Name,
    Followers,
    Posts,
    CASE
        WHEN Followers > 300 THEN 
            CASE
                WHEN Followers >= 400 THEN 'Special Influencer'
                ELSE 'Influencer'
            END
        WHEN Posts > 100 THEN 'Active User'
        ELSE 'Regular User'
    END AS User_Category
FROM user_data;
