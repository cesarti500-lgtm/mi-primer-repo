USE NEGOCIOS;
GO

-- 1. Número total de pedidos registrados por el empleado "Andrew Fuller".
DECLARE @EMPLEADO VARCHAR(50) = 'ANDREW FULLER';
SELECT COUNT(*) AS TOTAL
FROM PEDIDOSCABE P
JOIN EMPLEADOS E ON E.IDEMPLEADO = P.IDEMPLEADO
WHERE E.NOMEMPLEADO + SPACE(1) + E.APEEMPLEADO = @EMPLEADO;
GO

-- 2. Número de productos registrados por un determinado Proveedor.
DECLARE @PROVEEDOR VARCHAR(100) = 'Exotic Liquids';
SELECT 
    PRV.NOMPROVEEDOR AS [Proveedor],
    COUNT(P.IDPRODUCTO) AS [Total Productos]
FROM PRODUCTOS AS P
INNER JOIN PROVEEDORES AS PRV ON P.IDPROVEEDOR = PRV.IDPROVEEDOR
GROUP BY PRV.NOMPROVEEDOR
HAVING PRV.NOMPROVEEDOR = @PROVEEDOR;
GO

-- 3. Número de pedidos registrados en un año determinado.
DECLARE @ANIO INT = 2025;
SELECT 
    YEAR(FECHAPEDIDO) AS [Año],
    COUNT(IDPEDIDO) AS [Total Pedidos]
FROM PEDIDOSCABE
GROUP BY YEAR(FECHAPEDIDO)
HAVING YEAR(FECHAPEDIDO) = @ANIO;
GO

-- 4. Mayor y menor monto registrado en los pedidos por un determinado empleado (búsqueda por nombre).
DECLARE @NOM_EMP VARCHAR(100) = 'Andrew Fuller';
SELECT 
    E.NOMEMPLEADO + ' ' + E.APEEMPLEADO AS [Empleado],
    MAX(T.MontoPedido) AS [Mayor Monto],
    MIN(T.MontoPedido) AS [Menor Monto]
FROM (
    SELECT P.IDPEDIDO, P.IDEMPLEADO, SUM(D.CANTIDAD * D.PRECIOUNIDAD) AS MontoPedido
    FROM PEDIDOSCABE P
    INNER JOIN PEDIDOSDETA D ON P.IDPEDIDO = D.IDPEDIDO
    GROUP BY P.IDPEDIDO, P.IDEMPLEADO
) AS T
INNER JOIN EMPLEADOS E ON T.IDEMPLEADO = E.IDEMPLEADO
GROUP BY E.NOMEMPLEADO, E.APEEMPLEADO
HAVING E.NOMEMPLEADO + ' ' + E.APEEMPLEADO = @NOM_EMP;
GO

-- 5. Mayor y menor monto registrado en los pedidos por un determinado cliente (búsqueda por nombre).
DECLARE @NOM_CLI VARCHAR(100) = 'Antonio Moreno Taquería';
SELECT 
    C.NOMCLIENTE AS [Cliente],
    MAX(T.MontoPedido) AS [Mayor Monto],
    MIN(T.MontoPedido) AS [Menor Monto]
FROM (
    SELECT P.IDPEDIDO, P.IDCLIENTE, SUM(D.CANTIDAD * D.PRECIOUNIDAD) AS MontoPedido
    FROM PEDIDOSCABE P
    INNER JOIN PEDIDOSDETA D ON P.IDPEDIDO = D.IDPEDIDO
    GROUP BY P.IDPEDIDO, P.IDCLIENTE
) AS T
INNER JOIN CLIENTES C ON T.IDCLIENTE = C.IDCLIENTE
GROUP BY C.NOMCLIENTE
HAVING C.NOMCLIENTE = @NOM_CLI;
GO

-- 6. Mayor precio registrado en los productos según un determinado proveedor.
DECLARE @PROV_PRECIO VARCHAR(100) = 'Exotic Liquids';
SELECT 
    PRV.NOMPROVEEDOR AS [Proveedor],
    MAX(P.PRECIOUNIDAD) AS [Mayor Precio]
FROM PRODUCTOS P
INNER JOIN PROVEEDORES PRV ON P.IDPROVEEDOR = PRV.IDPROVEEDOR
GROUP BY PRV.NOMPROVEEDOR
HAVING PRV.NOMPROVEEDOR = @PROV_PRECIO;
GO

-- 7. Nombres de los proveedores y número total de productos registrados por cada proveedor.
SELECT 
    PRV.NOMPROVEEDOR AS [Proveedor],
    COUNT(P.IDPRODUCTO) AS [Total Productos]
