
--* Mahran sh. *--



DECLARE @EntityID as INT;
DECLARE @Name as NVARCHAR(50);
 
DECLARE @InfoCursor as CURSOR;
 
SET @InfoCursor = CURSOR FOR
SELECT EntityID, Name
 FROM Sales.Store;
 
OPEN @InfoCursor;
FETCH NEXT FROM @InfoCursor INTO @EntityID, @Name;
 
WHILE @@FETCH_STATUS = 0
BEGIN
 PRINT cast(@EntityID as VARCHAR (50)) + ' ' + @Name;
 FETCH NEXT FROM @InfoCursor INTO @EntityID, @Name;
END
 
CLOSE @InfoCursor;
DEALLOCATE @InfoCursor;
