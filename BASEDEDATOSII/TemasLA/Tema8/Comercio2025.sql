USE COMERCIO2025;
GO

-- 1. Mostrar id_documento, Idcliente, tipo_documento y el día de venta con alias.
SELECT 
    D.IdDocumento AS [Número Documento],
    D.IdCliente AS [Código_cliente],
    D.Tipo_Documento AS [Tipo Documento],
    DAY(D.FechaVenta) AS [Día de Venta]
FROM Documento AS D;
GO

-- 2. Mostrar empleados contratados entre los años 2011 y 2013.
SELECT E.*
FROM empleados AS E
WHERE YEAR(E.FecContrata) BETWEEN 2011 AND 2013;
GO

-- 3. Mostrar documentos emitidos en el segundo semestre (julio-diciembre) del año 2024.
SELECT 
    D.IdDocumento AS [Número Documento],
    D.IdCliente AS [Código_cliente],
    D.Tipo_Documento AS [Tipo Documento],
    MONTH(D.FechaVenta) AS [mes de Venta],
    YEAR(D.FechaVenta) AS [año de venta]
FROM Documento AS D
WHERE YEAR(D.FechaVenta) = 2024
  AND MONTH(D.FechaVenta) BETWEEN 7 AND 12;
GO

-- 4. Mostrar todas las ventas emitidas en el año 2024 con tipo de documento Factura.
SELECT D.*
FROM Documento AS D
WHERE YEAR(D.FechaVenta) = 2024
  AND D.Tipo_Documento = 'Factura';
GO

-- 5. Mostrar todas las ventas emitidas al cliente ANATR en el año 2025 con tipo de documento Boleta.
SELECT D.*
FROM Documento AS D
WHERE D.IdCliente = 'ANATR'
  AND YEAR(D.FechaVenta) = 2025
  AND D.Tipo_Documento = 'Boleta';
GO

-- 6. Mostrar empleados contratados en el año 2011 cuyo apellido comienza con 'P' o 'S'.
SELECT E.*
FROM empleados AS E
WHERE YEAR(E.FecContrata) = 2011
  AND (E.ApeEmpleado LIKE 'P%' OR E.ApeEmpleado LIKE 'S%');
GO

-- 7. Mostrar los dos primeros empleados con IdCargo = 1 y año de nacimiento entre 1960 y 2000.
SELECT TOP 2 E.*
FROM empleados AS E
WHERE E.idCargo = 1
  AND YEAR(E.FecNac) BETWEEN 1960 AND 2000
ORDER BY E.Sueldo DESC, YEAR(E.FecNac) DESC;
GO

-- 8. Mostrar todos los documentos emitidos, excepto del año 2024.
SELECT D.*
FROM Documento AS D
WHERE YEAR(D.FechaVenta) <> 2024;
GO

-- 9. Mostrar ventas a partir del año 2024 con tipo Factura ordenadas ascendentemente por código de cliente.
SELECT 
    D.IdDocumento AS [Número Documento],
    D.IdCliente AS [Código Cliente],
    DAY(D.FechaVenta) AS [Día de Venta],
    MONTH(D.FechaVenta) AS [mes de venta],
    YEAR(D.FechaVenta) AS [Años de venta]
FROM Documento AS D
WHERE YEAR(D.FechaVenta) >= 2024
  AND D.Tipo_Documento = 'Factura'
ORDER BY D.IdCliente ASC;
GO

-- 10. Mostrar ventas en 2024 o 2025 con tipo Boleta y estado/condición al Contado ordenadas descendentemente por año.
SELECT 
    D.IdDocumento AS [Número Documento],
    D.IdCliente AS [Código Cliente],
    DAY(D.FechaVenta) AS [Día de Venta],
    MONTH(D.FechaVenta) AS [mes de venta],
    YEAR(D.FechaVenta) AS [Años de venta]
FROM Documento AS D
WHERE YEAR(D.FechaVenta) IN (2024, 2025)
  AND D.Tipo_Documento = 'Boleta'
  AND D.Estado = 'Contado'
ORDER BY YEAR(D.FechaVenta) DESC;
GO

-- 11. Diferencia de valores entre fecha de nacimiento y fecha actual de la tabla empleados.
SELECT 
    CONCAT(E.ApeEmpleado, ' ', E.NomEmpleado) AS [EMPLEADO],
    DATEDIFF(DAY, E.FecNac, GETDATE()) AS [CANTIDAD DE DIAS],
    DATEDIFF(MONTH, E.FecNac, GETDATE()) AS [CANTIDAD DE MESES],
    DATEDIFF(YEAR, E.FecNac, GETDATE()) AS [EDAD EMPLEADO],
    DATEDIFF(WEEK, E.FecNac, GETDATE()) AS [CANTIDAD DE SEMANAS]
FROM empleados AS E;
GO

-- 12. Mostrar fecha, hora completa, hora, minuto y segundo del sistema usando GETDATE() y DATEPART().
SELECT 
    CAST(GETDATE() AS DATE) AS [FECHA],
    CAST(GETDATE() AS TIME(3)) AS [HORA_COMPLETA],
    DATEPART(HOUR, GETDATE()) AS [HORA],
    DATEPART(MINUTE, GETDATE()) AS [MINUTO],
    DATEPART(SECOND, GETDATE()) AS [SEGUNDO];
GO