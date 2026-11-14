-- Pregunta 1
If not exists (Select name from sys.databases where name = 'BD_RENTA')
Begin
	Create Database BD_RENTA
End
go

-- Pregunta 2
Use BD_RENTA
go

-- Pregunta 3
If DB_ID('BD_RENTA') is null
	Create Database BD_RENTA
go

-- Pregunta 4, 6 y 7
Create Table TB_MARCA(
	cod_marca varchar(5) not null,
	nom_marca varchar(50) not null,
	fec_ing date null,
	pais_proc varchar(80) null,
	constraint pk_tb_marca primary key(cod_marca)
)
go

Create Table TB_CLIENTE(
	cod_cli varchar(5) not null,
	nom_cli varchar(30) not null,
	ape_pat_cli varchar(60) not null,
	ape_mat_cli varchar(60) not null,
	fec_nac_cli date null,
	tipo_cli varchar(20) not null,
	constraint pk_tb_cliente primary key(cod_cli)
)
go

Create Table TB_AUTOMOVIL(
	cod_auto varchar(5) not null,
	modelo_auto varchar(40) not null,
	fec_auto date not null,
	color_auto varchar(25) null,
	precio_auto decimal(10,2) not null,
	cod_marca varchar(5) not null,
	constraint pk_tb_automovil primary key(cod_auto),
	constraint fk_automovil_marca foreign key(cod_marca) references TB_MARCA(cod_marca)
)
go

Create Table TB_ALQUILER(
	cod_auto varchar(5) not null,
	cod_cli varchar(5) not null,
	fec_ini_asig date not null,
	fec_fin_asig date null,
	constraint pk_tb_alquiler primary key(cod_auto, cod_cli),
	constraint fk_alquiler_automovil foreign key(cod_auto) references TB_AUTOMOVIL(cod_auto),
	constraint fk_alquiler_cliente foreign key(cod_cli) references TB_CLIENTE(cod_cli)
)
go

-- Pregunta 5
Select name, create_date
From sys.tables
Where type = 'U'
go







