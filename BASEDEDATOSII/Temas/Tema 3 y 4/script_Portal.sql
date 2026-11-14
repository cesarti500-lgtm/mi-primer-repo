USE master;
GO

IF DB_ID('Portal2025') IS NOT NULL
BEGIN
    ALTER DATABASE Portal2025 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Portal2025;
END;
GO

CREATE DATABASE Portal2025;
GO

USE Portal2025;
GO

-- 1. Tabla Categoria
CREATE TABLE tb_categoria (
    cod_cat INT IDENTITY(1,1) NOT NULL,
    des_cat VARCHAR(50)      NOT NULL,
    est_cat CHAR(2)          NOT NULL DEFAULT '01' CHECK (est_cat IN ('01', '02', '03')),
    CONSTRAINT PK_tb_categoria PRIMARY KEY (cod_cat)
);
GO

-- 2. Tabla Producto
CREATE TABLE tb_producto (
    cod_pro INT IDENTITY(1,1) NOT NULL,
    nom_pro VARCHAR(50)      NOT NULL UNIQUE,
    des_pro VARCHAR(200)     NULL,
    pre_pro DECIMAL(10,2)    NOT NULL CHECK (pre_pro > 0),
    stk_pro INT              NOT NULL DEFAULT 0,
    cod_cat INT              NOT NULL,
    est_pro CHAR(2)          NOT NULL DEFAULT '01',
    img_pro VARCHAR(150)     NOT NULL DEFAULT 'NO REGISTRA IMAGEN',
    CONSTRAINT PK_tb_producto PRIMARY KEY (cod_pro),
    CONSTRAINT FK_producto_categoria FOREIGN KEY (cod_cat) REFERENCES tb_categoria(cod_cat)
);
GO

-- 3. Tabla Comentario
CREATE TABLE tb_comentario (
    cod_com INT IDENTITY(1,1) NOT NULL,
    cod_pro INT              NOT NULL,
    dir_com VARCHAR(100)     NOT NULL,
    pun_com INT              NOT NULL CHECK (pun_com BETWEEN 1 AND 5),
    des_com VARCHAR(300)     NOT NULL,
    CONSTRAINT PK_tb_comentario PRIMARY KEY (cod_com),
    CONSTRAINT FK_comentario_producto FOREIGN KEY (cod_pro) REFERENCES tb_producto(cod_pro)
);
GO
