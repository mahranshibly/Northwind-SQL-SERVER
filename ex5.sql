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


/*

  more info:
  "OrderDetails.Discount" column's records values look like : 0.XX   
  so..  XX% discount per product in a order.
  Quantity * UnitPrice   >>>  as TotalAmountBeforeDiscount.
  Quantity * UnitPrice *  Discount  >>>  as TotalDiscount.
  Quantity * UnitPrice * ( 1 - Discount )  >>>  as TotalAmountAfterDiscount.
 
  
  NOT !!!...
  Quantity *  Discount  >>>  as TotalDiscount. 
  Quantity * (UnitPrice - Discount )  >>>  as TotalAmountAfterDiscount.
*/
