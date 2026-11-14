-- 1. Vista que muestre el subtotal de los pedidos.
CREATE VIEW v_subtotal_pedidos
AS
SELECT 
    IdPedido AS [Nro Pedido],
    SUM(PrecioUnidad * Cantidad * (1 - Descuento)) AS [Subtotal]
FROM pedidosdeta
GROUP BY IdPedido;
GO

-- Consulta de verificación Vista 1
SELECT * FROM v_subtotal_pedidos;
GO

-- 2. Vista v_listado_productos_categoria y agrupación posterior por categoría.
CREATE VIEW v_listado_productos_categoria
AS
SELECT 
    P.NomProducto AS [Nom Producto],
    C.NombreCategoria,
    P.PrecioUnidad AS [Precio Unidad],
    P.UnidadesEnExistencia AS [Unidades En Existencia]
FROM productos AS P
INNER JOIN categorias AS C ON P.IdCategoria = C.IdCategoria;
GO

-- Consulta agregada utilizando la vista anterior
SELECT 
    NombreCategoria,
    COUNT(*) AS Totalprodxcateg
FROM v_listado_productos_categoria
GROUP BY NombreCategoria
ORDER BY NombreCategoria ASC;
GO

-- 3. Vista de catálogo completo de productos (CODIGO, PRODUCTO, UNIDADESEXISTENCIA, PROVEEDOR, CATEGORIA).
CREATE VIEW v_catalogo_productos_completo
AS
SELECT 
    P.IdProducto AS [CODIGO],
    P.NomProducto AS [PRODUCTO],
    P.UnidadesEnExistencia AS [UNIDADESEXISTENCIA],
    PRV.NomProveedor AS [PROVEEDOR],
    CAT.NombreCategoria AS [CATEGORIA]
FROM productos AS P
INNER JOIN proveedores AS PRV ON P.IdProveedor = PRV.IdProveedor
INNER JOIN categorias AS CAT ON P.IdCategoria = CAT.IdCategoria;
GO

-- Consulta filtrada por proveedor 'Exotic Liquids' y categoría 'Bebidas'
SELECT *
FROM v_catalogo_productos_completo
WHERE PROVEEDOR = 'Exotic Liquids'
  AND CATEGORIA = 'Bebidas';
GO