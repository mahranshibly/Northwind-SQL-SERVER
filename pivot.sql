DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';
 
-- select the category names
SELECT 
    @columns+=QUOTENAME(ProductName) + ','
FROM 
    dbo.Products
ORDER BY 
    ProductName;
 
-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);
PRINT @columns
-- construct dynamic SQL
SET @sql ='
SELECT * FROM   
(
    SELECT 
		year(o.orderdate) AS [Year\Product],
        od.quantity,
		p.productname
    FROM dbo.[orders] o
    INNER JOIN dbo.[order details] od
		ON o.orderid = od.orderid
	INNER JOIN dbo.[products] p 
        ON od.productid = p.productid
) t 
PIVOT(
    sum(quantity) 
    FOR productname IN ('+ @columns +')
) AS pivot_table;';
 
-- execute the dynamic SQL
EXECUTE sp_executesql @sql;
