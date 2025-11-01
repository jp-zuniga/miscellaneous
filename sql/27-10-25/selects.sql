-- reflexividad:
select EmpleadoID, Nombre from Empleado;

-- aumentatividad:
select EmpleadoID,
       DepartamentoID,
       Nombre,
       Salario
from Empleado;

-- transitividad:
select e.EmpleadoID,
       e.Nombre,
       d.DepartamentoNombre
from Empleado as e
join Departamento d
  on e.DepartamentoID = d.DepartamentoID;

-- descomposicion:
select EmpleadoID, Nombre         from Empleado;
select EmpleadoID, DepartamentoID from Empleado;
