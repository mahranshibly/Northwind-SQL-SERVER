DECLARE @BusinessEntityID as INT;
DECLARE @BusinessName as NVARCHAR(50);
 
DECLARE @BusinessCursor as CURSOR;
 
SET @BusinessCursor = CURSOR FOR
SELECT BusinessEntityID, Name
 FROM Sales.Store;
 
OPEN @BusinessCursor;
FETCH NEXT FROM @BusinessCursor INTO @BusinessEntityID, @BusinessName;
 
WHILE @@FETCH_STATUS = 0
BEGIN
 PRINT cast(@BusinessEntityID as VARCHAR (50)) + ' ' + @BusinessName;
 FETCH NEXT FROM @BusinessCursor INTO @BusinessEntityID, @BusinessName;
END
 
CLOSE @BusinessCursor;
DEALLOCATE @BusinessCursor;
