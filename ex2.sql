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

GROUP BY o.EmployeeID, e.FirstName, e.LastName; -- // GROUP BY o.EmployeeID (only on MySQL server).

/*
 -- more info
 SQL SERVER ERROR : "Column 'e.FirstName/e.LastName' is invalid in the select list because
 it is not contained in either an aggregate function or the GROUP BY clause." 
 
 I got this error when I tried to group only by id "GROUP BY o.EmployeeID" in MSSM-studio (SQL Server).
 Well, it's pretty simple when I think about what GROUP BY does, 
 so I just add 'e.FirstName , e.LastName' to the "GROUP BY" clause.
 But when I execute the same query by group only by id ("GROUP BY o.EmployeeID")
 in "MySQL-Workbench-Northwind" I didn't got any error, and I got the same list as expected.
 */

-- So, just to be sure.. I write another query, as ans part B (for MSSM-studio and MySQL-Workbench) 
-- to group only by id "GROUP BY o.EmployeeID".
-- one query for both servers. (SQL/MySQL) 
-- without any errors of First/Last-Name columns.
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
