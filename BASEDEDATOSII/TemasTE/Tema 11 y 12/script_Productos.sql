-- 1. Mostrar productos de un determinado proveedor (parámetro: nombre del proveedor).
CREATE PROCEDURE usp_sub_productos_proveedor
    @NomProveedor VARCHAR(100)
AS
BEGIN
    SELECT *
    FROM productos
    WHERE IdProveedor = (
        SELECT IdProveedor
        FROM proveedores
        WHERE NomProveedor = @NomProveedor
    );
END;
GO

-- 2. Mostrar proveedores de un determinado país (parámetro: nombre del país).
CREATE PROCEDURE usp_sub_proveedores_pais
    @NombrePais VARCHAR(80)
AS
BEGIN
    SELECT *
    FROM proveedores
    WHERE idpais = (
        SELECT Idpais
        FROM paises
        WHERE NombrePais = @NombrePais
    );
END;
GO

-- 3. Mostrar productos de una determinada categoría (parámetro: nombre de categoría).
CREATE PROCEDURE usp_sub_productos_categoria
    @NombreCategoria VARCHAR(80)
AS
BEGIN
    SELECT *
    FROM productos
    WHERE IdCategoria = (
        SELECT IdCategoria
        FROM categorias
        WHERE NombreCategoria = @NombreCategoria
    );
END;
GO

-- 4. Mostrar pedidos registrados en un determinado mes (parámetro: número de mes).
CREATE PROCEDURE usp_sub_pedidos_mes
    @Mes INT
AS
BEGIN
    SELECT *
    FROM pedidoscabe
    WHERE IdPedido IN (
        SELECT IdPedido
        FROM pedidoscabe
        WHERE MONTH(FechaPedido) = @Mes
    );
END;
GO

-- 5. Mostrar pedidos de un cliente específico con validación de existencia.
CREATE PROCEDURE usp_sub_pedidos_cliente_validar
    @IdCliente CHAR(5)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM clientes WHERE IdCliente = @IdCliente)
    BEGIN
        SELECT *
        FROM pedidoscabe
        WHERE IdCliente = @IdCliente;
    END
    ELSE
    BEGIN
        PRINT 'No existe cliente';
    END
END;
GO