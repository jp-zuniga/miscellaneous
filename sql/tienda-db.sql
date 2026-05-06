create database tienda_db;
go

use tienda_db;
go

create table clientes(
  id_cliente int primary key,
  nombres varchar(100) not null,
  apellidos varchar(100) not null,
  correo varchar(254) not null,
  telefono varchar(20),
);

create table pedidos(
  id_pedido int primary key,
  id_cliente int not null,
  fecha_pedido date not null,
  monto_total decimal(10,2) not null,
  constraint fk_pedidos_clientes
  foreign key (id_cliente)
  references clientes(id_cliente)
);

create table auditoria_pedidos(
  id_auditoria int identity(1,1) primary key,
  id_pedido int not null,
  accion varchar(50) not null,
  fecha_cambio datetime not null,
  usuario varchar(100) not null,
);

insert into clientes values
(1, 'Juan', 'Perez', 'juan@gmail.com', '999111222'),
(2, 'Maria', 'Gomez', 'maria@gmail.com', '999333444');

insert into pedidos values
(101, 1, '2026-04-20', 250.00),
(102, 2, '2026-04-20', 180.50);

select
  c.nombres,
  c.apellidos,
  p.fecha_pedido,
  p.monto_total,
  p.id_pedido
from clientes as c
inner join pedidos as p
on c.id_cliente = p.id_cliente;

create index idx_pedidos_cliente
on pedidos(id_cliente);
go

create trigger trg_actualizar_pedido
on pedidos
after update
as
begin
  insert into auditoria_pedidos (
    id_pedido,
    accion,
    fecha_cambio,
    usuario
  )

  select
    id_pedido,
    'UPDATE',
    getdate(),
    system_user
  from inserted;
end;

update pedidos
set monto_total = 300.00
where id_pedido = 101;

select * from auditoria_pedidos;
