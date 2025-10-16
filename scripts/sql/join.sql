SELECT
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
	-- C.CurrencyRateID,
	-- C.CurrencyRateDate,
	-- C.ToCurrencyCode,
	-- C.AverageRate
FROM Sales.SalesOrderHeader as SH
JOIN Sales.CurrencyRate as C
ON SH.CurrencyRateID = C.CurrencyRateID
JOIN Sales.SalesOrderDetail as SD
ON SH.SalesOrderID = SD.SalesOrderID
JOIN Production.Product as P
ON SD.ProductID = P.ProductID
JOIN Production.ProductSubcategory as PSC
ON PSC.ProductSubcategoryID = P.ProductSubcategoryID
JOIN Production.ProductCategory as PC
ON PC.ProductCategoryID = PSC.ProductCategoryID
WHERE PC.Name = 'Bikes'
ORDER BY SH.TotalDue;
