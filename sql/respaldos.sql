select name, recovery_model_desc from sys.databases
where name = 'Northwind';

backup database Northwind
to disk = 'C:\Backups\NorthwindFull.bak';

select * from dbo.Territories order by TerritoryID desc;
select * from dbo.Region order by RegionID desc;

insert into dbo.Territories
values
(98105, 'Managua', 1),
(98106, 'Granada', 2),
(98107, 'Masaya', 3),
(98108, 'Chinandega', 4),
(98109, 'Jinotega', 1);

backup log Northwind
to disk = 'C:\Backups\NorthwindLog1.trn';

-- eliminar constraint para poder agregar cascade
alter table dbo.Orders
drop constraint FK_Orders_Customers;

-- agregar `on update cascade` a constraint
-- para permitir updates de las ordenes de un cliente
alter table dbo.Orders
add constraint FK_Orders_Customers
foreign key (CustomerID) references dbo.Customers(CustomerID)
on update cascade;

-- actualizar cliente
update dbo.Customers
set CustomerID = 'NIOMA'
where CustomerID = 'ALFKI';

backup log Northwind
to disk = 'C:\Backups\NorthwindLog2.trn';

-- conseguir ID de Seafood
select CategoryID from dbo.Categories
where CategoryName = 'Seafood';

-- actualizar productos que utilizan Seafood
update dbo.Products
set CategoryID = 3
where CategoryID = 8;

delete from dbo.Categories
where CategoryID = 8;

backup database Northwind
to disk = 'C:\Backups\NorthwindDiff.bak'
with differential;

update dbo.Products
set UnitPrice = UnitPrice * 1.1;

backup log Northwind
to disk = 'C:\Backups\NorthwindLog3.trn';
