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
  1.
  What I did in the interview it wasnt correct.
  I thought the discount field is a value (not as precents %) per price)
   explain :
  "OrderDetails.Discount" all column's values look like 0.xx so its should be XX% discount per order/product
   
  Quantity * UnitPrice   >>>  as TotalAmountBeforeDiscount.
  Quantity * UnitPrice *  Discount  >>>  as TotalDiscount.
  Quantity * UnitPrice * ( 1 - Discount )  >>>  as TotalAmountAfterDiscount.

  #NOT :
  Quantity *  Discount  >>>  as TotalDiscount. 
  Quantity * (UnitPrice - Discount )  >>>  as TotalAmountAfterDiscount.
  
  2. 
  PARAM : @orders_year VARCHAR(4) can have type DATETIME, 
  function with "almost" same simple impl. as in this file.
  
  thanks.
*/
