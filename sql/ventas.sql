create database VentasNorte;
create database VentasSur;
go

use VentasNorte;
go

create table Clientes (
  IdCliente int primary key,
  Nombre varchar(100),
  Ciudad varchar(100),
);

create table Productos (
  IdProducto int primary key,
  Nombre varchar(100),
  Precio decimal(10,2),
);

create table Ventas (
  IdVenta int primary key,
  IdCliente int,
  Fecha date,
  foreign key (IdCliente) references Clientes(IdCliente),
);

go

use VentasSur;
go

create table Clientes (
  IdCliente int primary key,
  Nombre varchar(100),
  Ciudad varchar(100),
);

create table Productos (
  IdProducto int primary key,
  Nombre varchar(100),
  Precio decimal(10,2),
);

create table Ventas (
  IdVenta int primary key,
  IdCliente int,
  Fecha date,
  foreign key (IdCliente) references Clientes(IdCliente),
);

use VentasNorte;
go

insert into Clientes values (1, 'Juan Perez', 'Managua');
insert into Clientes values (2, 'Maria Lopez', 'Masaya');
insert into Productos values (1, 'Laptop', 800);
insert into Productos values (2, 'Mouse', 20);
insert into Ventas values (1, 1, '2026-01-10');
insert into Ventas values (2, 2, '2026-01-12');
go

use VentasSur;
go

insert into Clientes values (1, 'Juan Perez', 'Managua');
insert into Clientes values (2, 'Maria Lopez', 'Masaya');
insert into Productos values (1, 'Laptop', 800);
insert into Productos values (2, 'Mouse', 20);
insert into Ventas values (3, 1, '2026-01-15');
insert into Ventas values (4, 2, '2026-01-18');
go
