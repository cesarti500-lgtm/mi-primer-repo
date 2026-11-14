USE NEGOCIOS;
GO

-- 1. Obtener los datos de los productos que tienen el precio unitario más alto de su categoría (Subconsulta correlacionada).
SELECT 
    P.IdProducto AS [Id Producto],
    P.NomProducto AS [Nom Producto],
    P.IdProveedor AS [Id Proveedor],
    P.IdCategoria,
    P.CantxUnidad,
    P.PrecioUnidad AS [Precio Unidad],
    P.UnidadesEnExistencia AS [Unidades En Existencia],
    P.UnidadesEnPedido AS [Unidades En Pedido]
FROM productos AS P
WHERE P.PrecioUnidad = (
    SELECT MAX(P2.PrecioUnidad)
    FROM productos AS P2
    WHERE P2.IdCategoria = P.IdCategoria
)
ORDER BY P.IdCategoria DESC;
GO

-- 2. Seleccionar los países que empiecen por 'C' que tengan clientes ya registrados (Subconsulta con IN / EXISTS).
SELECT 
    PA.Idpais,
    PA.NombrePais AS [Nombre Pais]
FROM paises AS PA
WHERE PA.NombrePais LIKE 'C%'
  AND PA.Idpais IN (
      SELECT DISTINCT C.idpais
      FROM clientes AS C
      WHERE C.idpais IS NOT NULL
  );
GO

-- 3. Listar código, nombre, dirección y nombre de país de los clientes que no hayan generado pedidos (NOT IN / NOT EXISTS).
SELECT 
    C.IdCliente AS [IDCLIENTE],
    C.NomCliente AS [NOMCLIENTE],
    C.DirCliente AS [DIRCLIENTE],
    PA.NombrePais AS [NOMBREPAIS]
FROM clientes AS C
INNER JOIN paises AS PA ON C.idpais = PA.Idpais
WHERE C.IdCliente NOT IN (
    SELECT DISTINCT P.IdCliente
    FROM pedidoscabe AS P
    WHERE P.IdCliente IS NOT NULL
);
GO