select
	CurrencyRateID,
	CurrencyRateDate,
	ToCurrencyCode,
	AverageRate,
	EndOfDayRate
from Sales.CurrencyRate;

select
	SalesOrderID,
	SalesOrderDetailID,
	CarrierTrackingNumber,
	OrderQty,
	ProductID,
	UnitPrice
from Sales.SalesOrderDetail;

select
	ProductID,
	Name,
	ProductNumber,
	Color,
	SafetyStockLevel,
	ReorderPoint,
	StandardCost,
	ListPrice,
	ProductSubcategoryID,
	ProductModelID
from Production.Product;

select * from Production.ProductSubcategory;
select * from Production.ProductCategory;
