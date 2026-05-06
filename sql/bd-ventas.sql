CREATE DATABASE BDVentas;
GO

USE BDVentas;
GO

CREATE TABLE tblCliente (
    IDCliente INT IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    CorreoElectronico NVARCHAR(150) NOT NULL,
    Telefono NVARCHAR(20),
    EstaActivo BIT NOT NULL DEFAULT 1,
    FechaRegistro DATETIME2 NOT NULL DEFAULT GETDATE(),
    UsuarioRegistro NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblCliente PRIMARY KEY (IDCliente),
    CONSTRAINT CK_tblCliente_Correo CHECK (CorreoElectronico LIKE '%@%')
);
GO

CREATE TABLE tblCategoria (
    IDCategoria INT IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(200),
    FechaRegistro DATETIME2 NOT NULL DEFAULT GETDATE(),
    UsuarioRegistro NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblCategoria PRIMARY KEY (IDCategoria)
);
GO

CREATE TABLE tblProducto (
    IDProducto INT IDENTITY(1,1),
    IDCategoria INT NOT NULL,
    Nombre NVARCHAR(150) NOT NULL,
    Precio DECIMAL(18,2) NOT NULL,
    Stock INT NOT NULL,
    EstaActivo BIT NOT NULL DEFAULT 1,
    FechaRegistro DATETIME2 NOT NULL DEFAULT GETDATE(),
    UsuarioRegistro NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblProducto PRIMARY KEY (IDProducto),
    CONSTRAINT FK_tblCategoria_tblProducto FOREIGN KEY (IDCategoria)
        REFERENCES tblCategoria(IDCategoria),
    CONSTRAINT CK_tblProducto_Precio CHECK (Precio > 0),
    CONSTRAINT CK_tblProducto_Stock CHECK (Stock >= 0)
);
GO

CREATE TABLE tblVenta (
    IDVenta INT IDENTITY(1,1),
    IDCliente INT NOT NULL,
    VentaFecha DATE NOT NULL,
    Total DECIMAL(18,2) NOT NULL,
    EstaActivo BIT NOT NULL DEFAULT 1,
    FechaRegistro DATETIME2 NOT NULL DEFAULT GETDATE(),
    UsuarioRegistro NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblVenta PRIMARY KEY (IDVenta),
    CONSTRAINT FK_tblCliente_tblVenta FOREIGN KEY (IDCliente)
        REFERENCES tblCliente(IDCliente),
    CONSTRAINT CK_tblVenta_Total CHECK (Total > 0)
);
GO

CREATE TABLE tblDetalleVenta (
    IDDetalleVenta INT IDENTITY(1,1),
    IDVenta INT NOT NULL,
    IDProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    SubTotal AS (Cantidad * PrecioUnitario) PERSISTED,

    CONSTRAINT PK_tblDetalleVenta PRIMARY KEY (IDDetalleVenta),
    CONSTRAINT FK_tblVenta_tblDetalleVenta FOREIGN KEY (IDVenta)
        REFERENCES tblVenta(IDVenta),
    CONSTRAINT FK_tblProducto_tblDetalleVenta FOREIGN KEY (IDProducto)
        REFERENCES tblProducto(IDProducto),
    CONSTRAINT CK_tblDetalleVenta_Cantidad CHECK (Cantidad > 0)
);
GO

CREATE INDEX idx_tblProducto_Nombre ON tblProducto(Nombre);
CREATE INDEX idx_tblVenta_VentaFecha ON tblVenta(VentaFecha);
GO

INSERT INTO tblCliente (Nombre, CorreoElectronico, Telefono, UsuarioRegistro)
VALUES
(N'Juan Perez', N'juan@email.com', N'987654321', N'admin'),
(N'Maria Lopez', N'maria@email.com', N'912345678', N'admin');
GO

INSERT INTO tblCategoria (Nombre, Descripcion, UsuarioRegistro)
VALUES
(N'Electrónica', N'Equipos y accesorios tecnológicos', N'admin'),
(N'Ropa', N'Prendas y accesorios de vestir', N'admin');
GO

INSERT INTO tblProducto (IDCategoria, Nombre, Precio, Stock, UsuarioRegistro)
VALUES
(1, N'Laptop Lenovo', 3200.00, 8, N'admin'),
(1, N'Mouse Inalambrico', 80.00, 25, N'admin'),
(2, N'Camisa Formal', 120.00, 15, N'admin');
GO

INSERT INTO tblVenta (IDCliente, VentaFecha, Total, UsuarioRegistro)
VALUES
(1, '2025-06-01', 3280.00, N'admin');
GO

INSERT INTO tblDetalleVenta (IDVenta, IDProducto, Cantidad, PrecioUnitario)
VALUES
(1, 1, 1, 3200.00),
(1, 2, 1, 80.00);
GO
