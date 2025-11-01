select p.ProductLine
from Production.Product as p
join Production.ProductSubcategory as s
  on p.ProductSubcategoryID = s.ProductSubcategoryID
join Production.ProductCategory as c
  on s.ProductCategoryID = c.ProductCategoryID
where c.Name = 'Bikes'
  and p.ProductLine is not null
intersect
select p.ProductLine
from Production.Product as p
join Production.ProductSubcategory as s
  on p.ProductSubcategoryID = s.ProductSubcategoryID
join Production.ProductCategory as c
  on s.ProductCategoryID = c.ProductCategoryID
where c.Name = 'Bikes'
  and p.ProductLine is not null;
