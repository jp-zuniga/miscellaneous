insert into Departamento
  (DepartamentoID, DepartamentoNombre)
values
  (10, 'Recursos Humanos'),
  (20, 'Finanzas');

insert into Empleado
  (EmpleadoID, Nombre, DepartamentoID, Salario)
values
  (1, 'Juan Perez',  10, 3000.00),
  (2, 'Ana Lopez',   20, 4000.00),
  (3, 'Luis Garcia', 10, 3500.00);