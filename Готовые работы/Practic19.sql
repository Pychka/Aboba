USE New_Shadiev_Abduvokhidov;
GO

CREATE PROCEDURE ProductSummary AS
SELECT ProductName AS [Product], Manufacturer, Price
FROM Products;
GO

EXECUTE ProductSummary;
GO

CREATE PROCEDURE AddProduct
	@Name NVARCHAR(20),
	@Manufacturer NVARCHAR(20),
	@Count INT,
	@Price MONEY
AS
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
VALUES(@Name, @Manufacturer, @Count, @Price);
GO

DECLARE @ProdName NVARCHAR(20) = 'Galaxy C7',
		@Company NVARCHAR(20) = 'Samsung',
		@ProdCount INT = 5,
		@Price MONEY = 22000;

EXECUTE AddProduct @ProdName, @Company, @ProdCount, @Price;
EXECUTE AddProduct 'Galaxy C7', 'Samsung', 5, 22000;
GO

SELECT * FROM Products

DECLARE @ProdName NVARCHAR(20) = 'Honor 9',
		@Company NVARCHAR(20) ='Huawei';

EXECUTE AddProduct @Name = @ProdName,
		@Manufacturer = @Company,
		@Count = 3,
		@Price = 18000;
GO

CREATE PROCEDURE AddProductWithOptionalCount
	@Name NVARCHAR(20),
	@Manufacturer NVARCHAR(20),
	@Price MONEY,
	@Count INT = 1
AS
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
VALUES(@Name, @Manufacturer, @Count, @Price);
GO


DECLARE @ProdName NVARCHAR(20) = 'Redmi Note 5A',
		@Company NVARCHAR(20) = 'Xiaomi',
		@Price MONEY = 22000;

EXECUTE AddProductWithOptionalCount @ProdName, @Company, @Price;
GO

SELECT * FROM Products;
GO

CREATE PROCEDURE GetPriceStats
	@MinPrice MONEY OUTPUT,
	@MaxPrice MONEY OUTPUT
AS
SELECT @MinPrice = MIN(Price), @MaxPrice = MAX(Price)
FROM Products;
GO

CREATE PROCEDURE CreateProduct
	@Name NVARCHAR(20),
	@Manufacturer NVARCHAR(20),
	@Count INT,
	@Price MONEY,
	@id INT OUTPUT
AS
	INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
	VALUES(@Name, @Manufacturer, @Count, @Price)
	SET @id = @@IDENTITY;
GO

CREATE PROCEDURE UpdatePrice
    @ProductId INT OUTPUT,
    @NewPrice MONEY OUTPUT,
    @UpdatedPrice MONEY OUTPUT
AS
BEGIN
    UPDATE Products 
    SET Price = @NewPrice 
    WHERE Id = @ProductId;
    
    SELECT @UpdatedPrice = Price,
		@NewPrice = @NewPrice,
		@ProductId = @ProductId
    FROM Products 
    WHERE Id = @ProductId;
END;
GO

DECLARE @id INT, @UpdatePrice MONEY
EXECUTE AddProduct 'Galaxy C7', 'Samsung', 5, 22000;
EXECUTE AddProductWithOptionalCount 'Galaxy C7', 'Samsung', 22000;
EXECUTE GetPriceStats 1000, 2000;
EXECUTE CreateProduct 'Galaxy C7', 'Samsung', 5, 22000, @id;
EXECUTE UpdatePrice 1, 42000, @UpdatePrice;

SELECT @UpdatePrice;
GO

CREATE PROCEDURE GetAvgPrice AS
DECLARE @AvgPrice MONEY
SELECT @AvgPrice = AVG(Price)
FROM Products
RETURN @AvgPrice;
GO

DECLARE @Result MONEY EXECUTE GetAvgPrice;
PRINT @Result;
GO

CREATE PROCEDURE GetAppleCount AS
DECLARE @Count INT SELECT COUNT(Manufacturer)
FROM Products WHERE Manufacturer = 'Apple'
RETURN @Count;
GO

DECLARE @Result INT EXECUTE GetAppleCount;
PRINT @Result

USE Vasya_list_Shadiev_Abduvokhidov

GO
CREATE PROCEDURE CreatePerson
	@Id INT,
	@LastName NVARCHAR(50),
    @FirstName NVARCHAR(50),
    @Email NVARCHAR(50),
	@Status NVARCHAR(100),
	@Birthday DATE,
	@Location NVARCHAR(100),
	@Phone NVARCHAR(20),
	@Gender NVARCHAR(10)
