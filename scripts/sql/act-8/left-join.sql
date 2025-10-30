SELECT  t.TerritoryID,
        t.Name                   AS Territorio,
        p.FirstName + ' ' + p.LastName AS Vendedor,
        sp.SalesQuota,
        sp.Bonus
FROM Sales.SalesTerritory AS t
LEFT JOIN Sales.SalesPerson      AS sp ON sp.TerritoryID = t.TerritoryID
LEFT JOIN Person.Person          AS p  ON p.BusinessEntityID = sp.BusinessEntityID
ORDER BY t.Name;
