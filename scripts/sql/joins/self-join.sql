select e.BusinessEntityID               as EmpleadoID,
       pe.FirstName + ' ' + pe.LastName as Empleado,
       e.JobTitle                       as Puesto,
       m.BusinessEntityID               as JefeID,
       pm.FirstName + ' ' + pm.LastName as Jefe
from HumanResources.Employee            as e
left join HumanResources.Employee       as m
  on e.OrganizationNode.GetAncestor(1) = m.OrganizationNode
join Person.Person as pe
  on pe.BusinessEntityID = e.BusinessEntityID
left join Person.Person as pm
  on pm.BusinessEntityID = m.BusinessEntityID
order by Jefe, Empleado;
