USE Productsdb_Shadiev_Abduvokhidov

SELECT Id, CAST(Createdate AS NVARCHAR) + '; total: ' + CAST(Price * ProductCount AS NVARCHAR)
FROM Orders

SELECT
	CONVERT(NVARCHAR, Createdate, 3),
	CONVERT(NVARCHAR, Price * ProductCount, 1)
FROM Orders

SELECT TRY_CONVERT(int, 'sql')
SELECT TRY_CONVERT(int, '22')

SELECT ProductName, Manufacturer,
	CASE ProductCount
		WHEN 1 THEN 'Товар заканчивается'
		WHEN 2 THEN 'Мало товара'
		WHEN 3 THEN 'Есть в наличии'
		ELSE 'Много товара'
	END AS EvaluateCount
FROM Products

SELECT ProductName, Manufacturer,
	CASE
		WHEN Price > 50000 THEN 'Категория A'
		WHEN Price BETWEEN 40000 AND 50000 THEN 'Категория B'
		WHEN Price BETWEEN 30000 AND 40000 THEN 'Категория C'
		ELSE 'Категория D'
	END AS Category
FROM Products

SELECT ProductName, Manufacturer,
	IIF(ProductCount > 3, 'Много товара', 'Мало товара')
FROM Products

USE lecture_Primer_Shadiev_Abduvokhidov

CREATE TABLE #Movie
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100),
	Rating VARCHAR(10),
	Drama NVARCHAR(1),
	Comdey NVARCHAR(1),
	[Action] NVARCHAR(1),
	Gore NVARCHAR(1),
	Staff NVARCHAR(1),
	ForKids NVARCHAR(1),
	Cartoon NVARCHAR(1),
	Purchased DATE,
);
GO

INSERT INTO #Movie (Title, Rating, Drama, Comdey, [Action], Gore, Staff, ForKids, Cartoon, Purchased)
VALUES
('Корпорация монстров',   'G', 'Д', 'Д', 'Н', 'Н', 'Н', 'Д', 'Д', '2002-03-06'),
('Крестный отец',          'R', 'Н', 'Н', 'Д', 'Д', 'Н', 'Н', 'Н', '2001-02-05'),
('Унесенные ветром',       'G', 'Д', 'Н', 'Н', 'Н', 'Н', 'Н', 'Н', '1999-11-20'),
('Американский пирог',     'R', 'Н', 'Д', 'Н', 'Н', 'Н', 'Н', 'Н', '2003-04-19'),
('Кошмар на улице Вязов',  'R', 'Н', 'Н', 'Д', 'Д', 'Н', 'Н', 'Н', '2003-04-19'),
('Касабланка',             'PG','Д', 'Н', 'Н', 'Н', 'Н', 'Н', 'Н', '2001-02-05');

CREATE TABLE Rating
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(10),
);
GO

CREATE TABLE Purchased
(
	Id INT PRIMARY KEY IDENTITY,
	[Date] DATE,
);

CREATE TABLE Genre
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100),
);

CREATE TABLE Movie
(
	Id INT PRIMARY KEY IDENTITY,
	RatingId INT FOREIGN KEY REFERENCES Rating(Id),
	PurchasedId INT FOREIGN KEY REFERENCES Purchased(Id),
	Title NVARCHAR(100),
);
GO

CREATE TABLE GenreMovie
(
	GenreId INT FOREIGN KEY REFERENCES Genre(Id),
	MovieId INT FOREIGN KEY REFERENCES Movie(Id),
	PRIMARY KEY(MovieId,GenreId),
);

GO

INSERT INTO Purchased([Date])
SELECT Purchased FROM #Movie

INSERT INTO Rating(Title)
SELECT DISTINCT Rating FROM #Movie

INSERT INTO Genre(Title)
VALUES
('Drama'),
('Comdey'),
('Action'),
('Gore'),
('Staff'),
('ForKids'),
('Cartoon');

GO

INSERT INTO Movie(RatingId, Title, PurchasedId)
SELECT r.Id, m.Title, p.Id FROM #Movie AS m
JOIN Rating r ON r.Title = m.Rating
JOIN Purchased p ON p.[Date] = m.Purchased

