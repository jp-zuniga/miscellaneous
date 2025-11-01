select t.TerritoryID,
       t.Name                         as Territorio,
       p.FirstName + ' ' + p.LastName as Vendedor,
       sp.SalesQuota,
       sp.Bonus
from Sales.SalesTerritory   as t
left join Sales.SalesPerson as sp on sp.TerritoryID     = t.TerritoryID
left join Person.Person     as p  on p.BusinessEntityID = sp.BusinessEntityID
order by t.Name;
