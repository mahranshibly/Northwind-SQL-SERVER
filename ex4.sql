
-- Created by Mahran Shibly, 29/9/2019

-- EX 4
-- Write a query that returns a matrix that will show 
-- for each customer and for each year, the number of orders each month.
-- The list will include customer number, year, number of orders in month 1,
-- number of orders in month 2, and so on until 12, and total orders throughout the year.
-- The should be list sorted by customer name and year.

SELECT	
	(CASE WHEN t.CustomerID IS NULL THEN '_All-Customers_' ELSE t.CustomerID END) AS CustomerID ,
	(CASE WHEN c.CompanyName IS NULL THEN '_All-Customers_' ELSE c.CompanyName END) AS CustomerName , 
	(CASE WHEN t.yyyyFormat IS NULL THEN 'All-Years' ELSE t.yyyyFormat END) OrdersYear,
	SUM(CASE WHEN t.mmFormat = 01 THEN t.OrdersCount ELSE 0 END) AS Jan,
        SUM(CASE WHEN t.mmFormat = 02 THEN t.OrdersCount ELSE 0 END) AS Feb,
        SUM(CASE WHEN t.mmFormat = 03 THEN t.OrdersCount ELSE 0 END) AS Mar,
        SUM(CASE WHEN t.mmFormat = 04 THEN t.OrdersCount ELSE 0 END) AS Apr,
        SUM(CASE WHEN t.mmFormat = 05 THEN t.OrdersCount ELSE 0 END) AS May,
        SUM(CASE WHEN t.mmFormat = 06 THEN t.OrdersCount ELSE 0 END) AS Jun,
        SUM(CASE WHEN t.mmFormat = 07 THEN t.OrdersCount ELSE 0 END) AS Jul,
        SUM(CASE WHEN t.mmFormat = 08 THEN t.OrdersCount ELSE 0 END) AS Aug,
        SUM(CASE WHEN t.mmFormat = 09 THEN t.OrdersCount ELSE 0 END) AS Sep,
        SUM(CASE WHEN t.mmFormat = 10 THEN t.OrdersCount ELSE 0 END) AS Oct,
        SUM(CASE WHEN t.mmFormat = 11 THEN t.OrdersCount ELSE 0 END) AS Nov,
        SUM(CASE WHEN t.mmFormat = 12 THEN t.OrdersCount ELSE 0 END) AS Dece, -- syntax : SQL server [Dec] | MySQL server `Dec`
        SUM(t.OrdersCount) AS TotalOrders
	
	/* temp table as "t" finds order count for year and month for each customer by id*/
FROM (
	SELECT  CAST( CustomerID AS CHAR(20)) AS CustomerID,
		CAST(YEAR(OrderDate) AS CHAR(10)) AS yyyyFormat,
		MONTH(OrderDate) AS mmFormat,
		COUNT(*) AS OrdersCount
	FROM Orders
	GROUP BY CustomerID, YEAR(OrderDate), MONTH(OrderDate)
) AS t

Left JOIN Customers AS c 
ON t.CustomerID = c.CustomerID

GROUP BY t.CustomerID, c.CompanyName, t.yyyyFormat WITH ROLLUP

HAVING
c.CompanyName IS NOT NULL  -- to remove all nulls or duplicated records (joining tabels).
OR t.CustomerID IS NULL    -- my extra: to show all-customers  at all-years count per month as first row. 

ORDER BY c.CompanyName, OrdersYear; -- a list sorted by customer name and year!!!

-- I wish my extra is clear...
-- the t.CustomerID is NULL just in one case, 
-- by grouping all orders as null-customerid (all), 
-- and null-year (all) and valid month (not null).
-- in this way we can get one more record(full row) in the list,
-- counting the orders per month for All-Customers at All-Years!!!.
