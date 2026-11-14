Use master
go

If DB_ID('BD_FARMACIA') is not null
	Drop Database BD_FARMACIA
go

Create Database BD_FARMACIA
On Primary(
	Name = 'BD_FARMACIA_PRI',
	FileName = 'D:\FARMACIA\DATA\BD_FARMACIA.MDF',
	Size = 30,
	MaxSize = Unlimited,
	Filegrowth = 12%
),
(
	Name = 'BD_FARMACIA_SEC',
	FileName = 'D:\FARMACIA\SEC\BD_FARMACIA.NDF',
	Size = 25,
	MaxSize = 150,
	Filegrowth = 8
)
Log On (
	Name = 'BD_FARMACIA_TRA',
	FileName = 'D:\FARMACIA\TRANS\BD_FARMACIA.LDF',
	Size = 15,
	MaxSize = 200,
	Filegrowth = 8
)
go

sp_helpdb BD_FARMACIA
go