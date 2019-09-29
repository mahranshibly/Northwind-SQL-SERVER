-- Created by Mahran Shibly, 29/9/2019

-- SQL query deletes the trigger (if exists).
DROP TRIGGER IF EXISTS TotalAmountAfterDiscount_trigger;
GO

-- Ex 8
-- Ctreate a trigger on "OrderDetails" table for updating the field 
-- "TotalAmountAfterDiscount" in the "Orders" table.


CREATE TRIGGER TotalAmountAfterDiscount_trigger 
ON OrderDetails
AFTER UPDATE, INSERT, DELETE
AS
DECLARE @order_id INT

IF exists(SELECT * FROM inserted)
	--==-- event: 'INSERT' or 'UPDATE' , "OrderDetails" table.
	BEGIN		
		
		SELECT @order_id = OrderID FROM inserted;
		-- after update/insert in "OrderDetails" table, calc the new total.
		-- calc all records with the same "OrderID" in "OrderDetails" table.
		UPDATE Orders 
		SET TotalAmountAfterDiscount = 
			( Select dbo.Ex6_ScalarFunc(@order_id) )
		WHERE OrderID = @order_id;
	END
	
IF NOT exists(SELECT * FROM inserted) AND exists(SELECT * FROM deleted)  
	
	--==-- event: 'DELETED', "OrderDetails" table.
	BEGIN 
		
		SELECT @order_id = OrderID FROM deleted;
		
		-- calc the new total, if there other records (another products in the same order !!!) 
		-- records with the same OrderID (id from the deleted row in "OrderDetails" table) 
		IF exists(SELECT * FROM OrderDetails WHERE OrderID = @order_id)
				UPDATE Orders 
				SET TotalAmountAfterDiscount = 
					( Select dbo.Ex6_ScalarFunc(@order_id) )
				WHERE OrderID = @order_id;

		-- else, if its no other records in "OrderDetails" with the same "OrderID"		
		-- (the case of a order with a single product, order with only one record in order-details table )
		-- so after delete it.. we can automaticly set the total (TotalAmountAfterDiscount) to zero 0.
		--==-- my extra : //OR// we can delete the order (row) from 'Orders' table can instade setting the total to zero. 
		ELSE
			/*DELETE FROM Orders WHERE OrderID = @order_id;*/
			UPDATE Orders 
			SET TotalAmountAfterDiscount = 0.0 
			WHERE OrderID = @order_id;
END

/*
 more info: 
 I call my scalar-function (Ex-6) from the trigger statement,
 with the specific "OrderID" as func-args, via the changes in the "OrderDetails" 
 table; by selecting the @OrderID from the inserted/deleted tables.
 To update the field "TotalAmountAfterDiscount" with the func-returned-value,  
 and just in one record from the "Orders" table (with the same "OrderID"). 
*/