AS
BEGIN
	DECLARE @BirthdayId INT = -11, 	@StatusId INT = -11, @LocationId INT = -11;
	SELECT TOP 1 @BirthdayId = Id FROM Birthday WHERE [Date] = @Birthday;
	SELECT TOP 1 @StatusId = Id FROM [Status] WHERE Title = @Status;
	SELECT TOP 1 @LocationId = Id FROM [Location] WHERE Title = @Location;

	IF @BirthdayId = -11
	BEGIN
		INSERT INTO Birthday([Date])
		VALUES (@Birthday);
		SET @BirthdayId = @@IDENTITY
	END;
	IF @StatusId = -11
	BEGIN
		INSERT INTO [Status](Title)
		VALUES (@Status);
		SET @StatusId = @@IDENTITY
	END;
	IF @LocationId = -11
	BEGIN
		INSERT INTO [Location](Title)
		VALUES (@Location);
		SET @LocationId = @@IDENTITY
	END;

	INSERT INTO VasyaList(Id, LastName, FirstName, Email, [StatusId], BirthdayId, LocationId, Phone, Gender)
	VALUES (@Id, @LastName, @FirstName, @Email, @StatusId, @BirthdayId, @LocationId, @Phone, @Gender)
END;
GO
DECLARE @Id INT
SELECT TOP 1 @Id = Id FROM VasyaList ORDER BY Id DESC
SET @Id += 1;

EXECUTE CreatePerson @Id, 'Имя', 'Фамилия', 'email@gmail.com', 'Замужем', '09/11/2001', 'Тюмень, лавка №11', '78569839969', 'Трамвай'
GO

CREATE PROCEDURE UpdatePerson
	@Id INT,
	@LastName NVARCHAR(50),
    @FirstName NVARCHAR(50),
    @Email NVARCHAR(50),
	@Status NVARCHAR(100),
	@Birthday DATE,
	@Location NVARCHAR(100),
	@Phone NVARCHAR(20),
	@Gender NVARCHAR(10)
AS
BEGIN
	DECLARE @BirthdayId INT = -11, 	@StatusId INT = -11, @LocationId INT = -11;
	SELECT TOP 1 @BirthdayId = Id FROM Birthday WHERE [Date] = @Birthday;
	SELECT TOP 1 @StatusId = Id FROM [Status] WHERE Title = @Status;
	SELECT TOP 1 @LocationId = Id FROM [Location] WHERE Title = @Location;

	IF @BirthdayId = -11
	BEGIN
		INSERT INTO Birthday([Date])
		VALUES (@Birthday);
		SET @BirthdayId = @@IDENTITY
	END;
	IF @StatusId = -11
	BEGIN
		INSERT INTO [Status](Title)
		VALUES (@Status);
		SET @StatusId = @@IDENTITY
	END;
	IF @LocationId = -11
	BEGIN
		INSERT INTO [Location](Title)
		VALUES (@Location);
		SET @LocationId = @@IDENTITY
	END;

	UPDATE VasyaList
	SET
		LastName = @LastName,
		FirstName = @FirstName, 
		Email = @Email,
		StatusId = @StatusId,
		BirthdayId = @BirthdayId,
		LocationId = @LocationId,
		Phone =  @Phone,
		Gender = @Gender
	WHERE Id = @Id
END;
GO

EXECUTE UpdatePerson 26, 'Имя4', 'Фамилия', 'email@gmail.com', 'Замужем', '09/11/2001', 'Тюмень, лавка №11', '78569839969', 'Трамвай'
GO

CREATE PROCEDURE CreateProffesion
	@Title NVARCHAR(100),
	@MinSalary NVARCHAR(100),
	@MaxSalary NVARCHAR(100)
AS
BEGIN
	IF EXISTS(SELECT * FROM Proffesion WHERE Title = @Title)
		RETURN;
	ELSE
	BEGIN
		INSERT INTO Proffesion(Title, MinSalary, MaxSalary)
		VALUES(@Title,@MinSalary,@MaxSalary)
	END;
END;
GO

EXECUTE CreateProffesion 'Ленивец', 10000, 100000
GO

CREATE PROCEDURE SearchEmployee
	@Title NVARCHAR(100),
	@MinSalary NVARCHAR(100),
	@MaxSalary NVARCHAR(100)
AS
BEGIN
	SELECT * FROM Salaries
	JOIN Proffesion p ON p.Id = ProffesionId
	WHERE (Amount < @MinSalary OR Amount < @MaxSalary OR NewSalary < @MinSalary OR NewSalary < @MaxSalary ) AND p.Title = @Title
END;
GO

EXECUTE SearchEmployee 'Веб-разработчик', 10000, 100000
GO

CREATE PROCEDURE SearchAVGSalaryFromProffesion
	@Title NVARCHAR(100)
AS
BEGIN
	SELECT AVG(Amount) AS AVGFromProffesion FROM Salaries
	JOIN Proffesion p ON p.Id = ProffesionId
	WHERE p.Title = @Title
END;
GO

EXECUTE SearchAVGSalaryFromProffesion 'Веб-разработчик'
GO

CREATE PROCEDURE SearchPerson
	@Age INT,
	@Interest NVARCHAR(100),
	@Status NVARCHAR(100),
	@Location NVARCHAR(100)
AS
BEGIN
	SELECT FirstName, LastName, Age, i.Title, s.Title, l.Title FROM VasyaList
	JOIN Interests i ON i.Title = @Interest
	JOIN [Status] s ON s.Title = @Status
	JOIN [Location] l ON l.Title = @Location
	WHERE Age = @Age
END;
GO

EXECUTE SearchPerson 24, 'интерес1', 'статус1', 'Тюмень, лавка №11'
GO

