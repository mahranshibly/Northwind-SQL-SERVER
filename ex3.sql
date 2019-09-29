 -- created by Mahran Shibly, 29/9/2019

-- Ex 3
-- Write a query that returns a list of all orders made by customers, by customer name and product name.
-- The list will show the customer id, customer name, product name, total befor discount, total discount,
-- and total after discount. Sorted by customer name and product name.

/*
  "OrderDetails.Discount" column's records values look like : 0.XX   so..  XX % discount.
  Quantity * UnitPrice * ( 1 - Discount )  >>>  as TotalAmountAfterDiscount.
  Quantity * UnitPrice *  Discount  >>>  as TotalDiscount.
*/

SELECT	o.CustomerID, c.CompanyName AS CustomerName, p.ProductName,
	SUM( od.Quantity * od.UnitPrice ) AS TotalAmountBeforDiscount , 
	SUM( od.Quantity*od.UnitPrice*od.Discount) AS TotalDiscount ,
	SUM( od.Quantity*od.UnitPrice*(1-od.Discount) ) AS TotalAmountAfterDiscount,
	COUNT(*) OrdersCount

FROM Orders AS o

INNER JOIN OrderDetails AS od 
ON o.OrderID = od.OrderID 

INNER JOIN Customers AS c 
ON o.CustomerID = c.CustomerID 

INNER JOIN Products AS p 
ON p.ProductID = od.ProductID

GROUP BY o.CustomerID, p.ProductID, c.CompanyName, p.ProductName
-- GROUP BY o.CustomerID, p.ProductID  -- /*only on MySQL server*/

ORDER BY CustomerName, ProductName;

/*
 more info...
 SQL SERVER ERROR : "Column 'c.CompanyName, p.ProductName' is invalid in the select list because
 it is not contained in either an aggregate function or the GROUP BY clause."  
 >>>
 I got this error when I tried to group by customer/product -id only, in MSSM-Studio (SQL Server).
 but in MySQL-Workbench-Northwind" I didn't got any errors, and I got the same list as expected.
 with less syntax... "GROUP BY o.CustomerID, p.ProductID" only.
 >>>
 so just to be sure that you will not have any syntax errors
 in case if you we don't have the same ver. of (SQL or MySQL Server)
 finally... the ans for both servers:
 "GROUP BY o.CustomerID, p.ProductID, c.CompanyName, p.ProductName"
 both queries will execute the same list as expected (SQL & MySQL).
*/
