DECLARE @CurrentID INT, @CurrentString VARCHAR(100);
 
DECLARE cursor_results CURSOR FOR
  SELECT MyID, MyString
  FROM dbo.MyTable;
 
OPEN cursor_results
FETCH NEXT FROM cursor_results into @CurrentID, @CurrentString
WHILE @@FETCH_STATUS = 0
BEGIN 
 
  /* Do something with your ID and string */
    EXEC dbo.MyStoredProcedure @CurrentID, @CurrentString;
 
FETCH NEXT FROM cursor_results into @CurrentID, @CurrentString
END
 
/* Clean up our work */
CLOSE cursor_results;
DEALLOCATE cursor_results;
