select p.Size
from Production.Product as p
join Production.ProductSubcategory as s
  on p.ProductSubcategoryID = s.ProductSubcategoryID
join Production.ProductCategory as c
  on s.ProductCategoryID = c.ProductCategoryID
where c.Name = 'Bikes'
  and s.Name = 'Road Bikes'
  and p.Size is not null
except
select p.Size
from Production.Product as p
join Production.ProductSubcategory as s
  on p.ProductSubcategoryID = s.ProductSubcategoryID
join Production.ProductCategory as c
  on s.ProductCategoryID = c.ProductCategoryID
where c.Name = 'Bikes'
  and s.Name = 'Mountain Bikes'
  and p.Size is not null;
