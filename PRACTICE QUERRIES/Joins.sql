--Task 1. What is the total sales amount for each customer?
select Customers.CustomerName, sum(Orders.Total) as totalsales
from Customers left join Orders
on Orders.CustomerID=Customers.CustomerID
group by Customers.CustomerID,Customers.CustomerName

--Task 2. Which product has the highest sales quantity?
select top 1 Products.ProductName, sum(Orders.Quantity) as qtytotal
from Orders join Products 
on Orders.ProductID=Products.ProductID
group by Products.ProductName, Products.ProductID
order by qtytotal desc

--Task 3. What is the total revenue generated from each product?
select Products.ProductName, sum(Orders.Total) as totalrevenue
from Products
left join Orders
on Orders.ProductID=Products.ProductID
group by Products.ProductName

--Task 4. How many orders were placed on each date?
select Orders.OrderDate,COUNT(Orders.OrderID)
from Orders
group by OrderDate

--Task 5. Who are the top 3 customers in terms of total sales amount?
select top 3 Customers.CustomerName, sum(Orders.Total) as totalsales
from Customers 
left join Orders
on Orders.CustomerID=Customers.CustomerID
group by Customers.CustomerName 
order by totalsales desc


