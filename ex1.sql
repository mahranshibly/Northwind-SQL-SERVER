-- created by Mahran Shibly, 29/9/2019
-- Ex 1
-- Write a query that returns a list of all orders
-- made by customers from Germany and by an employee named "Suyama"
-- The list will show the customer number, customer name, and order number, sorted by order number.

SELECT 	o.CustomerID , 
	c.CompanyName AS CustomerName , 
	o.OrderID 
FROM Orders AS o

INNER JOIN Customers AS c
ON o.CustomerID=c.CustomerID 
AND c.Country = 'Germany' -- // c.Country LIKE 'Germany'

INNER JOIN Employees AS e
ON o.EmployeeID=e.EmployeeID 
AND e.LastName = 'Suyama' -- // e.LastName LIKE 'Suyama'

ORDER BY o.OrderID;
