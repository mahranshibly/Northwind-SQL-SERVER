-- Created by Mahran Shibly, 29/9/2019

-- SQL query deletes the column (if exists) from the table.
ALTER TABLE Orders
DROP COLUMN if EXISTS TotalAmountAfterDiscount;
GO

-- Ex 7
-- SQL query adds a column "TotalAmountAfterDiscount" to the "Orders" table.
 
-- Column data-type : DECIMAL

ALTER TABLE Orders 
ADD TotalAmountAfterDiscount DECIMAL(10, 2);
