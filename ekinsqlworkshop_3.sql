--1
SELECT Customers.CompanyName, Customers.ContactName, Orders.OrderID, Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
--2
SELECT Suppliers.CompanyName, Products.ProductName
FROM Suppliers
LEFT JOIN Products ON Suppliers.SupplierID = Products.SupplierID
--3
SELECT Orders.OrderID, CONCAT(Employees.FirstName, ' ', Employees.LastName) AS "Employee", Orders.OrderDate
FROM Orders
LEFT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
--4
SELECT Customers.CompanyName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
--5
SELECT Products.ProductName, Categories.CategoryName
FROM Products
CROSS JOIN Categories
--6
SELECT Customers.CompanyName, Orders.OrderID, Orders.OrderDate, CONCAT(Employees.FirstName, ' ', Employees.LastName) as "Employee"
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
LEFT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE strftime('%Y', Orders.OrderDate) = '2017'
--7
SELECT Customers.CompanyName, COUNT(Orders.OrderID) AS Adet
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName
HAVING COUNT(Orders.OrderID) > 5
order by Adet
--8
SELECT Products.ProductName, SUM(od.Quantity) AS TotalSold, 
       ROUND(SUM(od.Quantity * od.UnitPrice)) AS TotalRevenue
FROM 'Order Details' AS od
JOIN Products ON od.ProductID = Products.ProductID
GROUP BY Products.ProductName
--9
SELECT Customers.CompanyName, Orders.OrderID
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CompanyName LIKE 'B%'
--10
SELECT Categories.CategoryName, Products.ProductName
FROM Categories
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.ProductName IS NULL
--11
SELECT CONCAT(e1.Title, ' _ ', e1.TitleOfCourtesy, ' ', e1.FirstName, ' ', e1.LastName) AS Employee, CONCAT(e2.Title, ' _ ', e2.TitleOfCourtesy, ' ', e2.FirstName, ' ', e2.LastName) AS Superior
FROM Employees AS e1
JOIN Employees AS e2 ON e1.ReportsTo = e2.EmployeeID
--12
SELECT c.CategoryName, p.productname, MAX(p.UnitPrice) AS MaxPrice
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY MaxPrice DESC
--13
SELECT Orders.OrderID, od.*
FROM Orders
JOIN 'Order Details' as od ON Orders.OrderID = od.OrderID
ORDER BY Orders.OrderID
--14
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) as Employee, COUNT(Orders.OrderID) AS OrdersProcessed
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employee
--15
SELECT p1.ProductName AS LowerPriceProduct, p2.ProductName AS HigherPriceProduct
FROM Products p1, Products p2
WHERE p1.CategoryID = p2.CategoryID AND p1.UnitPrice < p2.UnitPrice
--16
SELECT Suppliers.CompanyName, MAX(Products.UnitPrice) AS MaxPriceProduct
FROM Suppliers
JOIN Products ON Suppliers.SupplierID = Products.SupplierID
GROUP BY Suppliers.CompanyName
--17
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) as Employee, MAX(Orders.OrderDate) AS LastOrderDate
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employee
--18
SELECT COUNT(*) AS CountOver20
FROM Products
WHERE UnitPrice > 20
--19
SELECT Customers.CompanyName, Orders.OrderDate, Orders.OrderID
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderDate BETWEEN '2019-01-01' AND '2019-12-31'
--20
SELECT Customers.CompanyName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL