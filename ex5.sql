-- Created by Mahran Shibly, 29/9/2019

-- SQL query: deletes the function (if exists).
DROP FUNCTION IF EXISTS Ex5_ScalarFunc;
GO

-- Ex 5
/*
 Creat a Scalar-function returns the total_amount_after_discount for all orders,
 by given a specific customer... ['CustomerID'] 
 and a specific year as 4 chars yyyy format... [ YEAR('Orderdate')]
*/

-- PARAMS : @customer_id VARCHAR(5) >>> Orders.CustomerID (FK,NCHAR(5),null)
-- PARAMS : @orders_year VARCHAR(4) >>>  4 chars, yyyy% format.			

-- RETURNS : DECIMAL(10, 2)

-- PARAM : @orders_year VARCHAR(4) can have type DATETIME, 
-- with "almost" same simple impl. as in this file.
-- thanks.

CREATE FUNCTION Ex5_ScalarFunc(
	@customer_id VARCHAR(5),
	@orders_year VARCHAR(4)
)
RETURNS DECIMAL(20, 2)
AS 
BEGIN
	RETURN (
		select SUM(Quantity*UnitPrice*(1-Discount)) 
		from OrderDetails 
		WHERE OrderID IN (
			select OrderID From Orders 
			WHERE CustomerID = @customer_id 
			AND OrderDate like CONCAT('%',@orders_year,'%')
		)
	);
END;
-- more-info : "OrderDetails.Discount" all column's values look like 0.xx so its should be XX% discount per order/product
