

DECLARE @var1 VARCHAR(100)
DECLARE @var2 VARCHAR(100)
DECLARE @var3 VARCHAR(100)
DECLARE @var4 VARCHAR(100)

DECLARE @cur1 CURSOR
DECLARE @cur2 CURSOR
DECLARE @cur3 CURSOR
DECLARE @cur4 CURSOR

SET @cur1 = CURSOR FAST_FORWARD READ_ONLY FOR 
SELECT FirstName FROM dbo.Employees
OPEN @cur1 FETCH NEXT FROM @cur1 INTO @var1
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @cur2 = CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT LastName FROM dbo.Employees 
	OPEN @cur2 FETCH NEXT FROM @cur2 INTO @var2
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		SET @cur3 = CURSOR FAST_FORWARD READ_ONLY FOR
		SELECT FirstName FROM dbo.Employees
		OPEN @cur3 FETCH NEXT FROM @cur3 INTO @var3
		WHILE @@FETCH_STATUS = 0
		BEGIN
	    
			SET @cur4 = CURSOR FAST_FORWARD READ_ONLY FOR
			SELECT LastName FROM dbo.Employees
			OPEN @cur4 FETCH NEXT FROM @cur4 INTO @var4
			WHILE @@FETCH_STATUS = 0
			BEGIN
	    
				PRINT (@var1+'_'+@var2+'_'+@var3+'_'+@var4)
	
			FETCH NEXT FROM @cur4 INTO @var4
			END
		FETCH NEXT FROM @cur3 INTO @var3
		END
	FETCH NEXT FROM @cur2 INTO @var2
	END
FETCH NEXT FROM @cur1 INTO @var1
END

CLOSE @cur1 DEALLOCATE @cur1
CLOSE @cur2 DEALLOCATE @cur2
CLOSE @cur3 DEALLOCATE @cur3
CLOSE @cur4 DEALLOCATE @cur4
