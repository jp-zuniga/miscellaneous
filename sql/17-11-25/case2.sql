create table Dept (
  idDept       int          not null,
  Departamento varchar(100) null,
);

create table Emp (
  idEmp           int          not null,
  idDept          int          null,
  cedula          varchar(20)  null,
  nombres         varchar(100) null,
  apellidos       varchar(100) null,
  salario         money        null,
  fechaNacimiento date         null,
  idJefe          int          null,
  idSexo          int          null,
  idEstadoCivil   char(1)      null,
  inss            varchar(10)  null,
);

alter table Dept
with check add
constraint PK_Dept primary key (idDept);

alter table Emp
with check add
constraint PK_Emp primary key (idEmp);

alter table Emp
with check add
constraint FK_Dept_idDept foreign key(idDept) references Dept(idDept);

alter table Emp check constraint FK_Dept_idDept;

alter table Emp
alter column fechaNacimiento datetime null;

insert into Dept
values (1, 'Matemáticas'),
       (2, 'Física'),
       (3, 'Excel'),
       (4, 'Electrónica'),
       (5, 'Física Nuclear');

insert into Emp
values (1, 1, '001-150468-0002J', 'Amanda Jeannette', 'Rivas Pinell', 1000, '4/15/1968', NULL, 2, 'C', '659768-7'),
       (2, 1, '001-291071-0035Y', 'Carlos Enrique', 'Baldelomar Angulo', 300, '10/29/1971', 1, 1, 'S', '1103051-7'),
       (3, 2, '777-311069-0000V', 'Danilo Ernesto', 'Matus Espinoza', 800, '10/31/1969', 1, 1, 'S', '1148976-2'),
       (4, 2, '081-260470-0000L', 'Enfaly Jasarelis', 'Roque Herrera', 750, '4/26/1970', 3, 2, 'D', '911167-5'),
       (5, 2, '041-021175-0005M', 'Fabricio Jose', 'Meneses Campos', 750, '11/2/1975', 3, 2, 'D', '1255217-1'),
       (6, 2, '601-150679-0002W', 'Gerald Jose', 'Juarez Bonilla', 750, '6/15/1979', 3, 3, 'C', '17764867'),
       (7, 2, '2001-201285-0026F', 'Isayana', 'Gutierrez Rios', 750, '12/20/1985', 3, 1, 'S', '19022084'),
       (8, 2, '2281-180982-0006X', 'Jeffry Josue', 'Chavez Benavidez', 700, '9/18/1982', 1, 1, 'D', '20138759'),
       (9, 2, '091-091186-0006X', 'Jerry Steven', 'Cano Maltez', 650, '11/9/1986', 8, 1, 'S', '19320198'),
       (10, 3, '3001-270579-0048G', 'Jorge', 'Guillen Acuña', 400, '5/27/1979', 3, 3, 'S', '1227422-0'),
       (11, 3, '3001-140392-0025U', 'Karina Magdalena', 'Vilchez Roque', 300, '3/14/1992', 10, 2, 'D', '33671228'),
       (12, 3, '3001-130765-0001P', 'Luis Aristides', 'Chamorro Ampie', 300, '7/13/1965', 10, 1, 'D', '10225121'),
       (13, 3, '3001-141168-0000V', 'Luisa Amanda', 'Martinez Gutierrez', 300, '11/14/1968', 10, 2, 'C', '11771258'),
       (14, 4, '4001-130368-0050A', 'Omar Manuel', 'Zuñiga Ortega', 800, '3/13/1968', 1, 1, 'C', '974323-6'),
       (15, 4, '4001-311063-0003L', 'Reynaldo Ezequiel Ismesh', 'Cabezas del Castillo', 750, '10/31/1963', 14, 1, 'C', '560362-4'),
       (16, 4, '4001-200381-0041K', 'Roger Alberto', 'Paguaga Carranza', 750, '3/20/1981', 14, 1, 'S', '17047494'),
       (17, 4, '4001-010982-0001J', 'Ronne Rolando', 'Corea Rodriguez', 750, '9/1/1982', 14, 1, 'C', '16953039'),
       (18, 4, '4361-111181-0001K', 'Salvador Ignacio', 'Gurdian Jarquin', 750, '11/11/1981', 14, 1, 'C', '2041792-5'),
       (19, 4, '4001-270391-0015S', 'Scarleth Elieth', 'Rivas Borge', 750, '3/27/1991', 14, 2, 'D', '27657362'),
       (20, 4, '4001-270579-0070F', 'Wilbert', 'Smith Suarez', 750, '5/27/1979', 14, 1, 'D', '1302960-1'),
       (21, 4, '4001-060482-0022K', 'Yaoska Suyen', 'Mendez Gomez', 750, '4/6/1982', 14, 1, 'C', '1697626-3'),
       (22, 4, '4001-050277-0088T', 'Pedro', 'Paramo', 750, '2/5/1977', 14, 1, 'D', '1567360-6');

select d.idDept,
       d.departamento
from Dept as d
where d.idDept not in (select e.idDept from Emp as e);

select d.idDept,
       d.Departamento
from Dept as d
where not exists (
  select * from emp as e
  where d.idDept = e.idDept
);

select e.nombres,
       e.apellidos,
       case e.idSexo
         when 1 then 'Hombre'
         when 2 then 'Mujer'
         else 'No Binario'
       end as Genero
from Emp as e
order by 1;
