USE VENTAS2025;
GO

-- 1. Seleccionar todos los registros de la tabla Producto.
SELECT * FROM PRODUCTO;
GO

-- 2. Seleccionar los campos nombres, apellidos, direccion, fono, email de la tabla cliente.
SELECT NOMBRES, APELLIDOS, DIRECCION, FONO, EMAIL
FROM CLIENTE;
GO

-- 3. Seleccionar los campos descripcion, precio_venta, stock_actual, stock_minimo de la tabla producto utilizando Alias.
SELECT 
    P.DESCRIPCION,
    P.PRECIO_VENTA,
    P.STOCK_ACTUAL,
    P.STOCK_MINIMO
FROM PRODUCTO AS P;
GO

-- 4. Seleccionar campos de empleado utilizando Alias y cambiando los encabezados de columna.
SELECT 
    E.COD_EMPLE AS [Código],
    E.NOMBRES AS [Nombres],
    E.APELLIDOS AS [Apellidos],
    E.DNI_EMPLE AS [DNI],
    E.DIRECCION AS [Dirección],
    E.TELEFONO AS [Teléfono],
    E.SUELDO_BASICO AS [Sueldo Básico],
    E.FECHA_INGRESO AS [Fecha de Ingreso]
FROM EMPLEADO AS E;
GO

-- 5. Seleccione distintos tipos de Id_producto que aparecen en la tabla detalle Boleta (DISTINCT).
SELECT DISTINCT ID_PRODUCTO
FROM DETALLEBOLETA;
GO

-- 6. Seleccionar Num_boleta, Id_producto y cantidad de detalle Boleta con alias, encabezados y orden ascendente.
SELECT 
    D.NUM_BOLETA AS [Número Boleta],
    D.ID_PRODUCTO AS [Código producto],
    D.CANTIDAD AS [Cantidad]
FROM DETALLEBOLETA AS D
ORDER BY D.ID_PRODUCTO ASC;
GO

-- 7. Mostrar todos los registros de producto con stock_actual mayor a 100.
SELECT P.*
FROM PRODUCTO AS P
WHERE P.STOCK_ACTUAL > 100;
GO

-- 8. Mostrar todos los campos de cliente cuyo id_distrito sea D002, D004 y D006 (operadores de comparación y lógicos).
SELECT C.*
FROM CLIENTE AS C
WHERE C.ID_DISTRITO = 'D002' 
   OR C.ID_DISTRITO = 'D004' 
   OR C.ID_DISTRITO = 'D006';
GO

-- 9. Seleccionar Id_producto, descripcion y precio_venta con precio entre 25 y 90 y stock_actual > 30.
SELECT 
    P.ID_PRODUCTO,
    P.DESCRIPCION,
    P.PRECIO_VENTA
FROM PRODUCTO AS P
WHERE (P.PRECIO_VENTA >= 25 AND P.PRECIO_VENTA <= 90)
  AND P.STOCK_ACTUAL > 30;
GO

-- 10. Seleccionar todos los campos de boleta excepto num_boleta 10000001, 10000003 y 10000005 usando NOT.
SELECT B.*
FROM BOLETA AS B
WHERE NOT (B.NUM_BOLETA = '10000001' OR B.NUM_BOLETA = '10000003' OR B.NUM_BOLETA = '10000005');
GO

-- 11. Seleccionar los 7 primeros campos de Empleado cuyo nivel de educación sea Superior.
SELECT 
    COD_EMPLE,
    NOMBRES,
    APELLIDOS,
    DNI_EMPLE,
    DIRECCION,
    ESTADO_CIVIL,
    NIVEL_EDUCA
FROM EMPLEADO
WHERE NIVEL_EDUCA = 'Superior';
GO

-- 12. Seleccionar productos cuya descripción comienza con 'G' y precio_venta > 20 usando LIKE.
SELECT P.*
FROM PRODUCTO AS P
WHERE P.DESCRIPCION LIKE 'G%'
  AND P.PRECIO_VENTA > 20;
GO

-- 13. Seleccionar productos cuya descripción tenga en la segunda posición 'E' y termine en 'O' usando LIKE.
SELECT P.*
FROM PRODUCTO AS P
WHERE P.DESCRIPCION LIKE '_E%O';
GO

-- 14. Mostrar productos cuyo stock_actual esté entre 30 y 300 y stock_minimo entre 5 y 200 usando BETWEEN.
SELECT P.*
FROM PRODUCTO AS P
WHERE P.STOCK_ACTUAL BETWEEN 30 AND 300
  AND P.STOCK_MINIMO BETWEEN 5 AND 200;
GO

-- 15. Mostrar clientes cuyo id_cliente sea CLI002, CLI003 y CLI005 usando IN.
SELECT C.*
FROM CLIENTE AS C
WHERE C.ID_CLIENTE IN ('CLI002', 'CLI003', 'CLI005');
GO

-- 16. Mostrar cod_emple, apellidos y nombres concatenados, nivel_educa para empleados con DNI terminado en 40 y email en HOTMAIL.COM.
SELECT 
    E.COD_EMPLE AS [Código Empleado],
    CONCAT(E.APELLIDOS, ' ', E.NOMBRES) AS [Apellidos y Nombres],
    E.NIVEL_EDUCA AS [Nivel Educativo]
FROM EMPLEADO AS E
WHERE E.DNI_EMPLE LIKE '%40'
  AND E.EMAIL LIKE '%@HOTMAIL.COM';
GO