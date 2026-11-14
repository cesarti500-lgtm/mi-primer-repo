USE COMERCIOS;
GO

-- 1. Datos de empleados con año de nacimiento, año de contratación, distrito y cargo.
SELECT 
    E.IdEmpleado AS [Código],
    E.NomEmpleado AS [Nombres],
    E.ApeEmpleado AS [Apellidos],
    E.DirEmpleado AS [Dirección],
    YEAR(E.FecNac) AS [Año_Nacimiento],
    YEAR(E.FecContrata) AS [Año_contrato],
    D.NombreDistrito AS [Nombre_distrito],
    C.desCargo AS [Nombre_cargo]
FROM empleados AS E
INNER JOIN Distritos AS D ON E.idDistrito = D.IdDistrito
INNER JOIN Cargos AS C ON E.idCargo = C.idcargo;
GO

-- 2. Empleados cuyo apellido termina en 'r', contratados en 2011 y de cargo 'representante de ventas'.
SELECT 
    E.IdEmpleado,
    E.ApeEmpleado,
    E.NomEmpleado,
    YEAR(E.FecContrata) AS [Año_contrato],
    C.desCargo
FROM empleados AS E
INNER JOIN Cargos AS C ON E.idCargo = C.idcargo
WHERE E.ApeEmpleado LIKE '%r'
  AND YEAR(E.FecContrata) = 2011
  AND C.desCargo = 'representante de ventas';
GO

-- 3. Documentos del cliente 'ANTONIO MORENO TAQUERIA', tipo Boleta y estado al contado.
SELECT 
    DOC.IdDocumento AS [Nro_documento],
    DOC.FechaVenta AS [Fecha de Venta],
    DOC.Tipo_Documento AS [Tipo de comprobante],
    DOC.Estado AS [Estado de venta],
    CLI.NomCliente AS [Cliente]
FROM Documento AS DOC
INNER JOIN clientes AS CLI ON DOC.IdCliente = CLI.IdCliente
WHERE CLI.NomCliente = 'ANTONIO MORENO TAQUERIA'
  AND DOC.Tipo_Documento = 'Boleta'
  AND DOC.Estado = 'contado';
GO

-- 4. Productos que comienzan con M o Q, precio entre 10 y 80, stock entre 5 y 150, categoría lácteos.
SELECT 
    P.IdProducto AS [Código],
    P.NomProducto AS [Descripción],
    P.CantxUnidad AS [Cantidad],
    P.PrecioUnidad AS [Precio unitario],
    P.UnidadesEnExistencia AS [stock actual],
    CAT.NombreCategoria AS [Categoría]
FROM productos AS P
INNER JOIN categorias AS CAT ON P.IdCategoria = CAT.IdCategoria
WHERE (P.NomProducto LIKE 'M%' OR P.NomProducto LIKE 'Q%')
  AND P.PrecioUnidad BETWEEN 10 AND 80
  AND P.UnidadesEnExistencia BETWEEN 5 AND 150
  AND CAT.NombreCategoria = 'lácteos';
GO

-- 5. Proveedores con segunda letra 'o' en su nombre y pertenecientes al distrito de Ventanilla.
SELECT 
    PRV.*,
    DIS.NombreDistrito
FROM proveedores AS PRV
INNER JOIN Distritos AS DIS ON PRV.idDistrito = DIS.IdDistrito
WHERE PRV.NomProveedor LIKE '_o%'
  AND DIS.NombreDistrito = 'Ventanilla';
GO

-- ==================== PROCEDIMIENTOS ALMACENADOS ====================

-- 6. Sin parámetros: usp_listar_clientes
CREATE PROCEDURE usp_listar_clientes
AS
BEGIN
    SELECT 
        C.IdCliente,
        C.NomCliente,
        C.DirCliente,
        C.RUC,
        D.NombreDistrito
    FROM clientes AS C
    INNER JOIN Distritos AS D ON C.idDistrito = D.IdDistrito;
END;
GO

-- 7. Con 1 parámetro: usp_productos_por_proveedor
CREATE PROCEDURE usp_productos_por_proveedor
    @NomProveedor VARCHAR(100)
AS
BEGIN
    SELECT 
        P.IdProducto AS [Código],
        P.NomProducto AS [Descripción],
        P.CantxUnidad AS [Cantidad],
        P.PrecioUnidad AS [Precio Unitario],
        P.UnidadesEnExistencia AS [Stock],
        PRV.NomProveedor AS [Proveedor]
    FROM productos AS P
    INNER JOIN proveedores AS PRV ON P.IdProveedor = PRV.IdProveedor
    WHERE PRV.NomProveedor = @NomProveedor;
END;
GO

-- 8. Con 1 parámetro: usp_listar_empleados_por_año_contrato
CREATE PROCEDURE usp_listar_empleados_por_año_contrato
    @AnioContrato INT
AS
BEGIN
    SELECT 
        E.IdEmpleado AS [Código],
        E.ApeEmpleado AS [Apellidos],
        E.NomEmpleado AS [Nombres],
        E.FecContrata AS [Fecha Contratación],
        D.NombreDistrito AS [Distrito],
        C.desCargo AS [Cargo]
    FROM empleados AS E
    INNER JOIN Distritos AS D ON E.idDistrito = D.IdDistrito
    INNER JOIN Cargos AS C ON E.idCargo = C.idcargo
    WHERE YEAR(E.FecContrata) = @AnioContrato;
END;
GO

-- 9. Con 1 parámetro: usp_listar_documentos_por_año
CREATE PROCEDURE usp_listar_documentos_por_año
    @AnioVenta INT
