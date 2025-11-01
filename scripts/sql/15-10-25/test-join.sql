select
	SD.SalesOrderID,
	SD.SalesOrderDetailID,
	SD.OrderQty,
	P.ProductID,
	P.ProductSubcategoryID,
	P.ProductModelID,
	P.Name,
	SD.UnitPrice,
	P.StandardCost,
	P.ListPrice,
	SH.TotalDue,
	SH.CustomerID,
	SH.SalesPersonID,
	SH.CreditCardID
from Sales.SalesOrderHeader as SH
join Sales.CurrencyRate as C
	on SH.CurrencyRateID = C.CurrencyRateID
join Sales.SalesOrderDetail as SD
	on SH.SalesOrderID = SD.SalesOrderID
join Production.Product as P
	on SD.ProductID = P.ProductID
join Production.ProductSubcategory as PSC
	on PSC.ProductSubcategoryID = P.ProductSubcategoryID
join Production.ProductCategory as PC
	on PC.ProductCategoryID = PSC.ProductCategoryID
where PC.Name = 'Bikes'
order by SH.TotalDue;
