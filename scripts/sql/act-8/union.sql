SELECT sp.Name AS EstadoProvincia
FROM Sales.SalesOrderHeader AS h
JOIN Person.Address AS a
  ON h.BillToAddressID = a.AddressID
JOIN Person.StateProvince AS sp
  ON a.StateProvinceID = sp.StateProvinceID
UNION
SELECT sp.Name
FROM Sales.SalesOrderHeader AS h
JOIN Person.Address AS a
  ON h.ShipToAddressID = a.AddressID
JOIN Person.StateProvince AS sp
  ON a.StateProvinceID = sp.StateProvinceID
ORDER BY EstadoProvincia;
