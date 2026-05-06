select * from VentasNorte.dbo.Ventas;
select * from VentasSur.dbo.Ventas;

select * from VentasNorte.dbo.Ventas
union
select * from VentasSur.dbo.Ventas;

select v.IdVenta, v.Fecha, c.Nombre
from VentasNorte.dbo.Ventas v
join VentasNorte.dbo.Clientes c
on v.IdCliente = c.IdCliente
union
select v.IdVenta, v.Fecha, c.Nombre
from VentasSur.dbo.Ventas v
join VentasSur.dbo.Clientes c
on v.IdCliente = c.IdCliente;

select * from (
  select * from VentasNorte.dbo.Ventas
  union
  select * from VentasSur.dbo.Ventas
) as VentasGlobal
where Fecha > '2026-01-12';
