--1
SELECT MAX(unitprice) from Products
order by unitprice ASC
--2
SELECT orderdate FROM Orders
ORDER BY shippeddate DESC
LIMIT 1
--3
SELECT * FROM Products 
WHERE unitprice > (SELECT AVG(unitprice) FROM Products)
--4
SELECT c.CategoryID, c.CategoryName, p.ProductName FROM Categories c
left JOIN Products p on c.CategoryID = p.CategoryID
--5
WITH max_price AS 
	(
    SELECT productid, productname, unitprice, categoryid
    FROM Products
    WHERE unitprice = (SELECT MAX(unitprice) FROM Products)
	)
SELECT categoryid, productid, productname, unitprice
FROM max_price
ORDER BY categoryid
--6
sELECT  Customers.CustomerID, Customers.CompanyName, CONCAT(Customers.ContactTitle, ' ', Customers.ContactName) AS ContactInfo FROM Customers
JOIN orders ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.ShipCountry = 'Mexico'
GROUP BY Customers.CustomerID
--7
SELECT Categories.CategoryName, Products.ProductName, Products.UnitPrice FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE Products.UnitPrice > (SELECT AVG(unitprice) FROM Products
GROUP BY Products.CategoryID)
ORDER BY categoryname
--8
SELECT * FROM Orders o WHERE orderdate = (SELECT MAX(orderdate) FROM Orders WHERE CustomerID = o.CustomerID)
--9
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalOrder
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalOrder DESC
LIMIT 1
--10
SELECT o.OrderID, o.CustomerID, o.OrderDate, SUM(od.Quantity) AS Quantity
FROM Orders o
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.CustomerID, o.OrderDate
HAVING SUM(od.Quantity) >= 10
--11
WITH MaxPriceCategory AS 
	(
    SELECT CategoryID, MAX(UnitPrice) AS MaxPrice
    FROM Products
    GROUP BY CategoryID
	)
SELECT AVG(p.UnitPrice) AS AvgMaxPrice
FROM Products p
JOIN MaxPriceCategory mp ON p.CategoryID = mp.CategoryID AND p.UnitPrice = mp.MaxPrice
--12
SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS TotalOrder
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalOrder DESC
--13
wITH CustomerOrderCounts AS (
    SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS TotalOrders, MAX(o.OrderDate) AS LastOrderDate
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CompanyName
)
SELECT CustomerID, CompanyName, TotalOrders, LastOrderDate
FROM CustomerOrderCounts
ORDER BY TotalOrders DESC
LIMIT 5
--14
SELECT categoryid, COUNT(*) FROM Products
GROUP BY categoryid
HAVING COUNT(*) > 15
--15
SELECT c.CustomerID, c.CompanyName, COUNT(DISTINCT od.ProductID) AS UniqueProducts
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(DISTINCT od.ProductID) <= 2
--16
SELECT s.supplierid,s.CompanyName from Suppliers s 
JOIN Products p on s.SupplierID=p.SupplierID 
GROUP By s.SupplierID
HAVING COUNT(p.ProductID)>3
--17
WITH CustomerMaxPrice AS 
	(
    SELECT o.CustomerID, od.ProductID, MAX(p.UnitPrice) AS MaxPrice
    FROM Orders o
    JOIN "Order Details" od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.CustomerID, od.ProductID
	)
SELECT c.CustomerID, c.CompanyName, p.ProductName, cmp.MaxPrice
FROM CustomerMaxPrice cmp
JOIN Customers c ON cmp.CustomerID = c.CustomerID
JOIN Products p ON cmp.ProductID = p.ProductID
WHERE (cmp.CustomerID, cmp.MaxPrice) IN 
	(
    SELECT CustomerID, MAX(MaxPrice)
    FROM CustomerMaxPrice
    GROUP BY CustomerID
	)
--18
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity * p.UnitPrice) AS TotalOrderValue
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN "Order Details" od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING SUM(od.Quantity * p.UnitPrice) > 10000
--19
WITH ProductOrderCounts AS 
	(
    SELECT p.ProductID, p.ProductName, p.CategoryID, SUM(od.Quantity) AS TotalOrdered
    FROM Products p
    JOIN "Order Details" od ON p.ProductID = od.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY p.ProductID, p.ProductName, p.CategoryID
	)
SELECT poc.CategoryID, p.ProductName, poc.TotalOrdered
FROM ProductOrderCounts poc
JOIN Products p ON poc.ProductID = p.ProductID
WHERE (poc.CategoryID, poc.TotalOrdered) IN 
	(
    SELECT CategoryID, MAX(TotalOrdered)
    FROM ProductOrderCounts
    GROUP BY CategoryID
	)
--20
SELECT DISTINCT c.CustomerID, c.CompanyName, p.ProductName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN "Order Details" od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate IN 
	(
    SELECT MAX(OrderDate)
    FROM Orders
    GROUP BY CustomerID
	)
--21
WITH OrderValues AS 
	(
    SELECT o.EmployeeID, o.OrderID, SUM(od.Quantity * p.UnitPrice) AS TotalOrderValue, o.OrderDate
    FROM Orders o
    JOIN "Order Details" od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.EmployeeID, o.OrderID, o.OrderDate
	)
SELECT e.EmployeeID, e.FirstName, e.LastName, ov.OrderID, ov.TotalOrderValue, ov.OrderDate
FROM OrderValues ov
JOIN Employees e ON ov.EmployeeID = e.EmployeeID
WHERE (ov.EmployeeID, ov.TotalOrderValue) IN 
	(
    SELECT EmployeeID, MAX(TotalOrderValue)
    FROM OrderValues
    GROUP BY EmployeeID
	)
--22
SELECT p.ProductID, p.ProductName, p.CategoryID, SUM(od.Quantity) AS TotalOrdered
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductID, p.ProductName, p.CategoryID
ORDER BY TotalOrdered DESC
LIMIT 1