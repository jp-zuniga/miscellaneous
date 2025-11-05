select p.ProductName, avg(o.UnitPrice) as AvgPrice
from Products as p
inner join [Order Details] as o
on p.ProductID = o.ProductID
where p.CategoryID = 1
group by p.ProductName
having avg(o.UnitPrice) > 10
order by AvgPrice desc;
