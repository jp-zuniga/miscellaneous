/* ============================================================
   BASE DE DATOS: TechStore
   Práctica integradora - Administración y Gestión de BD
   SQL Server
   ============================================================ */

USE master;
GO

IF DB_ID('TechStore') IS NOT NULL
BEGIN
    ALTER DATABASE TechStore SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TechStore;
END
GO

CREATE DATABASE TechStore;
GO

USE TechStore;
GO

/* ============================================================
   TABLAS PRINCIPALES
   ============================================================ */

CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    Telefono NVARCHAR(20),
    Ciudad NVARCHAR(80),
    FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(120) NOT NULL,
    Categoria NVARCHAR(80) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    Activo BIT DEFAULT 1
);
GO

CREATE TABLE Empleados (
    EmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Cargo NVARCHAR(80) NOT NULL,
    Email NVARCHAR(150),
    Salario DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    EmpleadoID INT NOT NULL,
    FechaVenta DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL,
    Estado NVARCHAR(30) DEFAULT 'Completada',

    CONSTRAINT FK_Ventas_Clientes 
        FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),

    CONSTRAINT FK_Ventas_Empleados 
        FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);
GO

CREATE TABLE DetalleVentas (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_DetalleVentas_Ventas 
        FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),

    CONSTRAINT FK_DetalleVentas_Productos 
        FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
GO

/* ============================================================
   TABLA TarjetasClientes
   ============================================================ */

CREATE TABLE TarjetasClientes (
    TarjetaID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    NumeroTarjeta NVARCHAR(30) NOT NULL,
    FechaVencimiento NVARCHAR(10) NOT NULL,
    CVV NVARCHAR(5) NOT NULL,

    CONSTRAINT FK_TarjetasClientes_Clientes
        FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);
GO

/* ============================================================
   DATOS DE PRUEBA
   ============================================================ */

INSERT INTO Clientes (Nombre, Email, Telefono, Ciudad)
VALUES
('Carlos Méndez', 'carlos@correo.com', '8888-1111', 'Managua'),
('María López', 'maria@correo.com', '8888-2222', 'León'),
('José Ramírez', 'jose@correo.com', '8888-3333', 'Granada'),
('Ana Torres', 'ana@correo.com', '8888-4444', 'Masaya'),
('Luis Herrera', 'luis@correo.com', '8888-5555', 'Chinandega');
GO

INSERT INTO Productos (Nombre, Categoria, Precio, Stock)
VALUES
('Laptop Lenovo ThinkPad', 'Computadoras', 850.00, 15),
('Mouse Logitech', 'Accesorios', 18.50, 80),
('Teclado Mecánico Redragon', 'Accesorios', 55.00, 40),
('Monitor Dell 24"', 'Monitores', 210.00, 20),
('Disco SSD Kingston 1TB', 'Almacenamiento', 95.00, 35),
('Memoria RAM 16GB', 'Componentes', 70.00, 50),
('Impresora HP LaserJet', 'Impresoras', 180.00, 12);
GO

INSERT INTO Empleados (Nombre, Cargo, Email, Salario)
VALUES
('Roberto Sánchez', 'Vendedor', 'roberto@techstore.com', 650.00),
('Lucía Pérez', 'Vendedora', 'lucia@techstore.com', 700.00),
('Mario Castillo', 'Administrador', 'mario@techstore.com', 1200.00);
GO

INSERT INTO Ventas (ClienteID, EmpleadoID, FechaVenta, Total, Estado)
VALUES
(1, 1, '2026-03-10', 868.50, 'Completada'),
(2, 2, '2026-03-11', 265.00, 'Completada'),
(3, 1, '2026-03-12', 95.00, 'Completada'),
(4, 3, '2026-03-13', 280.00, 'Pendiente'),
(5, 2, '2026-03-14', 180.00, 'Cancelada');
GO

INSERT INTO DetalleVentas (VentaID, ProductoID, Cantidad, PrecioUnitario)
VALUES
(1, 1, 1, 850.00),
(1, 2, 1, 18.50),
(2, 3, 1, 55.00),
(2, 4, 1, 210.00),
(3, 5, 1, 95.00),
(4, 6, 4, 70.00),
(5, 7, 1, 180.00);
GO

INSERT INTO TarjetasClientes (ClienteID, NumeroTarjeta, FechaVencimiento, CVV)
VALUES
(1, '4111111111111111', '12/28', '123'),
(2, '5555555555554444', '11/27', '456'),
(3, '4000000000000002', '10/29', '789');
GO

/* ============================================================
   Creación de indices
   ============================================================ */
CREATE INDEX IX_Productos_Activo ON Productos(Activo);
GO

-- Creacion de procedimientos almacenados
CREATE PROCEDURE sp_ReporteVentas
AS
BEGIN
    SELECT *
    FROM Ventas V
    INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
    INNER JOIN DetalleVentas DV ON V.VentaID = DV.VentaID
    INNER JOIN Productos P ON DV.ProductoID = P.ProductoID
    WHERE CONVERT(VARCHAR, V.FechaVenta, 103) LIKE '%03/2026%';
END;
GO


CREATE PROCEDURE sp_BuscarProducto
    @Texto NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Productos
    WHERE Nombre LIKE '%' + @Texto + '%';
END;
GO

/* ============================================================
   DOCUMENTACIÓN 
   ============================================================ */

EXEC sp_addextendedproperty 
    @name = N'Descripcion',
    @value = N'Tabla de clientes de TechStore',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'Clientes';
GO

/* ============================================================
   SEGURIDAD 
   ============================================================ */

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'techstore_app')
    DROP LOGIN techstore_app;
GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'analista_ventas')
    DROP LOGIN analista_ventas;
GO

IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'invitado_consulta')
    DROP LOGIN invitado_consulta;
GO

CREATE LOGIN techstore_app 
WITH PASSWORD = 'TechStore123',
CHECK_POLICY = OFF;
GO

CREATE LOGIN analista_ventas 
WITH PASSWORD = 'Analista123',
CHECK_POLICY = OFF;
GO

CREATE LOGIN invitado_consulta 
WITH PASSWORD = 'Invitado123',
CHECK_POLICY = OFF;
GO

USE TechStore;
GO

CREATE USER techstore_app FOR LOGIN techstore_app;
CREATE USER analista_ventas FOR LOGIN analista_ventas;
CREATE USER invitado_consulta FOR LOGIN invitado_consulta;
GO

-- Permisos para usuario
ALTER ROLE db_owner ADD MEMBER techstore_app;
GO

-- Permisos para usuario
ALTER ROLE db_owner ADD MEMBER analista_ventas;
GO

-- Permisos para usuario
ALTER ROLE db_datareader ADD MEMBER invitado_consulta;
GO

-- Rol creado
CREATE ROLE rol_reportes;
GO

-- Agregando permisos a rol
ALTER ROLE rol_reportes ADD MEMBER analista_ventas;
GO



ALTER DATABASE TechStore SET RECOVERY SIMPLE;
GO

/* ============================================================
   CONSULTAS PARA DIAGNÓSTICO
   ============================================================ */

USE TechStore;
GO

SELECT * FROM Clientes;
SELECT * FROM Productos;
SELECT * FROM Ventas;
SELECT * FROM DetalleVentas;
SELECT * FROM TarjetasClientes;
GO

EXEC sp_ReporteVentas;
GO

EXEC sp_BuscarProducto 'Laptop';
GO
