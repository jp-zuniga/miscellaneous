SELECT d.Name AS Departamento,
       s.Name AS Turno
FROM HumanResources.Department AS d
CROSS JOIN HumanResources.Shift AS s
ORDER BY Departamento, Turno;
