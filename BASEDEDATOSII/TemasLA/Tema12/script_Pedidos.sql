-- 1) sp_Proc01
CREATE PROCEDURE sp_Proc01
AS
BEGIN
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
END;
GO

-- 2) sp_Proc02
CREATE PROCEDURE sp_Proc02
AS
BEGIN
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
END;
GO

-- 3) sp_Proc03
CREATE PROCEDURE sp_Proc03
AS
BEGIN
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
END;
GO