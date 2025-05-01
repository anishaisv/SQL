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
