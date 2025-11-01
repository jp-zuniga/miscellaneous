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
