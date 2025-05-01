SELECT OrderDate, COUNT(Quantity) AS OrderCount
FROM Orders
GROUP BY OrderDate;