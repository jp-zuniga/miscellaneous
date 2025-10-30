SELECT h.SalesOrderID        AS OrdenID,
       t.Name                AS Territorio,
       sm.Name               AS MetodoEnvio,
       d.ProductID,
       p.Name                AS Producto,
       d.OrderQty            AS Cantidad
FROM Sales.SalesOrderHeader AS h
JOIN Sales.SalesTerritory   AS t  ON h.TerritoryID   = t.TerritoryID
JOIN Purchasing.ShipMethod  AS sm ON h.ShipMethodID  = sm.ShipMethodID
JOIN Sales.SalesOrderDetail AS d  ON d.SalesOrderID  = h.SalesOrderID
JOIN Production.Product     AS p  ON p.ProductID     = d.ProductID;
