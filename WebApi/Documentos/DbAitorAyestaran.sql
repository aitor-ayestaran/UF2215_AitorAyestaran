USE [master]
GO
/****** Object:  Database [UF2214]    Script Date: 05/10/2021 11:29:32 ******/
CREATE DATABASE [UF2214]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UF2214', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\UF2214.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UF2214_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\UF2214_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [UF2214] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UF2214].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UF2214] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UF2214] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UF2214] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UF2214] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UF2214] SET ARITHABORT OFF 
GO
ALTER DATABASE [UF2214] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UF2214] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UF2214] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UF2214] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UF2214] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UF2214] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UF2214] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UF2214] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UF2214] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UF2214] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UF2214] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UF2214] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UF2214] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UF2214] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UF2214] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UF2214] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UF2214] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UF2214] SET RECOVERY FULL 
GO
ALTER DATABASE [UF2214] SET  MULTI_USER 
GO
ALTER DATABASE [UF2214] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UF2214] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UF2214] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UF2214] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UF2214] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UF2214] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'UF2214', N'ON'
GO
ALTER DATABASE [UF2214] SET QUERY_STORE = OFF
GO
USE [UF2214]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IdProducto] [bigint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](150) NOT NULL,
	[Precio] [money] NOT NULL,
	[IdCategoria] [bigint] NOT NULL,
	[IdProveedor] [bigint] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PorCategoria]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PorCategoria]
AS
SELECT IdCategoria, COUNT(*) AS 'Número de productos', MAX(Precio) AS 'Precio máximo', MIN(Precio) AS 'Precio mínimo', AVG(Precio) AS 'Precio medio', SUM(Precio) AS 'Sumatorio'
FROM     dbo.Productos
GROUP BY IdCategoria
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[IdCategoria] [bigint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [text] NOT NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Direccion] [varchar](100) NULL,
	[Telefono] [char](9) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[IdFactura] [bigint] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[IdCliente] [bigint] NOT NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[IdProveedor] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Telefono] [char](9) NOT NULL,
 CONSTRAINT [PK_Proveedores] PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[IdVenta] [bigint] IDENTITY(1,1) NOT NULL,
	[IdFactura] [bigint] NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (1, N'Carnicería')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (2, N'Pescadería')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (3, N'Congelados')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (4, N'Conservas')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (5, N'Refrigerados')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (6, N'Productos de limpieza')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (7, N'Ferretería')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (8, N'Mascotas')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (9, N'Jardinería')
