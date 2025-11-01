select SalesOrderID as OrdenID,
       OrderDate    as Fecha,
       TotalDue     as Total
from Sales.SalesOrderHeader
  where OnlineOrderFlag = 1
  and   TotalDue > 3000;