FROM PROVEEDORES AS PRV
INNER JOIN PRODUCTOS AS P ON PRV.IDPROVEEDOR = P.IDPROVEEDOR
GROUP BY PRV.NOMPROVEEDOR
ORDER BY [Total Productos] DESC;
GO

-- 8A. Clientes y total de pedidos registrados por cada cliente.
SELECT 
    C.NOMCLIENTE AS [Cliente],
    COUNT(P.IDPEDIDO) AS [Total Pedidos]
FROM CLIENTES AS C
INNER JOIN PEDIDOSCABE AS P ON C.IDCLIENTE = P.IDCLIENTE
GROUP BY C.NOMCLIENTE
ORDER BY [Total Pedidos] DESC;
GO

-- 8B. Empleados y acumulado de montos según los pedidos registrados por empleado.
SELECT 
    E.NOMEMPLEADO + ' ' + E.APEEMPLEADO AS [Empleado],
    SUM(D.CANTIDAD * D.PRECIOUNIDAD) AS [Monto Acumulado]
FROM EMPLEADOS AS E
INNER JOIN PEDIDOSCABE AS P ON E.IDEMPLEADO = P.IDEMPLEADO
INNER JOIN PEDIDOSDETA AS D ON P.IDPEDIDO = D.IDPEDIDO
GROUP BY E.NOMEMPLEADO, E.APEEMPLEADO
ORDER BY [Monto Acumulado] DESC;
GO

-- 9. Total de clientes por país.
SELECT 
    PAIS AS [País],
    COUNT(IDCLIENTE) AS [Total Clientes]
FROM CLIENTES
GROUP BY PAIS
ORDER BY [Total Clientes] DESC;
GO

-- 10. Pedidos y acumulado de sus montos (Cantidad x PrecioUnidad).
SELECT 
    P.IDPEDIDO AS [Nro Pedido],
    P.FECHAPEDIDO AS [Fecha],
    SUM(D.CANTIDAD * D.PRECIOUNIDAD) AS [Monto Total]
FROM PEDIDOSCABE AS P
INNER JOIN PEDIDOSDETA AS D ON P.IDPEDIDO = D.IDPEDIDO
GROUP BY P.IDPEDIDO, P.FECHAPEDIDO
ORDER BY P.IDPEDIDO;
GO

-- 11. Procedimiento: Monto total acumulado de pedidos de un determinado año y mes.
CREATE PROCEDURE usp_monto_acumulado_anio_mes
    @Anio INT,
    @Mes INT
AS
BEGIN
    SELECT 
        YEAR(P.FECHAPEDIDO) AS [Año],
        MONTH(P.FECHAPEDIDO) AS [Mes],
        SUM(D.CANTIDAD * D.PRECIOUNIDAD) AS [Monto Total Acumulado]
    FROM PEDIDOSCABE AS P
    INNER JOIN PEDIDOSDETA AS D ON P.IDPEDIDO = D.IDPEDIDO
    GROUP BY YEAR(P.FECHAPEDIDO), MONTH(P.FECHAPEDIDO)
    HAVING YEAR(P.FECHAPEDIDO) = @Anio AND MONTH(P.FECHAPEDIDO) = @Mes;
END;
GO

-- 12. Procedimiento: Monto acumulado según los pedidos por un determinado empleado.
CREATE PROCEDURE usp_monto_acumulado_por_empleado
    @NombreEmpleado VARCHAR(100)
AS
BEGIN
    SELECT 
        E.NOMEMPLEADO + ' ' + E.APEEMPLEADO AS [Empleado],
        SUM(D.CANTIDAD * D.PRECIOUNIDAD) AS [Monto Acumulado]
    FROM EMPLEADOS AS E
    INNER JOIN PEDIDOSCABE AS P ON E.IDEMPLEADO = P.IDEMPLEADO
    INNER JOIN PEDIDOSDETA AS D ON P.IDPEDIDO = D.IDPEDIDO
    GROUP BY E.NOMEMPLEADO, E.APEEMPLEADO
    HAVING E.NOMEMPLEADO + ' ' + E.APEEMPLEADO = @NombreEmpleado;
END;
GO

-- 13. Procedimiento: Número total de pedidos registrados por un determinado cliente.
CREATE PROCEDURE usp_total_pedidos_por_cliente
    @NombreCliente VARCHAR(100)
AS
BEGIN
    SELECT 
        C.NOMCLIENTE AS [Cliente],
        COUNT(P.IDPEDIDO) AS [Total Pedidos]
    FROM CLIENTES AS C
    INNER JOIN PEDIDOSCABE AS P ON C.IDCLIENTE = P.IDCLIENTE
    GROUP BY C.NOMCLIENTE
    HAVING C.NOMCLIENTE = @NombreCliente;
END;
GO