INSERT INTO GenreMovie (MovieId, GenreId)
SELECT 
    m.Id AS MovieId,
    g.Id AS GenreId
FROM #Movie tmp
JOIN Movie m ON tmp.Title = m.Title
CROSS APPLY(
	VALUES
		('Drama',tmp.Drama),
		('Comedy', tmp.Comdey),
        ('Action', tmp.[Action]),
        ('Gore', tmp.Gore),
        ('Staff', tmp.Staff),
        ('ForKids', tmp.ForKids),
        ('Cartoon', tmp.Cartoon)
	) AS ct(GenreName, Flag)
	JOIN Genre g ON ct.GenreName = g.Title
WHERE 
    ct.Flag = 'Д';

USE Vasya_list_Shadiev_Abduvokhidov
ALTER TABLE VasyaList
ADD Age INT;
GO

UPDATE vl
SET vl.Age = DATEDIFF(YEAR, b.[Date], GETDATE())
FROM VasyaList vl
JOIN Birthday b ON b.[Id] = vl.BirthdayId

UPDATE Salaries
SET WorkExperience += DATEDIFF(YEAR, WorkStartDate, GETDATE());

ALTER TABLE Salaries
ADD Awards NVARCHAR(100);
GO

UPDATE Salaries
SET Awards = IIF(WorkExperience > 10, 'За самоотверженный труд', NULL);

USE PaidPolyclinic_Shadiev_Abduvohidov_47

-- Добавляем столбец "Возраст" в таблицу Patient
ALTER TABLE Patient
ADD Age AS DATEDIFF(YEAR, Birthday, GETDATE());
GO
-- Проверка результатов
SELECT 
    LastName AS Фамилия,
    Name AS Имя,
    Birthday AS [Дата рождения],
    Age
FROM Patient;

ALTER TABLE Doctor
ADD WorkExperience INT;
GO

-- Заполняем стаж на основе квалификации (условный пример)
UPDATE Doctor
SET WorkExperience = CASE QualificationId
    WHEN 1 THEN 15
    WHEN 2 THEN 10
    WHEN 3 THEN 5
    WHEN 4 THEN 20
    WHEN 5 THEN 25
END;
Go

-- Проверка результатов
SELECT 
    LastName AS Фамилия,
    [Name] AS Имя,
    WorkExperience
FROM Doctor;

-- Добавляем столбец "Награды"
ALTER TABLE Doctor
ADD Awards NVARCHAR(100);
GO

-- Заполняем награды
UPDATE Doctor
SET Awards = IIF(WorkExperience > 10, 'За самоотверженный труд', NULL);

-- Проверка результатов
SELECT 
    LastName AS Фамилия,
    Name AS Имя,
    WorkExperience,
    Awards
FROM Doctor;

-- Общая стоимость лечения для каждого пациента
SELECT 
    p.LastName AS Фамилия,
    p.Name AS Имя,
    SUM(st.Cost * t.Quantity) AS [Общая стоимость]
FROM Patient p
JOIN Appeal a ON p.Id = a.PatientId
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY p.LastName, p.Name;

-- Доход по специальностям врачей
SELECT 
    s.Name AS Специальность,
    SUM(st.Cost * t.Quantity) AS Доход
FROM Doctor d
JOIN Specialty s ON d.SpecialtyId = s.Id
JOIN Appeal a ON d.Id = a.DoctorId
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY s.Name;

-- Форматирование даты обращения
SELECT 
    Id AS [Номер обращения],
    FORMAT(Date, 'dd-MM-yyyy') AS [Дата],
    Diagnos AS Диагноз
FROM Appeal;

-- Категоризация стоимости услуг
SELECT 
    Name AS Услуга,
    Cost AS Стоимость,
    CASE 
        WHEN Cost > 2000 THEN 'Высокая'
        WHEN Cost BETWEEN 1000 AND 2000 THEN 'Средняя'
        ELSE 'Низкая'
    END AS Категория
FROM ServiceType;