
-- created by Mahran Shibly, 29/9/2019

-- Ex 2
-- Write a query that returns a list of the amount of orders for each employee,
-- The list will show the employee id, employee name and number of orders amount.

/*
 The following SQL returns a list with 3 columns : 
 [ EmployeeID, EmployeeName(first+last), EmployeeOrders(count)] ,
 by joining 2 tables : [Orders, Employees] with PK and FK ("EmployeeID"), 
 just to get the employee-name.
 And via the "Orders" table we can count the orders ("OrderID") for every employee,
 and only the orders that he has did, by grouping the count with his id "EmployeeID".
*/

-- ANS : A
SELECT 	o.EmployeeID , 
	CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName , 
	COUNT(o.OrderID) AS EmployeeOrders

FROM Orders AS o

INNER JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID 

GROUP BY o.EmployeeID, e.FirstName, e.LastName; -- // GROUP BY o.EmployeeID (no error only on MySQL server).

-- Just to be sure.. I write another query, as ans part B (for MSSM-studio and MySQL-Workbench) 
-- to group only by id "GROUP BY o.EmployeeID".
-- one query for both servers. (SQL/MySQL) 
-- without any errors of First/Last-Name columns in the group by.
-- both queries A & B execute the same list (with diff impl.).

-- ANS : B
SELECT 	o.EmployeeID , 
	CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName ,
	o.EmployeeOrders

FROM Employees AS e

INNER JOIN (
	SELECT 	EmployeeID , 
		COUNT(OrderID) AS EmployeeOrders 
	FROM  Orders
	GROUP BY EmployeeID -- for MSSM-studio and MySQL-Workbench
) AS o

ON o.EmployeeID=e.EmployeeID;
