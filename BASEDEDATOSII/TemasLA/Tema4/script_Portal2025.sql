USE master;
GO

IF DB_ID('Portal2025') IS NOT NULL
    DROP DATABASE Portal2025;
GO

CREATE DATABASE Portal2025;
GO

USE Portal2025;
GO

-- Tabla: tb_categoria
CREATE TABLE tb_categoria (
    cod_cat INT IDENTITY(1,1) NOT NULL,
    des_cat VARCHAR(100) NOT NULL,
    est_cat CHAR(2) NOT NULL CONSTRAINT DF_tb_categoria_est_cat DEFAULT '01',
    CONSTRAINT PK_tb_categoria PRIMARY KEY (cod_cat),
    CONSTRAINT CK_tb_categoria_est_cat CHECK (est_cat IN ('01', '02', '03'))
);
GO

-- Tabla: tb_producto
CREATE TABLE tb_producto (
    cod_pro CHAR(5) NOT NULL,
    nom_pro VARCHAR(100) NOT NULL,
    des_pro VARCHAR(250) NULL,
    pre_pro DECIMAL(10,2) NOT NULL,
    stk_pro INT NOT NULL CONSTRAINT DF_tb_producto_stk_pro DEFAULT 0,
    cod_cat INT NOT NULL,
    est_pro CHAR(2) NOT NULL DEFAULT '01',
    img_pro VARCHAR(255) NOT NULL CONSTRAINT DF_tb_producto_img_pro DEFAULT 'NO REGISTRA IMAGEN',
    CONSTRAINT PK_tb_producto PRIMARY KEY (cod_pro),
    CONSTRAINT UQ_tb_producto_nom_pro UNIQUE (nom_pro),
    CONSTRAINT CK_tb_producto_pre_pro CHECK (pre_pro > 0),
    CONSTRAINT FK_tb_producto_categoria FOREIGN KEY (cod_cat) REFERENCES tb_categoria(cod_cat)
);
GO

-- Tabla: tb_comentario
CREATE TABLE tb_comentario (
    cod_com INT IDENTITY(1,1) NOT NULL,
    cod_pro CHAR(5) NOT NULL,
    dir_com VARCHAR(150) NOT NULL,
    pun_com INT NOT NULL,
    des_com VARCHAR(500) NOT NULL,
    CONSTRAINT PK_tb_comentario PRIMARY KEY (cod_com),
    CONSTRAINT FK_tb_comentario_producto FOREIGN KEY (cod_pro) REFERENCES tb_producto(cod_pro)
);
GO