-- CASO PROPUESTO COLEGIO

--Pregunta 1
If Not Exists(Select name From sys.databases Where name = 'BD_COLEGIO')
Begin
	Create Database BD_COLEGIO
End
go


-- Pregunta 2
Use BD_COLEGIO
go


--Pregunta 3
Select name, create_date From sys.databases Where name = 'BD_COLEGIO'
go


--Pregunta 4
Create Table UBIGEO(
	idubigeo char(6) not null,
	distrito varchar(50) not null,
	provincia varchar(50) not null,
	departamento varchar(50) not null
)
go

Create Table Curso(
	idcurso char(5) not null,
	nombrecurso varchar(60) not null,
	horasTeoricas int not null,
	horasPracticas int not null,
	nivel varchar(20) not null,
	grado varchar(20) not null
)
go

Create Table Colegio(
	idcolegio char(5) not null,
	nombre varchar(80) not null,
	direccion varchar(100) not null,
	tipo varchar(30) null,
	idubigeo char(6) not null
)
go

Create Table Alumno(
	idalumno char(8) not null,
	nombre varchar(50) not null,
	apellidos varchar(70) not null,
	fechaNac date null,
	telefono varchar(15) null,
	sexo char(1) null,
	e_mail varchar(60) null,
	idubigeo char(6) not null,
)

Create Table Notas(
	idcurso char(5) not null,
	idalumno char(8) not null,
	B1 decimal(4,2) null,
	B2 decimal(4,2) null,
	B3 decimal(4,2) null,
	B4 decimal(4,2) null,
	promedio decimal(4,2) null
)
go

-- Pregunta 5
Select name, create_date From sys.tables Where Type = 'U'
go

-- Pregunta 6
Alter Table Ubigeo
Add Constraint  pk_ubigeo primary key(idubigeo)
go

Alter Table Curso
Add Constraint pk_curso primary key(idcurso)
go

Alter Table Colegio
Add constraint pk_colegio primary key(idcolegio)
go

Alter Table Alumno
Add constraint pk_alumno primary key(idalumno)
go

Alter Table Notas
Add constraint pk_notas primary key(idcurso, idalumno)
go


-- Pregunta 7
Alter Table Colegio
Add constraint fk_Colegio_Ubigeo foreign key(idubigeo) references Ubigeo(idubigeo)
go

Alter Table Alumno
Add constraint fk_Alumno_Ubigeo foreign key(idubigeo) references Ubigeo(idubigeo)
go


Alter Table Notas
add constraint fk_Notas_Curso foreign key(idcurso) references Curso(idcurso)
go

Alter Table Notas
add constraint fk_Notas_Alumno foreign key(idalumno) references Alumno(idalumno)
go

-- Pregunta 8
Alter Table Alumno
add direccion varchar(80) null
go

-- Pregunta 9
Alter Table Alumno
add telef_movil char(9) null
go


-- Pregunta 10
Alter Table 












