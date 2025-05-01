SELECT top 1 Products.ProductName, SUM(Orders.Quantity) AS TotalQuantity 
FROM Orders JOIN Products 
ON Orders.ProductID= Products.ProductID 
group by Products.ProductName order by TotalQuantity desc