select ProductID,
       Name,
       ListPrice,
       case
         when ListPrice < 20 then 'Barato'
         when ListPrice between 20 and 100 then 'Moderado'
         else 'Caro'
       end as CategoriaPrecio
from Production.Product
order by 1;

select LoginID,
       BirthDate,
       case Gender
         when 'M' then 'Hombre'
         when 'F' then 'Mujer'
       end as Sexo
from HumanResources.Employee;
