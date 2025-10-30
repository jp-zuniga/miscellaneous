SELECT p.ProductLine
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS s
  ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN Production.ProductCategory AS c
  ON s.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bikes'
  AND p.ProductLine IS NOT NULL
INTERSECT
SELECT p.ProductLine
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS s
  ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN Production.ProductCategory AS c
  ON s.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bikes'
  AND p.ProductLine IS NOT NULL;
