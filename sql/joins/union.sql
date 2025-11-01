select sp.Name as EstadoProvincia
from Sales.SalesOrderHeader as h
join Person.Address as a
  on h.BillToAddressID = a.AddressID
join Person.StateProvince as sp
  on a.StateProvinceID = sp.StateProvinceID
union
select sp.Name
from Sales.SalesOrderHeader as h
join Person.Address as a
  on h.ShipToAddressID = a.AddressID
join Person.StateProvince as sp
  on a.StateProvinceID = sp.StateProvinceID
order by EstadoProvincia;
