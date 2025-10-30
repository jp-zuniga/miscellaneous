SELECT  e.BusinessEntityID                 AS EmpleadoID,
        pe.FirstName + ' ' + pe.LastName   AS Empleado,
        e.JobTitle                         AS Puesto,
        m.BusinessEntityID                 AS JefeID,
        pm.FirstName + ' ' + pm.LastName   AS Jefe
FROM HumanResources.Employee AS e
LEFT JOIN HumanResources.Employee AS m
       ON e.OrganizationNode.GetAncestor(1) = m.OrganizationNode
JOIN Person.Person AS pe
       ON pe.BusinessEntityID = e.BusinessEntityID
LEFT JOIN Person.Person AS pm
       ON pm.BusinessEntityID = m.BusinessEntityID
ORDER BY Jefe, Empleado;
