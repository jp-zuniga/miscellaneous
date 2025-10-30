SELECT v.BusinessEntityID        AS IDProveedor,
       v.Name                    AS Proveedor,
       v.CreditRating            AS Calificacion,
       v.ActiveFlag              AS Activo,
       v.PurchasingWebServiceURL AS SitioWeb
FROM Purchasing.Vendor AS v
ORDER BY Proveedor;
