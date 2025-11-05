select * from Empleado;

select count(DepartamentoID) as NumeroEmpleados
from Empleado;

select max(DepartamentoID) as MaxDept,
       count(*)            as NumEmpleados
from Empleado;

--select DepartamentoID,
--       count(*) as NumEmpleados
--from Empleado
--order by DepartamentoID
--having NumEmpleados > 5;

update Empleado
set nombre = 'Inti Montalvan'
where EmpleadoID = 1;

delete from Empleado where EmpleadoID = 2;
