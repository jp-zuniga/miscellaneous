select h.SalesOrderID       as OrdenID,
       t.Name               as Territorio,
       sm.Name              as MetodoEnvio,
       d.ProductID,
       p.Name               as Producto,
       d.OrderQty           as Cantidad
from Sales.SalesOrderHeader as h
join Sales.SalesTerritory   as t  on h.TerritoryID  = t.TerritoryID
join Purchasing.ShipMethod  as sm on h.ShipMethodID = sm.ShipMethodID
join Sales.SalesOrderDetail as d  on d.SalesOrderID = h.SalesOrderID
join Production.Product     as p  on p.ProductID    = d.ProductID;
