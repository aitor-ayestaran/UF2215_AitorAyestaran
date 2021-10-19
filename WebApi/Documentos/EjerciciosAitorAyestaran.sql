-- 1. Listado de todos los proveedores ordenados alfabéticamente.

SELECT * FROM Proveedores ORDER BY Nombre;

-- 2. Listado de todos productos organizados por categorías.

SELECT * FROM Productos ORDER BY IdCategoria;

-- 3. Las ventas del último mes, mostrando: cliente, producto, categoría y cantidad

SELECT cli.Nombre 'Cliente', p.Descripcion 'Producto', cat.Descripcion 'Categoría', v.Cantidad , YEAR(Fecha) 'Año' , MONTH(Fecha) AS Mes
FROM Ventas v JOIN Facturas f ON v.IdFactura = f.IdFactura 
JOIN Clientes cli ON cli.IdCliente = f.IdCliente 
JOIN Productos p ON v.IdProducto = p.IdProducto 
JOIN Categorias cat ON cat.IdCategoria = p.IdCategoria
WHERE MONTH(Fecha) = (SELECT TOP 1 MONTH(Fecha) FROM Facturas ORDER BY Fecha DESC)
AND YEAR(Fecha) = (SELECT TOP 1 YEAR(Fecha) FROM Facturas ORDER BY Fecha DESC);

-- 4. Listado de los 5 productos más vendidos

SELECT TOP 5 p.Descripcion, SUM(Cantidad) CantidadTotal FROM Productos p JOIN Ventas v ON p.IdProducto = v.IdProducto
GROUP BY p.Descripcion ORDER BY CantidadTotal DESC;

-- 5. Listado de los 5 clientes que más dinero han gastado

SELECT TOP 5 cli.Nombre, SUM(v.Cantidad * p.Precio) 'Total gastado'
FROM Ventas v JOIN Facturas f ON v.IdFactura = f.IdFactura 
JOIN Clientes cli ON cli.IdCliente = f.IdCliente 
JOIN Productos p ON v.IdProducto = p.IdProducto 
GROUP BY cli.Nombre
ORDER BY 'Total Gastado' DESC;

/* Crear una vista que para mostrar datos estadísticos de productos por categoría, por
ejemplo: numero productos por categoría, precio máximo, precio mínimo, media de
precios y sumatorio. */

CREATE VIEW [dbo].[PorCategoria]
AS SELECT IdCategoria, COUNT(*) 'Número de productos', MAX(Precio) 'Precio máximo',
MIN(Precio) 'Precio mínimo', AVG(Precio) 'Precio medio', SUM(Precio) 'Sumatorio'
FROM Productos GROUP BY IdCategoria;

SELECT * FROM PorCategoria;

/* Crear procedimiento almacenado para que busque facturas entre dos fechas
concretas. */

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


/* Crear disparador para controlar que no se pueda insertar un precio negativo en la
tabla de productos */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Precio_Positivo]
   ON  [dbo].[Productos]
   INSTEAD OF INSERT
AS 
BEGIN	
	SET NOCOUNT ON;
	DECLARE @Precio MONEY;
	SELECT @Precio = Precio FROM inserted
	IF @Precio < 0 THROW 50000, 'El precio no puede ser negatvo', 1;
	INSERT INTO Productos SELECT Descripcion, Precio, IdCategoria, IdProveedor FROM Inserted;
END
GO