SELECT  e.BusinessEntityID       AS EmpleadoID,
        pp.FirstName + ' ' + pp.LastName AS Empleado,
        e.JobTitle               AS Puesto,
        sp.SalesQuota,
        sp.Bonus
FROM Sales.SalesPerson AS sp
RIGHT JOIN HumanResources.Employee AS e
       ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Person.Person AS pp
       ON pp.BusinessEntityID = e.BusinessEntityID
ORDER BY Empleado;
