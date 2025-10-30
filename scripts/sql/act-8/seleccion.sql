SELECT SalesOrderID     AS OrdenID,
       OrderDate        AS Fecha,
       TotalDue         AS Total
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1 AND TotalDue > 3000;