AS
BEGIN
    SELECT 
        DOC.IdDocumento AS [Nro Documento],
        DOC.FechaVenta AS [Fecha Venta],
        DOC.Tipo_Documento AS [Tipo],
        DOC.Estado AS [Estado],
        CLI.NomCliente AS [Cliente],
        EMP.NomEmpleado AS [Empleado]
    FROM Documento AS DOC
    INNER JOIN clientes AS CLI ON DOC.IdCliente = CLI.IdCliente
    INNER JOIN empleados AS EMP ON DOC.IdEmpleado = EMP.IdEmpleado
    WHERE YEAR(DOC.FechaVenta) = @AnioVenta;
END;
GO

-- 10. Con 2 parámetros: usp_productos_por_proveedor_y_categoria
CREATE PROCEDURE usp_productos_por_proveedor_y_categoria
    @NomProveedor VARCHAR(100),
    @NomCategoria VARCHAR(100)
AS
BEGIN
    SELECT 
        P.IdProducto AS [Código],
        P.NomProducto AS [Producto],
        P.UnidadesEnExistencia AS [Stock],
        PRV.NomProveedor AS [Proveedor],
        CAT.NombreCategoria AS [Categoría]
    FROM productos AS P
    INNER JOIN proveedores AS PRV ON P.IdProveedor = PRV.IdProveedor
    INNER JOIN categorias AS CAT ON P.IdCategoria = CAT.IdCategoria
    WHERE PRV.NomProveedor = @NomProveedor
      AND CAT.NombreCategoria = @NomCategoria;
END;
GO

-- 11. Con 2 parámetros: usp_empleados_contratados_en_año_mes
CREATE PROCEDURE usp_empleados_contratados_en_año_mes
    @Anio INT,
    @Mes INT
AS
BEGIN
    SELECT 
        E.IdEmpleado AS [Código],
        E.ApeEmpleado AS [Apellidos],
        E.NomEmpleado AS [Nombres],
        E.FecContrata AS [Fecha Contratación],
        E.Sueldo AS [Sueldo],
        D.NombreDistrito AS [Distrito]
    FROM empleados AS E
    INNER JOIN Distritos AS D ON E.idDistrito = D.IdDistrito
    WHERE YEAR(E.FecContrata) = @Anio
      AND MONTH(E.FecContrata) = @Mes;
END;
GO

-- 12. Con 2 parámetros: usp_documentos_por_rango_años
CREATE PROCEDURE usp_documentos_por_rango_años
    @AnioInicio INT,
    @AnioFin INT
AS
BEGIN
    SELECT 
        DOC.IdDocumento AS [Nro Documento],
        EMP.NomEmpleado AS [Empleado],
        CLI.NomCliente AS [Cliente],
        DOC.FechaVenta AS [Fecha Venta],
        DOC.Tipo_Documento AS [Tipo Documento]
    FROM Documento AS DOC
    INNER JOIN empleados AS EMP ON DOC.IdEmpleado = EMP.IdEmpleado
    INNER JOIN clientes AS CLI ON DOC.IdCliente = CLI.IdCliente
    WHERE YEAR(DOC.FechaVenta) BETWEEN @AnioInicio AND @AnioFin;
END;
GO

-- 13. Con 3 parámetros: usp_listar_documentos_por_año_tipo_cliente
CREATE PROCEDURE usp_listar_documentos_por_año_tipo_cliente
    @Anio INT,
    @TipoDoc VARCHAR(30),
    @NomCliente VARCHAR(100)
AS
BEGIN
    SELECT 
        DOC.IdDocumento AS [Nro Documento],
        DOC.FechaVenta AS [Fecha Venta],
        DOC.Tipo_Documento AS [Tipo Documento],
        CLI.NomCliente AS [Cliente]
    FROM Documento AS DOC
    INNER JOIN clientes AS CLI ON DOC.IdCliente = CLI.IdCliente
    WHERE YEAR(DOC.FechaVenta) = @Anio
      AND DOC.Tipo_Documento = @TipoDoc
      AND CLI.NomCliente = @NomCliente;
END;
GO

-- 14. Con 3 parámetros: usp_listar_productos_por_unidades_y_categoria
CREATE PROCEDURE usp_listar_productos_por_unidades_y_categoria
    @StockMin INT,
    @StockMax INT,
    @NomCategoria VARCHAR(100)
AS
BEGIN
    SELECT 
        P.*,
        CAT.NombreCategoria AS [Categoría]
    FROM productos AS P
    INNER JOIN categorias AS CAT ON P.IdCategoria = CAT.IdCategoria
    WHERE P.UnidadesEnExistencia BETWEEN @StockMin AND @StockMax
      AND CAT.NombreCategoria = @NomCategoria;
END;
GO

-- 15. Con 2 parámetros: usp_listar_productos_por_letras
CREATE PROCEDURE usp_listar_productos_por_letras
    @Letra1 CHAR(1),
    @Letra2 CHAR(1)
AS
BEGIN
    SELECT 
        P.*,
        CAT.NombreCategoria AS [Categoría],
        PRV.NomProveedor AS [Proveedor]
    FROM productos AS P
    INNER JOIN categorias AS CAT ON P.IdCategoria = CAT.IdCategoria
    INNER JOIN proveedores AS PRV ON P.IdProveedor = PRV.IdProveedor
    WHERE P.NomProducto LIKE @Letra1 + '%'
       OR P.NomProducto LIKE @Letra2 + '%';
END;
GO