--Установим каскадное удаление чтобы запросы сработали
ALTER TABLE Salaries
DROP CONSTRAINT FK__Salaries__Proffe__70DDC3D8

ALTER TABLE Salaries
ADD CONSTRAINT FK_Salaries_ProfessionId FOREIGN KEY(ProffesionId) REFERENCES Proffesion(Id) ON DELETE CASCADE

ALTER TABLE Salaries
DROP CONSTRAINT FK__Salaries__VasyaL__6FE99F9F

ALTER TABLE Salaries
ADD CONSTRAINT FK_Salaries_VasyaListId FOREIGN KEY(VasyaListId) REFERENCES VasyaList(Id) ON DELETE CASCADE

ALTER TABLE VasyaListSeeking
DROP CONSTRAINT FK__VasyaList__Vasya__4D94879B

ALTER TABLE VasyaListSeeking
ADD CONSTRAINT FK_VasyaListSeeking_VasyaListId FOREIGN KEY(VasyaListId) REFERENCES VasyaList(Id) ON DELETE CASCADE

ALTER TABLE VasyaListInterests
DROP CONSTRAINT FK__VasyaList__Vasya__5165187F

ALTER TABLE VasyaListInterests
ADD CONSTRAINT FK_VasyaListInterests_VasyaListId FOREIGN KEY(VasyaListId) REFERENCES VasyaList(Id) ON DELETE CASCADE
GO

CREATE PROCEDURE RemoveProfession
	@Proffesion NVARCHAR(100)
AS
BEGIN
	DELETE Proffesion
	WHERE Title = @Proffesion
END;
GO

EXECUTE RemoveProfession 'Веб-дизайнер';
GO

CREATE PROCEDURE RemovePersonByInterest
	@Interest NVARCHAR(100)
AS
BEGIN
	DECLARE @InterestId INT;
	SELECT TOP 1 @InterestId = Id FROM Interests WHERE Title = 'интерес1'
	DELETE VasyaList WHERE Id IN (SELECT VasyaListId FROM VasyaListInterests WHERE InterestsId = @InterestId)
END;
GO

EXECUTE RemovePersonByInterest 'интерес1';
GO

CREATE PROCEDURE SearchEmployeeByLoaction
	@Proffesion NVARCHAR(100),
	@Location NVARCHAR(100)
AS
BEGIN
	--Будем считать если у человека IsWork - 0, то он ищет рабту по этой специальности(хоть это и глупо)
	SELECT FirstName, LastName, Amount, NewSalary, p.Title, l.Title, Email FROM VasyaList vl
	JOIN [Location] l ON l.Id = vl.LocationId AND l.Title = @Location
	JOIN Salaries s ON s.VasyaListId = vl.Id
	JOIN Proffesion p ON p.Id = s.ProffesionId AND p.Title = @Proffesion
END;
GO

EXECUTE SearchEmployeeByLoaction 'Frontend-разработчик','Болмарт'
GO

CREATE PROCEDURE UpSalary
	@Proffesion NVARCHAR(100),
	@Location NVARCHAR(100)
AS
BEGIN
	UPDATE s SET Amount += Amount / 10 FROM VasyaList vl
	JOIN Salaries s ON s.VasyaListId = vl.Id
	JOIN Proffesion p ON p.Title = @Proffesion
	JOIN [Location] l ON vl.LocationId = l.Id
	WHERE l.Title = @Location
END;
GO

EXECUTE UpSalary 'Веб-разработчик', 'Болмарт'

USE PaidPolyclinic_Shadiev_Abduvohidov_47
GO

-- Процедура добавляет нового пациента и возвращает его ID через выходной параметр
CREATE PROCEDURE AddPatientWithOutput
    @LastName NVARCHAR(50),
    @Name NVARCHAR(50),
    @Patronymic NVARCHAR(50),
    @Birthday DATE,
    @NewPatientId INT OUTPUT
AS
BEGIN
    INSERT INTO Patient (LastName, [Name], Patronymic, Birthday)
    VALUES (@LastName, @Name, @Patronymic, @Birthday);
    
    SET @NewPatientId = SCOPE_IDENTITY(); -- Возвращает ID добавленной записи
END;
GO

-- Процедура возвращает количество услуг типа "Консультация"
CREATE PROCEDURE GetConsultationCount
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) 
    FROM Treatment T
    JOIN ServiceType ST ON T.ServiceTypeId = ST.Id
    WHERE ST.Name = 'Консультация';
    
    RETURN @Count;
END;
GO

DECLARE @PatientId INT;
EXEC AddPatientWithOutput 
    @LastName = 'Иванова',
    @Name = 'Мария',
    @Patronymic = 'Сергеевна',
    @Birthday = '1999-11-20',
    @NewPatientId = @PatientId OUTPUT;

PRINT 'Добавлен пациент с ID: ' + CAST(@PatientId AS NVARCHAR(10));

DECLARE @ConsultationCount INT;
EXEC @ConsultationCount = GetConsultationCount;
PRINT 'Количество консультаций: ' + CAST(@ConsultationCount AS NVARCHAR(10));