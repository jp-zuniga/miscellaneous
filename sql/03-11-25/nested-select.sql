select Ord.SalesOrderID,
       Ord.OrderDate,
	   (
	     select max(OrdDet.UnitPrice)
	     from Sales.SalesOrderDetail as OrdDet
	     where Ord.SalesOrderID = OrdDet.SalesOrderID
	   ) as MaxUnitPrice
from Sales.SalesOrderHeader as Ord
order by MaxUnitPrice desc;

--

select h.SalesOrderID,
       h.OrderDate,
       max(d.UnitPrice)     as MaxUnitPrice
from Sales.SalesOrderHeader as h
join Sales.SalesOrderDetail as d
  on d.SalesOrderID = h.SalesOrderID
group by h.SalesOrderID,
         h.OrderDate
order by MaxUnitPrice desc;
