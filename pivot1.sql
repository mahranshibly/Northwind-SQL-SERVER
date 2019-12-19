DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';
 
-- select the category names
SELECT 
    @columns+=QUOTENAME(CategoryName) + ','
FROM 
    dbo.Categories
ORDER BY 
    categoryname;
 
-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);
PRINT @columns
-- construct dynamic SQL
SET @sql ='
SELECT * FROM   
(
    SELECT 
        categoryname, 
        productid 
    FROM 
        dbo.products p
        INNER JOIN dbo.categories c 
            ON c.categoryid = p.categoryid
) t 
PIVOT(
    COUNT(productid) 
    FOR categoryname IN ('+ @columns +')
) AS pivot_table;';
 
-- execute the dynamic SQL
EXECUTE sp_executesql @sql;
