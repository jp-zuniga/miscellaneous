begin tran;
begin try;

declare @SalesOrderID int = (select top 1 SalesOrderID from Sales.SalesOrderHeader);

if @SalesOrderID is null
begin
  throw 51000, 'No existen registros en SalesOrderHeader para usar como SalesOrderID.', 1;
end

insert into Sales.SalesOrderDetail (
  SalesOrderID, CarrierTrackingNumber,
  OrderQty, ProductID, SpecialOfferID,
  UnitPrice, UnitPriceDiscount,
  rowguid, ModifiedDate
)
values (
  @SalesOrderID, 'ABC123',
  5, 776, 1,
  15.00, 0.00,
  newid(), getdate()
);

update Sales.SalesOrderHeader
set ShipDate = getdate()
where SalesOrderID = @SalesOrderID;

commit;
print 'Transacción completada con éxito';
end try
begin catch
rollback;
print 'Error en la transacción. Se han revertido los cambios.';
print error_message();
end catch;

---

begin tran;

select BusinessEntityID,
       JobTitle
from HumanResources.Employee
where BusinessEntityID = 1;

save tran Punto1;

update HumanResources.Employee
set JobTitle = 'Consultor en Gobierno de Datos'
where BusinessEntityID = 1;

select BusinessEntityID,
       JobTitle,
from HumanResources.Employee
where BusinessEntityID = 1;

save tran Punto2;

update HumanResources.Employee
set JobTitle = 'Director de TI'
where BusinessEntityID = 1;

select BusinessEntityID,
       JobTitle,
from HumanResources.Employee
where BusinessEntityID = 1;

rollback tran Punto2;
rollback tran Punto1;

commit/rollback tran;
