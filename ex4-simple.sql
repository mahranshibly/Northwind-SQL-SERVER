
-- Created by Mahran Shibly, 29/9/2019

-- EX 4
-- Write a query that returns a matrix that will show 
-- for each customer and for each year, the number of orders each month.
-- The list will include customer number (id), year, number of orders in month 1,
-- number of orders in month 2, and so on until 12, and total orders throughout the year.
-- The should be list sorted by customer name and year.

-- just to be clear...
-- The list should be sorted by customer name and year!!!
-- but the name not selected!!! or I should select it also? or maybe sorted by name without selesct it.
-- so here i just select the id as customer and sorted by id.
-- another ver of ex4 with list sorted by customer name as requer in the question! 
-- with/without select it (by optional select-row-code by comment chars).
-- thanks. 
SELECT	
	(CASE WHEN t.CustomerID IS NULL THEN '_All-Customers_' ELSE t.CustomerID END) AS Customer,
	(CASE WHEN t.yyyyFormat IS NULL THEN 'All-Years' ELSE t.yyyyFormat END) AS OrdersYear,
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
        SUM(CASE WHEN t.mmFormat = 12 THEN t.OrdersCount ELSE 0 END) AS Dece,
        SUM(t.OrdersCount) AS TotalOrders

/* temp table as "t" finds order count for year and month for each customer */
FROM (
	SELECT  CAST( CustomerID AS CHAR(20)) AS CustomerID,
		CAST( YEAR(OrderDate) AS CHAR(10)) AS yyyyFormat,
		MONTH(OrderDate) AS mmFormat,
		COUNT(*) AS OrdersCount
	FROM Orders
	GROUP BY CustomerID, YEAR(OrderDate), MONTH(OrderDate)
)AS t

GROUP BY t.CustomerID, t.yyyyFormat WITH ROLLUP
		     
ORDER BY Customer, OrdersYear;
