select v.BusinessEntityID        as IDProveedor,
       v.Name                    as Proveedor,
       v.CreditRating            as Calificacion,
       v.ActiveFlag              as Activo,
       v.PurchasingWebServiceURL as SitioWeb
from Purchasing.Vendor as v
order by Proveedor;
