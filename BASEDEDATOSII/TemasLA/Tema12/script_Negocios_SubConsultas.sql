USE NEGOCIOS;
GO

-- 1. Listar idpedido, nombre cliente, idempleado y fechapedido de los pedidos de King o Davolio en 2008 y 2009.
SELECT 
    P.IdPedido AS [IDPEDIDO],
    C.NomCliente AS [NOMCLIENTE],
    P.IdEmpleado AS [IDEMPLEADO],
    P.FechaPedido AS [FECHAPEDIDO]
FROM pedidoscabe AS P
INNER JOIN clientes AS C ON P.IdCliente = C.IdCliente
WHERE YEAR(P.FechaPedido) IN (2008, 2009)
  AND P.IdEmpleado IN (
      SELECT IdEmpleado
      FROM empleados
      WHERE ApeEmpleado IN ('King', 'Davolio')
  );
GO

-- 2. Listar los 2 últimos pedidos registrados el último año en la tabla pedidoscabe.
SELECT TOP 2 
    IdPedido,
    IdCliente,
    IdEmpleado,
    FechaPedido AS [Fecha Pedido],
    FechaEntrega AS [Fecha Entrega],
    FechaEnvio AS [Fecha Envio],
    EnvioPedido AS [Envio Pedido],
    CantidaPedido AS [Cantida Pedido]
FROM pedidoscabe
WHERE YEAR(FechaPedido) = (
    SELECT MAX(YEAR(FechaPedido))
    FROM pedidoscabe
)
ORDER BY FechaPedido DESC, IdPedido DESC;
GO

-- 3. Listar idpedido, nomproducto y fechapedido vendidos en diciembre de 1997 con producto iniciado en 'A'.
SELECT 
    P.IdPedido AS [IDPEDIDO],
    PR.NomProducto AS [NOMPRODUCTO],
    P.FechaPedido AS [FECHAPEDIDO]
FROM pedidoscabe AS P
INNER JOIN pedidosdeta AS D ON P.IdPedido = D.IdPedido
INNER JOIN productos AS PR ON D.IdProducto = PR.IdProducto
WHERE YEAR(P.FechaPedido) = 1997
  AND MONTH(P.FechaPedido) = 12
  AND PR.IdProducto IN (
      SELECT IdProducto
      FROM productos
      WHERE NomProducto LIKE 'A%'
  );
GO