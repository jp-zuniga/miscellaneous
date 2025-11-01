select d.Name as Departamento,
       s.Name as Turno
from HumanResources.Department as d
cross join HumanResources.Shift as s
order by Departamento, Turno;
