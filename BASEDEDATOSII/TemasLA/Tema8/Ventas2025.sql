USE VENTAS2025;
GO

-- 1. Declarar 4 variables: MontoCompra, Incremento (15%), Dscto (6%) y total.
DECLARE @MontoCompra DECIMAL(10,2) = 1000.00;
DECLARE @Incremento DECIMAL(10,2);
DECLARE @Dscto DECIMAL(10,2);
DECLARE @Total DECIMAL(10,2);

SET @Incremento = @MontoCompra * 0.15;
SET @Dscto = @MontoCompra * 0.06;
SET @Total = @MontoCompra + @Incremento - @Dscto;

SELECT 
    @MontoCompra AS [Monto Compra],
    @Incremento AS [Incremento 15%],
    @Dscto AS [Descuento 6%],
    @Total AS [Total a Pagar];
GO

-- 2. Crear procedimiento almacenado sp_listar_boletas que muestre todas las boletas.
CREATE PROCEDURE sp_listar_boletas
AS
BEGIN
    SELECT * FROM BOLETA;
END;
GO

-- 3. Modificar sp_listar_boletas mostrando num_boleta y fecha_emi con alias.
ALTER PROCEDURE sp_listar_boletas
AS
BEGIN
    SELECT 
        B.NUM_BOLETA AS [Número de Boleta],
        B.FECHA_EMI AS [Fecha de Emisión]
    FROM BOLETA AS B;
END;
GO

-- 4. Eliminar el procedimiento almacenado sp_listar_boletas.
DROP PROCEDURE sp_listar_boletas;
GO

-- 5. Procedimiento para listar clientes según el código de distrito ingresado.
CREATE PROCEDURE sp_clientes_por_distrito
    @IdDistrito CHAR(4)
AS
BEGIN
    SELECT C.*
    FROM CLIENTE AS C
    WHERE C.ID_DISTRITO = @IdDistrito;
END;
GO

-- 6. Procedimiento que recibe 2 códigos de distrito y muestra los empleados que pertenecen a ellos.
CREATE PROCEDURE sp_empleados_dos_distritos
    @Distrito1 CHAR(4),
    @Distrito2 CHAR(4)
AS
BEGIN
    SELECT E.*
    FROM EMPLEADO AS E
    WHERE E.ID_DISTRITO IN (@Distrito1, @Distrito2);
END;
GO

-- 7. Procedimiento que verifica detalles de dos boletas usando IN, alias e IF.
CREATE PROCEDURE sp_verificar_detalle_boletas
    @NumBoleta1 CHAR(8),
    @NumBoleta2 CHAR(8)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM DETALLEBOLETA WHERE NUM_BOLETA IN (@NumBoleta1, @NumBoleta2))
    BEGIN
        SELECT 
            D.NUM_BOLETA AS [Número Boleta],
            D.ID_PRODUCTO AS [Código Producto],
            D.CANTIDAD AS [Cantidad],
            D.IMPORTE AS [Importe]
        FROM DETALLEBOLETA AS D
        WHERE D.NUM_BOLETA IN (@NumBoleta1, @NumBoleta2);
    END
    ELSE
    BEGIN
        PRINT 'No existen boletas con ninguno de los números especificados';
    END
END;
GO

-- 8. Procedimiento sp_listado_empleado_por_codigo con validación de existencia.
CREATE PROCEDURE sp_listado_empleado_por_codigo
    @CodEmple CHAR(5)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EMPLEADO WHERE COD_EMPLE = @CodEmple)
    BEGIN
        SELECT * FROM EMPLEADO WHERE COD_EMPLE = @CodEmple;
    END
    ELSE
    BEGIN
        PRINT 'El código de empleado ingresado no existe.';
    END
END;
GO

-- 9. Procedimiento que evalúa observación de precio usando CASE.
CREATE PROCEDURE sp_evaluar_precio_producto
AS
BEGIN
    SELECT 
        P.ID_PRODUCTO AS [Código Producto],
        P.DESCRIPCION AS [Descripción],
        P.PRECIO_VENTA AS [Precio Venta],
        CASE 
            WHEN P.PRECIO_VENTA = 30 THEN 'precio normal'
            WHEN P.PRECIO_VENTA < 30 THEN 'precio en oferta'
            ELSE 'precio elevado'
        END AS [Observación]
    FROM PRODUCTO AS P;
END;
GO

