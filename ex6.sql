-- Created by Mahran Shibly, 29/9/2019

-- SQL query deletes the function (if exists).
DROP FUNCTION IF EXISTS Ex6_ScalarFunc;
GO

-- Ex 6
-- Creat a Scalar-function returns the total_amount_after_discount for a specific order.
 
/*
 my ans:
 By creating @OrderID as function-param, with data-type as same as the "OrderDetails.OrderID" type.
 And now by a specific order-id we can calc the sum (total amount after discount)
 of all the records with the same "OrderID" (in the "OrderDetails" table).
*/

-- PARAMS : @order_id INT    >>> "OrderDetails.OrderID" : PK, FK, INT, not null
-- RETURNS : DECIMAL(10, 2)

CREATE FUNCTION Ex6_ScalarFunc(
	@order_id INT  
)
RETURNS DECIMAL(10, 2)
AS 
BEGIN
    	RETURN (
		select SUM(Quantity*UnitPrice*(1-Discount)) 
		from OrderDetails 
		WHERE OrderID = @order_id
	);
END;


/*
  more info...
  "OrderDetails.Discount" column's records values look like : 0.XX   
  so..  XX% discount per order.
  Quantity * UnitPrice   >>>  as TotalAmountBeforeDiscount.
  Quantity * UnitPrice *  Discount  >>>  as TotalDiscount.
  Quantity * UnitPrice * ( 1 - Discount )  >>>  as TotalAmountAfterDiscount.
 
  Wrong impl. in my interview!!!...
  Quantity *  Discount  >>>  as TotalDiscount. 
  Quantity * (UnitPrice - Discount )  >>>  as TotalAmountAfterDiscount.
*/
