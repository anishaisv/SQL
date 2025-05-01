SELECT Customers.CustomerName, 
SUM(Orders.Total) AS TotalSales
FROM Orders
JOIN Customers ON Customers.CustomerID=Orders.CustomerID 
group by Customers.CustomerID, Customers.CustomerName
;