-- 10. Imprimir los 10 primeros números enteros positivos, excepto el 3 y el 5 (WHILE e IF).
DECLARE @Contador INT = 1;
WHILE @Contador <= 10
BEGIN
    IF @Contador <> 3 AND @Contador <> 5
    BEGIN
        PRINT @Contador;
    END
    SET @Contador = @Contador + 1;
END;
GO

-- 11. Procedimiento que muestra empleados y marca 'Seleccionado' si Estado_Civil = 'S'.
CREATE PROCEDURE sp_empleados_estado_civil
AS
BEGIN
    SELECT 
        E.*,
        CASE 
            WHEN E.ESTADO_CIVIL = 'S' THEN 'Seleccionado'
            ELSE ''
        END AS [Observación]
    FROM EMPLEADO AS E;
END;
GO

-- 12. Procedimiento que muestra empleados ingresados en el mes 03 (Marzo).
CREATE PROCEDURE sp_empleados_ingreso_marzo
AS
BEGIN
    SELECT E.*
    FROM EMPLEADO AS E
    WHERE MONTH(E.FECHA_INGRESO) = 3;
END;
GO

-- 13. Procedimiento para insertar un registro completo en la tabla PRODUCTO.
CREATE PROCEDURE sp_insertar_producto
    @IdProducto CHAR(5),
    @Descripcion VARCHAR(100),
    @PrecioVenta DECIMAL(10,2),
    @StockMinimo INT,
    @StockActual INT,
    @FechaVenc DATE,
    @CodCate CHAR(4)
AS
BEGIN
    INSERT INTO PRODUCTO (ID_PRODUCTO, DESCRIPCION, PRECIO_VENTA, STOCK_MINIMO, STOCK_ACTUAL, FECHA_VENC, COD_CATE)
    VALUES (@IdProducto, @Descripcion, @PrecioVenta, @StockMinimo, @StockActual, @FechaVenc, @CodCate);
END;
GO

-- 14. Procedimiento para modificar Stock_Minimo y Stock_Actual de un producto específico.
CREATE PROCEDURE sp_actualizar_stock_producto
    @IdProducto CHAR(5),
    @StockMinimo INT,
    @StockActual INT
AS
BEGIN
    UPDATE PRODUCTO
    SET STOCK_MINIMO = @StockMinimo,
        STOCK_ACTUAL = @StockActual
    WHERE ID_PRODUCTO = @IdProducto;
END;
GO

-- 15. Procedimiento para eliminar un registro específico de la tabla PRODUCTO.
CREATE PROCEDURE sp_eliminar_producto
    @IdProducto CHAR(5)
AS
BEGIN
    DELETE FROM PRODUCTO
    WHERE ID_PRODUCTO = @IdProducto;
END;
GO

-- 16. Procedimiento para aumentar en 10% el Precio_Venta si Stock_Actual < 100.
CREATE PROCEDURE sp_aumentar_precio_bajo_stock
AS
BEGIN
    UPDATE PRODUCTO
    SET PRECIO_VENTA = PRECIO_VENTA * 1.10
    WHERE STOCK_ACTUAL < 100;
END;
GO

-- 17. Procedimiento para disminuir en X% el Precio_Venta si Stock_Actual > 100.
CREATE PROCEDURE sp_disminuir_precio_alto_stock
    @Porcentaje DECIMAL(5,2)
AS
BEGIN
    UPDATE PRODUCTO
    SET PRECIO_VENTA = PRECIO_VENTA * (1 - (@Porcentaje / 100.0))
    WHERE STOCK_ACTUAL > 100;
END;
GO

-- 18. Procedimiento para obtener el Precio_Venta promedio de productos con Fecha_Venc en 2018.
CREATE PROCEDURE sp_promedio_precio_venc_2018
AS
BEGIN
    SELECT AVG(PRECIO_VENTA) AS [Precio Promedio 2018]
    FROM PRODUCTO
    WHERE YEAR(FECHA_VENC) = 2018;
END;
GO

-- 19. Procedimiento que recupera el número de empleados según Cod_Cargo ingresado.
CREATE PROCEDURE sp_contar_empleados_cargo
    @CodCargo CHAR(4)
AS
BEGIN
    SELECT COUNT(*) AS [Total Empleados]
    FROM EMPLEADO
    WHERE COD_CARGO = @CodCargo;
END;
GO

-- 20. Procedimiento para buscar empleados cuyos Apellidos contengan el texto pasado como parámetro.
CREATE PROCEDURE sp_buscar_empleado_apellido
    @Texto VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM EMPLEADO
    WHERE APELLIDOS LIKE '%' + @Texto + '%';
END;
GO