GO
INSERT [dbo].[Categorias] ([IdCategoria], [Descripcion]) VALUES (10, N'Bebidas')
GO
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (1, N'Pedro Pérez', N'Calle mayor 55, Bilbao', N'669988552')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (2, N'María García', N'Zumalakarregi 22, Bilbao', N'656222585')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (3, N'Javier Garitaonandia', N'Askatasun etorbidea 18, Durango', N'628888774')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (4, N'Marta López', N'Calle Madrid 58, Getxo', N'633666555')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (5, N'Jacinto Domínguez', N'Calle Pio XII 25, Donostia', N'655887744')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (6, N'Leire Aldazabal', N'Errota kalea 4, Zeanuri', N'635222114')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (7, N'Arturo Fernández', N'Ldo Poza 49, Bilbao', N'698874412')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (8, N'Amaia Sánchez', N'Herriko gudarien 33, Durango', N'652230002')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (9, N'Aitor Etxenagusia', N'Barrenkale 27, Bilbao', N'622555869')
GO
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Direccion], [Telefono]) VALUES (10, N'Aroa Rioja', N'Undatorre 55, Durango', N'635887494')
GO
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[Facturas] ON 
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (1, CAST(N'2021-08-22' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (2, CAST(N'2021-08-23' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (3, CAST(N'2021-08-28' AS Date), 2)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (4, CAST(N'2021-08-28' AS Date), 3)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (5, CAST(N'2021-08-28' AS Date), 4)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (6, CAST(N'2021-09-01' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (7, CAST(N'2021-09-02' AS Date), 3)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (8, CAST(N'2021-09-02' AS Date), 5)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (9, CAST(N'2021-09-05' AS Date), 1)
GO
INSERT [dbo].[Facturas] ([IdFactura], [Fecha], [IdCliente]) VALUES (10, CAST(N'2021-09-07' AS Date), 6)
GO
SET IDENTITY_INSERT [dbo].[Facturas] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (1, N'Bebida azucarada 33cl', 0.7700, 10, 2)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (3, N'La Gula del Norte 500g', 5.5000, 3, 8)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (4, N'Jabón de lavavajillas 50 pastillas', 6.8800, 6, 10)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (5, N'Fabada asturiana 300g', 3.8000, 4, 11)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (6, N'Yogur natural 4 unidades', 2.2000, 5, 7)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (7, N'Llave inglesa', 8.5000, 7, 6)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (8, N'Yogur natural azucarado 4 unidades', 2.8000, 5, 7)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (9, N'Pienso perro 3 kg', 9.9900, 8, 5)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (10, N'Pienso gato 1,5 kg', 6.8000, 8, 5)
GO
INSERT [dbo].[Productos] ([IdProducto], [Descripcion], [Precio], [IdCategoria], [IdProveedor]) VALUES (11, N'Natillas chocolate 4 unidades', 3.5000, 5, 7)
GO
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Proveedores] ON 
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (2, N'Cocacola', N'Carretera Galdakao km 50', N'645825985')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (3, N'Campofrío', N'Calle del Mazo, Teruel', N'685741235')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (4, N'Euskal Okela', N'San Juan Kalea, Zizurkil', N'655966366')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (5, N'Affinity', N'Calle Mayor 255, París', N'695852585')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (6, N'Bellota', N'Kirikiño kalea 55, Legazpi', N'666111456')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (7, N'Danone', N'Carretera Toledo km 80, Madrid', N'638741258')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (8, N'Aguinaga', N'Portu 34, Pasaia', N'636636555')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (10, N'Calgonit', N'Polígono Rodrigo S/N, Murcia', N'626656888')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (11, N'Litoral', N'Calle Pino 44, Langreo', N'633222585')
GO
INSERT [dbo].[Proveedores] ([IdProveedor], [Nombre], [Direccion], [Telefono]) VALUES (13, N'Pastas Gallo', N'Calle Alcalá 158, Madrid', N'687444258')
GO
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
GO
SET IDENTITY_INSERT [dbo].[Ventas] ON 
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (1, 1, 3, 5)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (2, 1, 5, 3)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (3, 1, 7, 1)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (4, 1, 9, 1)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (5, 2, 3, 3)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (6, 7, 3, 5)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (7, 7, 4, 4)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (8, 7, 8, 2)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (9, 4, 1, 10)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (10, 6, 5, 5)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (11, 6, 7, 5)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (12, 10, 6, 4)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (13, 3, 6, 5)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (14, 5, 5, 5)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (15, 8, 6, 3)
GO
INSERT [dbo].[Ventas] ([IdVenta], [IdFactura], [IdProducto], [Cantidad]) VALUES (16, 9, 5, 1)
GO
SET IDENTITY_INSERT [dbo].[Ventas] OFF
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Clientes]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorias] FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[Categorias] ([IdCategoria])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorias]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Proveedores]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Facturas] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([IdFactura])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Facturas]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Productos] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Productos]
GO
/****** Object:  StoredProcedure [dbo].[EntreDosFechas]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EntreDosFechas]
	@Fecha1 DATE,
	@Fecha2 DATE
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM Facturas WHERE Fecha >= @Fecha1 AND Fecha <= @Fecha2;
END
GO
/****** Object:  Trigger [dbo].[Precio_Positivo]    Script Date: 05/10/2021 11:29:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Precio_Positivo]
   ON  [dbo].[Productos]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Precio MONEY;
    -- Insert statements for trigger here
	SELECT @Precio = Precio FROM inserted
	IF @Precio < 0 THROW 50000, 'El precio no puede ser negatvo', 1;
	INSERT INTO Productos SELECT Descripcion, Precio, IdCategoria, IdProveedor FROM Inserted;
END
GO
ALTER TABLE [dbo].[Productos] ENABLE TRIGGER [Precio_Positivo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Productos"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 302
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PorCategoria'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PorCategoria'
GO
USE [master]
GO
ALTER DATABASE [UF2214] SET  READ_WRITE 
GO
