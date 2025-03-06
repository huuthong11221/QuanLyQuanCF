CREATE DATABASE QUANLYQUANCF
GO


USE  QUANLYQUANCF
GO

----FOOD
----table
----foodcategory
----Acount
----Bill
---Billinfo

CREATE TABLE Tablefood
 (
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'chưa Đặt tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'trống'  ---TRỐNG || CÓ NGƯỜI
 )
GO

CREATE TABLE Account
( 
	Username NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'thống',
	PassWord NVARCHAR(100) NOT NULL DEFAULT 0 ,
	Type INT NOT NULL DEFAULT 0 --1: admin && 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chua dat ten',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)

)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)	
GO 

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT into dbo.Account
	(Username ,
	 DisplayName ,
	 PassWord , 
	 Type
	)
VALUES (N'huuthongad' ,
		N'Huu thong admin' ,
		N'0123' ,
		1
		)
INSERT into dbo.Account
	(Username ,
	 DisplayName ,
	 PassWord , 
	 Type
	)
VALUES (N'huuthong' ,
		N'Huu thong' ,
		N'123' ,
		0
		)
GO

CREATE PROC USP_Login
@userName nvarchar(100) , @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE Username = @userName AND PassWord = @passWord
END
GO



INSERT into dbo.Tablefood
			(name, status)
VALUES (N'Bàn 1')
INSERT into dbo.Tablefood
			(name, status)
VALUES (N'Bàn 2')

INSERT into dbo.Tablefood
			(name, status)
VALUES (N'Bàn 3')

INSERT into dbo.Tablefood
			(name, status)
VALUES (N'Bàn 4')

INSERT into dbo.Tablefood
			(name, status)
VALUES (N'Bàn 5')
----Them ban
DECLARE @i INT = 0

WHILE @i <=10
	BEGIN INSERT dbo.Tablefood (name)VALUES (N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END
GO
CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.Tablefood
GO

EXEC dbo.USP_GetTableList
GO

DECLARE @i INT = 0

WHILE @i <=10
	BEGIN INSERT dbo.Tablefood (name)VALUES (N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i + 1
END
GO
--- them catagory
INSERT into dbo.FoodCategory
			(name)
VALUES (N'Hải sản ')
INSERT into dbo.FoodCategory
			(name)
VALUES (N'Nông sản ')

INSERT into dbo.FoodCategory
			(name)
VALUES (N'rau củ')
INSERT into dbo.FoodCategory
			(name)
VALUES (N'Nước ')

----Them mon ăn
INSERT into dbo.Food
			(name, idCategory, price )
VALUES (N'Mực nướng ',
		1 ,
		120000
		)
INSERT into dbo.Food
			(name, idCategory, price )
VALUES (N'Ngêu ',
		1 ,
		200000
		)
INSERT into dbo.Food
			(name, idCategory, price )
VALUES (N'Dê hấp',
		2 ,
		150000
		)
INSERT into dbo.Food
			(name, idCategory, price )
VALUES (N'Heo nướng ',
		3 ,
		100000
		)
INSERT into dbo.Food
			(name, idCategory, price )
VALUES (N'com chiên ',
		3 ,
		120000
		)
INSERT into dbo.Food
			(name, idCategory, price )
VALUES (N'7up  ',
		4,
		120000
		)

--THêm Bill
INSERT into dbo.Bill
			(DateCheckIn, DateCheckOut, idTable, status)
VALUES (GETDATE() , 
		NULL ,
		3 ,
		0
		)
INSERT into dbo.Bill
			(DateCheckIn, DateCheckOut, idTable, status)
VALUES (GETDATE() , 
		NULL ,
		4 ,
		0
		)
INSERT into dbo.Bill
			(DateCheckIn, DateCheckOut, idTable, status)
VALUES (GETDATE() , 
		NULL ,
		3,
		1
		)
INSERT into dbo.Bill
			(DateCheckIn, DateCheckOut, idTable, status)
VALUES (GETDATE() , 
		NULL ,
		5,
		1
		)
INSERT into dbo.Bill
			(DateCheckIn, DateCheckOut, idTable, status)
VALUES (GETDATE() , 
		NULL ,
		6,
		0
		)
----Thêm billInfo
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (1 , 
		3 ,
		4 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (1 , 
		1 ,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (1 , 
		5 ,
		1 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (2 , 
		6 ,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (2 , 
		1 ,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (3 , 
		5 ,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (5 , 
		5 ,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (5 , 
		 6,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (6 , 
		3 ,
		2 
		)
INSERT into dbo.BillInfo
			(idBill, idFood, count)
VALUES (6 , 
		2,
		2 
		)
UPDATE dbo.Tablefood SET status = N'Co nguoi' WHERE id = 3

SELECT * FROM dbo.Bill
SELECT * FROM dbo.BillInfo

SELECT * FROM dbo.Food
SELECT * FROM dbo.FoodCategory
GO
CREATE PROC  USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT dbo.Bill(
		DateCheckIn , 
		DateCheckOut , 
		idTable , 
		status
		)
	VALUES (
		GETDATE() , 
		NULL ,
		@idTable, 
		0
		) 
END
GO


ALTER PROC  USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT =1
	SELECT @isExitsBillInfo = id, @foodCount = b.count  FROM dbo.BillInfo AS b WHERE idBill = @idBill AND idFood = @idFood
	IF (@isExitsBillInfo > 0)
	BEGIN 
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE 
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
		END
		ELSE
		BEGIN
			INSERT into dbo.BillInfo
						(idBill, idFood, count)
				VALUES (@idBill , 
						@idFood,
						@count 
						)
		END
	END
GO