select DepartmentID,
       count(BusinessEntityID) as Cantidad
from HumanResources.EmployeeDepartmentHistory
group by DepartmentID
  having count(BusinessEntityID) > 10
order by Cantidad desc;
