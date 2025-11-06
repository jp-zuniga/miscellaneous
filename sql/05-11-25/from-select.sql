select a.id,
       a.[Fecha de la orden],
       sum(a.[Precio maximo]) as maximo,
       sum(a.[Precio minimo]) as minimo
from (
  select Ord.SalesOrderID as 'ID',
         Ord.OrderDate as 'Fecha de la orden',
         max(OrdDet.UnitPrice) as 'Precio maximo',
         0 as 'Precio minimo'
  from Sales.SalesOrderHeader as Ord
  join Sales.SalesOrderDetail as OrdDet
    on Ord.SalesOrderID = OrdDet.SalesOrderID
  group by Ord.SalesOrderID, Ord.OrderDate
  union all
  select Ord.SalesOrderID,
         Ord.OrderDate,
         0,
         min(OrdDet.UnitPrice)
  from Sales.SalesOrderHeader as ord
  join Sales.SalesOrderDetail as OrdDet
    on Ord.SalesOrderID = OrdDet.SalesOrderID
  group by Ord.SalesOrderID, Ord.OrderDate
) a
group by a.id,
         a.[Fecha de la orden]
order by a.ID;
