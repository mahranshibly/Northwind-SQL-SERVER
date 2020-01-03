SELECT * FROM dbo.Customers c
INNER JOIN dbo.Customers1 c1
ON c.CustomerID=c1.CustomerID

UNION

SELECT * FROM dbo.Customers c
LEFT JOIN dbo.Customers1 c11
ON c.CustomerID=c.CustomerID
WHERE c11.CustomerID IS NULL
