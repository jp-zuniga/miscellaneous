-- init:
create table Departamento (
	DepartamentoID int primary key not null,
	DepartamentoNombre varchar(50)
);

create table Empleado (
	EmpleadoID int primary key not null,
	nombre varchar(50),
	DepartamentoID int not null,
	salario decimal(10, 2)
		foreign key (DepartamentoID)
		references Departamento(DepartamentoID)
);

-- init 2:
insert into Departamento(DepartamentoID, DepartamentoNombre)
values
(10, 'Recursos Humanos'),
(20, 'Finanzas');

insert into Empleado (EmpleadoID, Nombre, DepartamentoID, Salario)
values
(1, 'Juan Perez', 10, 3000.00),
(2, 'Ana Lopez', 20, 4000.00),
(3, 'Luis Garcia', 10, 3500.00);

--

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
select EmpleadoID, Nombre from Empleado;
select EmpleadoID, DepartamentoID from Empleado;
