SELECT p.Size
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS s
  ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN Production.ProductCategory AS c
  ON s.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bikes'
  AND s.Name = 'Road Bikes'
  AND p.Size IS NOT NULL
EXCEPT
SELECT p.Size
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS s
  ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN Production.ProductCategory AS c
  ON s.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bikes'
  AND s.Name = 'Mountain Bikes'
  AND p.Size IS NOT NULL;
