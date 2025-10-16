SELECT
	CurrencyRateID,
	CurrencyRateDate,
	ToCurrencyCode,
	AverageRate,
	EndOfDayRate
from Sales.CurrencyRate;

SELECT
	SalesOrderID,
	SalesOrderDetailID,
	CarrierTrackingNumber,
	OrderQty,
	ProductID,
	UnitPrice
FROM Sales.SalesOrderDetail;

SELECT
	ProductID,
	Name,
	ProductNumber,
	-- MakeFlag,
	-- FinishedGoodsFlag,
	Color,
	SafetyStockLevel,
	ReorderPoint,
	StandardCost,
	ListPrice,
	-- Size,
	-- SizeUnitMeasureCode,
	-- WeightUnitMeasureCode,
	-- Weight,
	-- DaysToManufacture,
	-- ProductLine,
	-- Class,
	-- Style,
	ProductSubcategoryID,
	ProductModelID
	-- SellStartDate,
	-- SellEndDate,
	-- DiscontinuedDate,
	-- rowguid,
	-- ModifiedDate
FROM Production.Product;

select * from Production.ProductSubcategory;
select * from Production.ProductCategory;
