select e.BusinessEntityID               as EmpleadoID,
       pp.FirstName + ' ' + pp.LastName as Empleado,
       e.JobTitle                       as Puesto,
       sp.SalesQuota,
       sp.Bonus
from Sales.SalesPerson as sp
right join HumanResources.Employee as e
  on sp.BusinessEntityID = e.BusinessEntityID
join Person.Person as pp
  on pp.BusinessEntityID = e.BusinessEntityID
order by Empleado;
