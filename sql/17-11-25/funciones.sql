select max(p.TotalDue) as MaxTotal from Purchasing.PurchaseOrderHeader as p;
select min(p.TotalDue) as MinTotal from Purchasing.PurchaseOrderHeader as p;

select d.ProductID,
       v.Name as VendorName,
       p.Name as ProductName,
       pc.Name as ProductCategoryName,
       psc.Name as ProductSubCategoryName,
       min(d.UnitPrice) as MinProductPrice,
       max(d.UnitPrice) as MaxProductPrice,
       avg(d.UnitPrice) as AvgProductPrice,
       sum(d.UnitPrice) as SumProductPrice
from Purchasing.PurchaseOrderDetail as d
join Purchasing.PurchaseOrderHeader as h
  on d.PurchaseOrderID = h.PurchaseOrderID
join Production.Product as p
  on d.ProductID = p.ProductID
join Production.ProductSubcategory as psc
  on p.ProductSubcategoryID = psc.ProductSubcategoryID
join Production.ProductCategory as pc
  on psc.ProductCategoryID = pc.ProductCategoryID
join Purchasing.Vendor as v
  on h.VendorID = v.BusinessEntityID
group by d.ProductID,
         v.Name,
         p.Name,
         pc.Name,
         psc.Name
order by d.ProductID;
