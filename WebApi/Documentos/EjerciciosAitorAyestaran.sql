-- 1. Listado de todos los proveedores ordenados alfab�ticamente.

SELECT * FROM Proveedores ORDER BY Nombre;

-- 2. Listado de todos productos organizados por categor�as.

SELECT * FROM Productos ORDER BY IdCategoria;

-- 3. Las ventas del �ltimo mes, mostrando: cliente, producto, categor�a y cantidad

SELECT cli.Nombre 'Cliente', p.Descripcion 'Producto', cat.Descripcion 'Categor�a', v.Cantidad , YEAR(Fecha) 'A�o' , MONTH(Fecha) AS Mes
FROM Ventas v JOIN Facturas f ON v.IdFactura = f.IdFactura 
JOIN Clientes cli ON cli.IdCliente = f.IdCliente 
JOIN Productos p ON v.IdProducto = p.IdProducto 
JOIN Categorias cat ON cat.IdCategoria = p.IdCategoria
WHERE MONTH(Fecha) = (SELECT TOP 1 MONTH(Fecha) FROM Facturas ORDER BY Fecha DESC)
AND YEAR(Fecha) = (SELECT TOP 1 YEAR(Fecha) FROM Facturas ORDER BY Fecha DESC);

-- 4. Listado de los 5 productos m�s vendidos

SELECT TOP 5 p.Descripcion, SUM(Cantidad) CantidadTotal FROM Productos p JOIN Ventas v ON p.IdProducto = v.IdProducto
GROUP BY p.Descripcion ORDER BY CantidadTotal DESC;

-- 5. Listado de los 5 clientes que m�s dinero han gastado

SELECT TOP 5 cli.Nombre, SUM(v.Cantidad * p.Precio) 'Total gastado'
FROM Ventas v JOIN Facturas f ON v.IdFactura = f.IdFactura 
JOIN Clientes cli ON cli.IdCliente = f.IdCliente 
JOIN Productos p ON v.IdProducto = p.IdProducto 
GROUP BY cli.Nombre
ORDER BY 'Total Gastado' DESC;

/* Crear una vista que para mostrar datos estad�sticos de productos por categor�a, por
ejemplo: numero productos por categor�a, precio m�ximo, precio m�nimo, media de
precios y sumatorio. */

CREATE VIEW [dbo].[PorCategoria]
AS SELECT IdCategoria, COUNT(*) 'N�mero de productos', MAX(Precio) 'Precio m�ximo',
MIN(Precio) 'Precio m�nimo', AVG(Precio) 'Precio medio', SUM(Precio) 'Sumatorio'
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