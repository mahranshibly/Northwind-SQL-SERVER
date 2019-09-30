-- Created by Mahran Shibly, 29/9/2019

-- SQL query deletes the trigger (if exists).
DROP TRIGGER IF EXISTS TotalAmountAfterDiscount_trigger;
GO

-- Ex 8
-- Ctreate a trigger on "OrderDetails" table for updating the field 
-- "TotalAmountAfterDiscount" in the "Orders" table.


CREATE TRIGGER TotalAmountAfterDiscount_trigger 
ON OrderDetails
AFTER UPDATE, INSERT, DELETE -- trigger events
AS
DECLARE @order_id INT -- var, type int
IF EXISTS (SELECT * FROM inserted) 
	-- event : 'INSERT' or 'UPDATE' , "OrderDetails" table.
	BEGIN		
		SELECT @order_id = OrderID FROM inserted; -- init var with the "OrderID" of the inserted-record.   
		
		UPDATE Orders -- update field "TotalAmountAfterDiscount" in "Orders" table where "OrderID" is equals to var.
		SET TotalAmountAfterDiscount =  
			( Select dbo.Ex6_ScalarFunc(@order_id) )
			-- Call func-ex6 with order-id to calc the total-amount-after-discount 
			-- for all records at the "OrderDetails" table with the same @order_id (var).
		WHERE OrderID = @order_id;
	END
	
IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)  
	--==-- event: 'DELETED', "OrderDetails" table.
	BEGIN 
		
		SELECT @order_id = OrderID FROM deleted; -- init var with the "OrderID" of the deleted-record.
		
		-- calc the new total, if there other records.
		-- any other records in "OrderDetails" with the same order-id (the id of the deleted row) 
		IF exists(SELECT * FROM OrderDetails WHERE OrderID = @order_id)
				UPDATE Orders 
				SET TotalAmountAfterDiscount = 
					( Select dbo.Ex6_ScalarFunc(@order_id) )
				WHERE OrderID = @order_id;

		-- else, if no other records in "OrderDetails" with the same "OrderID"		
		-- (the case of a order with a single product maybe, order with only one record in order-details table )
		-- so we can automaticly set the total "TotalAmountAfterDiscount" to zero 0.
		--== my extra : //OR// we can delete the order (row) from 'Orders' table can instade setting the total to zero. 
		ELSE
			UPDATE Orders  				--== DELETE
			SET TotalAmountAfterDiscount = 0.0  	--== FROM Orders
			WHERE OrderID = @order_id; 		--== WHERE OrderID = @order_id;
END

/*
 more info: 
 I call my scalar-function (Ex-6) from the trigger statement,
 with the specific "OrderID" as func-args, via the changes in the "OrderDetails" 
 table; by selecting the @OrderID from the inserted/deleted tables.
 To update the field "TotalAmountAfterDiscount" with the func-returned-value,  
 and just in one record from the "Orders" table (with the same "OrderID"). 
 
 In MySQL server to fire Trigger for Delete, Insert and Update You have to create more than one trigger, 
 but you can move the common code into a stored-procedure and have them all call the procedure.
 Link : https://stackoverflow.com/questions/1318224/mysql-fire-trigger-for-both-insert-and-update
*/
