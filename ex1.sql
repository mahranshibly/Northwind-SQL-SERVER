-- created by Mahran Shibly, 29/9/2019

-- Ex 1
-- Write a query that returns a list of all orders
-- made by customers from Germany and by an employee named "Suyama"
-- The list will show the customer number, customer name, and order number, sorted by order number.

/*
 The following SQL returns a list with 3 columns : 
 [CustomerID , CustomerName , OrderID]
 by joining 3 tables : [Orders, Customers, Employees] 
 with PK and FK ( "CustomerID" / "EmployeeID").
 to get all the orders with "Customers.Country" equals to 'Germany'
 and "Employees.Name" equals to 'Suyama', 
 (can be Last/First-Name cond. or both with : OR ). 
 finally, the list orderd by "Orders.OrderID" 
 
*/

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