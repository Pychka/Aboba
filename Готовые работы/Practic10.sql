USE Productsdb_Shadiev_Abduvokhidov;

CREATE TABLE Customers
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL
);
GO
CREATE TABLE Orders
(
	Id INT IDENTITY PRIMARY KEY,
	ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
	CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
	Createdate DATE NOT NULL,
	ProductCount INT DEFAULT 1,
	Price MONEY NOT NULL
);
GO

INSERT INTO Products
VALUES
('iPhone 6', 'Apple', 2, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi 5X', 'Xiaomi', 2, 26000),
('OnePlus 5', 'OnePlus', 6, 38000);

INSERT INTO Customers
VALUES
('Tom'), ('Bob'), ('Sam');

INSERT INTO Orders
VALUES
(
    (SELECT TOP 1 Id FROM Products WHERE ProductName = 'Galaxy S8'),
    (SELECT TOP 1 Id FROM Customers WHERE FirstName = 'Tom'),
    '2017-07-11',
    2,
    (SELECT TOP 1 Price FROM Products WHERE ProductName = 'Galaxy S8')
),
(
    (SELECT TOP 1 Id FROM Products WHERE ProductName = 'iPhone 6S'),
    (SELECT TOP 1 Id FROM Customers WHERE FirstName = 'Tom'),
    '2017-07-13',
    1,
    (SELECT TOP 1 Price FROM Products WHERE ProductName = 'iPhone 6S')
),
(
    (SELECT TOP 1 Id FROM Products WHERE ProductName = 'iPhone 6S'),
    (SELECT TOP 1 Id FROM Customers WHERE FirstName = 'Bob'),
    '2017-07-11',
    1,
    (SELECT TOP 1 Price FROM Products WHERE ProductName = 'iPhone 6S')
);

SELECT * FROM Orders, Customers;

SELECT * FROM Orders, Customers
WHERE Orders.CustomerId = Customers.Id;

SELECT Customers.FirstName, Products.ProductName, Orders.Createdate
FROM Orders, Customers, Products
WHERE Orders.CustomerId = Customers.Id AND Orders.ProductId = Products.Id;

SELECT O.Createdate, O.ProductCount, P.ProductName
FROM Orders AS O
JOIN Products AS P ON P.Id = O.ProductId;

SELECT O.Createdate, O.ProductCount, P.ProductName, C.FirstName
FROM Orders AS O
JOIN  Products AS P ON P.Id = O.ProductId
JOIN Customers AS C ON O.CustomerId = C.Id;

SELECT Orders.Createdate, Customers.FirstName, Products.ProductName
FROM Orders
JOIN Products ON Products.Id = Orders.ProductId
Join Customers ON Customers.Id = Orders.CustomerId
WHERE Products.Price < 45000
ORDER BY Customers.FirstName

SELECT Orders.Createdate, Customers.FirstName, Products.ProductName
FROM Orders
JOIN Products ON Products.Id = Orders.ProductId AND Products.Manufacturer='Apple'
JOIN Customers ON Customers.Id = Orders.CustomerId
ORDER BY Customers.FirstName

SELECT FirstName, Createdate, ProductCount, Price, ProductId
FROM Orders
LEFT JOIN Customers ON Orders.CustomerId = Customers.Id

SELECT FirstName, Createdate, ProductCount, Price, ProductId
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerId = Customers.Id

SELECT FirstName, Createdate, ProductName, Manufacturer
FROM Orders
LEFT JOIN Customers ON Orders.CustomerId = Customers.Id
LEFT JOIN Products ON Orders.ProductId = Products.Id

SELECT FirstName,Createdate, ProductName, Manufacturer
FROM Orders
LEFT JOIN Customers ON Orders.CustomerId = CustomerId
LEFT JOIN Products ON Orders.ProductId = Products.Id
WHERE Products.Price < 45000
ORDER BY Orders.Createdate

SELECT FirstName
FROM Customers
LEFT JOIN Orders ON Customers.Id = Orders.CustomerId
WHERE Orders.CustomerId IS NULL

SELECT FirstName, Createdate, ProductName, Manufacturer
FROM Orders
JOIN Products ON Orders.ProductId = Products.Id AND Products.Price < 45000
LEFT JOIN Customers ON Orders.CustomerId = Customers.Id
ORDER BY Orders.Createdate

SELECT * FROM Orders CROSS JOIN Customers

SELECT * FROM Orders, Customers

SELECT FirstName, COUNT(Orders.Id)
FROM Customers
JOIN Orders ON Orders.CustomerId = Customers.Id
GROUP BY Customers.Id, Customers.FirstName

--Запрос ничего не даст так как у нас все покупатели что-то, да купили :D
SELECT FirstName
FROM Customers AS C
JOIN Orders AS O ON C.Id = O.CustomerId
WHERE O.Id IS NULL

SELECT ProductName, ISNULL (SUM(O.ProductCount * O.Price), 0) AS TotalSaleAmount
FROM Products AS P
LEFT JOIN Orders AS O ON P.Id = O.ProductId
GROUP BY P.Id, P.ProductName
ORDER BY TotalSaleAmount DESC

CREATE DATABASE Bank_Shadiev_Abduvokhidov;
GO

USE Bank_Shadiev_Abduvokhidov

CREATE TABLE Customers
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Accounts MONEY
);
CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
);
GO

INSERT INTO Customers VALUES
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800);

INSERT INTO Employees VALUES
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svenson');

SELECT FirstName, LastName
FROM Customers
UNION SELECT FirstName, LastName
FROM Employees

SELECT FirstName + ' ' + LastName AS FullName
FROM Customers
UNION SELECT FirstName + ' ' + LastName AS EmployeeName
FROM Employees
ORDER BY FullName DESC

SELECT FirstName,LastName
FROM Customers
UNION ALL SELECT FirstName,LastName
FROM Employees

SELECT FirstName, LastName, Accounts + Accounts * 0.1 AS TotalAmount
FROM Customers WHERE Accounts < 3000
UNION SELECT FirstName, LastName, Accounts + Accounts * 0.3 AS TotalAmount
FROM Customers WHERE Accounts >= 3000

SELECT FirstName, LastName
FROM Customers
EXCEPT SELECT FirstName, LastName
FROM Employees

SELECT FirstName, LastName
FROM Employees
EXCEPT SELECT FirstName, LastName
FROM Customers

SELECT FirstName, LastName
FROM Employees
INTERSECT SELECT FirstName, LastName
FROM Customers

USE lecture_Primer_Shadiev_Abduvokhidov

CREATE TABLE ClownInfo
(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(50),
	Gender NVARCHAR(1),
	[Description] NVARCHAR(200)
);

CREATE TABLE Activity
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE
);

CREATE TABLE [Location]
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE
);

CREATE TABLE Appearance
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE
);
GO

CREATE TABLE InfoAppearance
(
	ClownInfoId INT FOREIGN KEY REFERENCES ClownInfo(Id),
	AppearanceId INT FOREIGN KEY REFERENCES Appearance(Id),
	PRIMARY KEY(ClownInfoId, AppearanceId)
);

CREATE TABLE InfoLocation
(
	ClownInfoId INT FOREIGN KEY REFERENCES ClownInfo(Id),
	LocationId INT FOREIGN KEY REFERENCES [Location](Id),
	PRIMARY KEY(ClownInfoId, LocationId)
);

CREATE TABLE InfoActivities
(
	ClownInfoId INT FOREIGN KEY REFERENCES ClownInfo(Id),
	ActivityId INT FOREIGN KEY REFERENCES Activity(Id),
	PRIMARY KEY(ClownInfoId, ActivityId)
);

GO

INSERT INTO ClownInfo(Id, [Name])
SELECT Id, [Name] FROM Clown_Info
GO

CREATE TABLE #ClownAppearence
(
	Id INT,
	Appearence NVARCHAR(255)
);

CREATE TABLE #ClownLocation
(
	Id INT,
	[Location] NVARCHAR(255)
);

CREATE TABLE #ClownActivities
(
	Id INT,
	Activity NVARCHAR(255)
);
GO

INSERT INTO #ClownAppearence (Id, Appearence)
SELECT 
    ci.Id,
    TRIM(VALUE) 
FROM Clown_Info ci
CROSS APPLY STRING_SPLIT(ci.Appearance, ',')
WHERE VALUE NOT IN ('М','Ж','')

INSERT INTO #ClownLocation (Id, [Location])
SELECT 
    ci.Id,
	ci.Last_Seen
FROM Clown_Info ci
WHERE ci.Last_Seen != ''

INSERT INTO #ClownActivities (Id, Activity)
SELECT 
    ci.Id,
    TRIM(VALUE) 
FROM Clown_Info ci
CROSS APPLY STRING_SPLIT(ci.Activities, ',')
WHERE VALUE != ''

GO

INSERT INTO Appearance(Title)
SELECT DISTINCT ca.Appearence 
FROM #ClownAppearence as ca;

INSERT INTO [Location](Title)
SELECT DISTINCT cl.[Location] 
FROM #ClownLocation as cl;

INSERT INTO Activity(Title)
SELECT DISTINCT ca.Activity 
FROM #ClownActivities as ca;

GO

INSERT INTO InfoAppearance(ClownInfoId, AppearanceId)
SELECT 
    ca.Id,
    a.Id
FROM #ClownAppearence ca
INNER JOIN Appearance a ON ca.Appearence = a.Title;

INSERT INTO InfoLocation(ClownInfoId, LocationId)
SELECT 
    cl.Id,
    l.Id
FROM #ClownLocation cl
INNER JOIN [Location] l ON cl.[Location] = l.Title;

INSERT INTO InfoActivities(ClownInfoId, ActivityId)
SELECT 
    ca.Id,
    a.Id
FROM #ClownActivities ca
INNER JOIN Activity a ON ca.Activity = a.Title;

GO
DROP TABLE #ClownActivities
DROP TABLE #ClownLocation
DROP TABLE #ClownAppearence

CREATE TABLE Birthday
(
	Id INT PRIMARY KEY IDENTITY,
	[Date] DATE UNIQUE,
);

/*CREATE TABLE [Location]
(
	Id INT PRIMARY KEY,
	Title NVARCHAR(100),
);*/

CREATE TABLE Proffesion
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);

CREATE TABLE Seeking
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);

CREATE TABLE Interests
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);

CREATE TABLE [Status]
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);
GO

CREATE TABLE VasyaList
(
	Id INT PRIMARY KEY,
	LastName NVARCHAR(50),
	FirstName NVARCHAR(50),
	Email VARCHAR(50),
	StatusId INT FOREIGN KEY REFERENCES [Status](Id),
	BirthdayId INT FOREIGN KEY REFERENCES Birthday(Id),
	ProffesionId INT FOREIGN KEY REFERENCES Proffesion(Id),
	LocationId INT FOREIGN KEY REFERENCES [Location](Id),
);
GO

CREATE TABLE VasyaListSeeking
(
	VasyaListId INT FOREIGN KEY REFERENCES VasyaList(Id),
	SeekingId INT FOREIGN KEY REFERENCES Seeking(Id),
	PRIMARY KEY(VasyaListId, SeekingId)
);

CREATE TABLE VasyaListInterests
(
	VasyaListId INT FOREIGN KEY REFERENCES VasyaList(Id),
	InterestsId INT FOREIGN KEY REFERENCES Interests(Id),
	PRIMARY KEY(VasyaListId, InterestsId)
);
GO

INSERT INTO Proffesion(Title)
SELECT DISTINCT(vl.Profession)
FROM Vasya_list AS vl WHERE Profession IS NOT NULL AND Profession != ''

INSERT INTO [Location](Title)
SELECT DISTINCT(vl.[Location])
FROM Vasya_list AS vl, Clown_Info v2 WHERE [Location] IS NOT NULL AND [Location] != '' AND Last_Seen IS NOT NULL AND Last_Seen != ''

INSERT INTO Birthday([Date])
SELECT DISTINCT(vl.Birthday)
FROM Vasya_list AS vl WHERE Birthday IS NOT NULL AND Birthday != ''

INSERT INTO VasyaList(Id, LastName, FirstName, Email, LocationId, BirthdayId, ProffesionId, StatusId)
SELECT vl.Id, vl.LastName, vl.FirstName, vl.Email, lc.Id AS LocationId, bd.Id AS BirthdayId, pf.Id AS ProffesionId, st.Id AS StatusId
FROM Vasya_list AS vl
JOIN [Location] lc ON vl.[Location] = lc.Title
JOIN Birthday bd ON vl.Birthday = bd.[Date]
JOIN Proffesion pf ON vl.Profession = pf.Title
JOIN [Status] st ON vl.[Status] = st.Title

CREATE TABLE #VasyaSeeking
(
	Id INT,
	Seeking NVARCHAR(255)
);
CREATE TABLE #VasyaInterest
(
	Id INT,
	Interest NVARCHAR(255)
);

GO

INSERT INTO #VasyaSeeking (Id, Seeking)
SELECT 
    vl.Id,
    TRIM(VALUE) 
FROM Vasya_list vl
CROSS APPLY STRING_SPLIT(vl.Seeking, ',')
WHERE VALUE != ''

INSERT INTO #VasyaInterest (Id, Interest)
SELECT 
    vl.Id,
    TRIM(VALUE) 
FROM Vasya_list vl
CROSS APPLY STRING_SPLIT(vl.Interests, ',')
WHERE VALUE != ''

GO

INSERT INTO Interests(Title)
SELECT DISTINCT vi.Interest 
FROM #VasyaInterest as vi;

INSERT INTO Seeking(Title)
SELECT DISTINCT vs.Seeking 
FROM #VasyaSeeking as vs;

INSERT INTO VasyaListInterests(VasyaListId, InterestsId)
SELECT
    vi.Id,
    l.Id
FROM #VasyaInterest vi
INNER JOIN Interests l ON vi.Interest = l.Title;

INSERT INTO VasyaListSeeking(VasyaListId, SeekingId)
SELECT 
    vs.Id,
    l.Id
FROM #VasyaSeeking vs
INNER JOIN Seeking l ON vs.Seeking = l.Title;
GO
DROP TABLE #VasyaInterest
DROP TABLE #VasyaSeeking
SELECT * FROM VasyaListInterests
SELECT Id, LastName, FirstName, vli.InterestsId FROM VasyaList AS vl
INNER JOIN VasyaListInterests vli ON vli.VasyaListId = vl.Id
INNER JOIN VasyaListSeeking vls ON vls.VasyaListId = vl.Id

CREATE DATABASE Clown_Shadiev_Abduvokhidov
CREATE DATABASE Vasya_list_Shadiev_Abduvokhidov
GO

USE Clown_Shadiev_Abduvokhidov

CREATE TABLE ClownInfo
(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(50),
	Gender NVARCHAR(1),
	[Description] NVARCHAR(200)
);

CREATE TABLE Activity
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE
);

CREATE TABLE [Location]
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE
);

CREATE TABLE Appearance
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE
);
GO

CREATE TABLE InfoAppearance
(
	ClownInfoId INT FOREIGN KEY REFERENCES ClownInfo(Id),
	AppearanceId INT FOREIGN KEY REFERENCES Appearance(Id),
	PRIMARY KEY(ClownInfoId, AppearanceId)
);

CREATE TABLE InfoLocation
(
	ClownInfoId INT FOREIGN KEY REFERENCES ClownInfo(Id),
	LocationId INT FOREIGN KEY REFERENCES [Location](Id),
	PRIMARY KEY(ClownInfoId, LocationId)
);

CREATE TABLE InfoActivities
(
	ClownInfoId INT FOREIGN KEY REFERENCES ClownInfo(Id),
	ActivityId INT FOREIGN KEY REFERENCES Activity(Id),
	PRIMARY KEY(ClownInfoId, ActivityId)
);
GO

INSERT INTO ClownInfo
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.ClownInfo

INSERT INTO Activity(Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.Activity

INSERT INTO [Location](Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.[Location]

INSERT INTO Appearance(Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.Appearance

INSERT INTO InfoAppearance
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.InfoAppearance

INSERT INTO InfoLocation
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.InfoLocation

INSERT INTO InfoActivities
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.InfoActivities

GO

USE Vasya_list_Shadiev_Abduvokhidov

CREATE TABLE Birthday
(
	Id INT PRIMARY KEY IDENTITY,
	[Date] DATE UNIQUE,
);

CREATE TABLE [Location]
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100),
);

CREATE TABLE Proffesion
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);

CREATE TABLE Seeking
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);

CREATE TABLE Interests
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);

CREATE TABLE [Status]
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) UNIQUE,
);
GO

CREATE TABLE VasyaList
(
	Id INT PRIMARY KEY,
	LastName NVARCHAR(50),
	FirstName NVARCHAR(50),
	Email VARCHAR(50),
	StatusId INT FOREIGN KEY REFERENCES [Status](Id),
	BirthdayId INT FOREIGN KEY REFERENCES Birthday(Id),
	ProffesionId INT FOREIGN KEY REFERENCES Proffesion(Id),
	LocationId INT FOREIGN KEY REFERENCES [Location](Id),
);
GO

CREATE TABLE VasyaListSeeking
(
	VasyaListId INT FOREIGN KEY REFERENCES VasyaList(Id),
	SeekingId INT FOREIGN KEY REFERENCES Seeking(Id),
	PRIMARY KEY(VasyaListId, SeekingId)
);

CREATE TABLE VasyaListInterests
(
	VasyaListId INT FOREIGN KEY REFERENCES VasyaList(Id),
	InterestsId INT FOREIGN KEY REFERENCES Interests(Id),
	PRIMARY KEY(VasyaListId, InterestsId)
);
GO

INSERT INTO Birthday([Date])
SELECT [Date] FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.Birthday

INSERT INTO Proffesion(Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.Proffesion

INSERT INTO [Location](Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.[Location]

INSERT INTO Seeking(Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.Seeking

INSERT INTO Interests(Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.Interests

INSERT INTO [Status](Title)
SELECT Title FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.[Status]

GO

INSERT INTO VasyaList
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.VasyaList

GO

INSERT INTO VasyaListSeeking
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.VasyaListSeeking

INSERT INTO VasyaListInterests
SELECT * FROM lecture_Primer_Shadiev_Abduvokhidov.dbo.VasyaListInterests

GO

SELECT Email, p.Title AS Proffesion FROM VasyaList AS vl
INNER JOIN Proffesion p ON p.Id = vl.ProffesionId

SELECT LastName, FirstName, s.Title as [Status] FROM VasyaList AS vl
INNER JOIN [Status] s ON s.Id = vl.StatusId

CREATE DATABASE PaidPolyclinic_Shadiev_Abduvohidov_47;  
GO  
USE PaidPolyclinic_Shadiev_Abduvohidov_47;  

CREATE TABLE Patient  
(  
    Id INT PRIMARY KEY IDENTITY,
    LastName NVARCHAR(50) NOT NULL,  
    [Name] NVARCHAR(50) NOT NULL,  
    Patronymic NVARCHAR(50),  
    Birthday DATE NOT NULL  
);  

CREATE TABLE Specialty  
(  
    Id INT PRIMARY KEY IDENTITY,  
    [Name] NVARCHAR(50) NOT NULL UNIQUE  
);  

GO

CREATE TABLE Qualification  
(  
    Id INT PRIMARY KEY IDENTITY,  
    [Name] NVARCHAR(50) NOT NULL UNIQUE  
);  

CREATE TABLE Doctor  
(  
    Id INT PRIMARY KEY IDENTITY,  
    LastName NVARCHAR(50) NOT NULL,  
    [Name] NVARCHAR(50) NOT NULL,  
    Patronymic NVARCHAR(50),  
    SpecialtyId INT NOT NULL FOREIGN KEY REFERENCES Specialty(Id),  
    QualificationId INT NOT NULL FOREIGN KEY REFERENCES Qualification(Id)  
);  

GO

CREATE TABLE ServiceType  
(  
    Id INT PRIMARY KEY IDENTITY,  
    [Name] NVARCHAR(100) NOT NULL UNIQUE,  
    Cost MONEY NOT NULL CHECK (Cost > 0)  
);  

CREATE TABLE Appeal  
(  
    Id INT PRIMARY KEY IDENTITY,  
    PatientId INT NOT NULL FOREIGN KEY REFERENCES Patient(Id),  
    DoctorId INT NOT NULL FOREIGN KEY REFERENCES Doctor(Id),  
    Diagnos NVARCHAR(400),  
    [Date] DATE NOT NULL  
);  

CREATE TABLE Treatment  
(  
    Id INT PRIMARY KEY IDENTITY,  
    AppealId INT NOT NULL FOREIGN KEY REFERENCES Appeal(Id),  
    ServiceTypeId INT NOT NULL FOREIGN KEY REFERENCES ServiceType(Id),  
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity > 0)  
);  
GO

INSERT INTO Specialty ([Name])  
VALUES  
('Терапевт'), ('Хирург'), ('Офтальмолог'), ('Кардиолог'), ('Невролог');  
  
INSERT INTO Qualification ([Name])  
VALUES  
('Высшая категория'), ('Первая категория'), ('Вторая категория'), ('Кандидат наук'), ('Доктор наук');  
 
INSERT INTO Doctor (LastName, [Name], Patronymic, SpecialtyId, QualificationId)  
VALUES  
('Иванов', 'Алексей', 'Петрович', 1, 1),  
('Смирнова', 'Мария', 'Игоревна', 2, 2),  
('Петров', 'Дмитрий', NULL, 3, 3),  
('Козлов', 'Сергей', 'Васильевич', 4, 4),  
('Сидорова', 'Ольга', 'Андреевна', 5, 5);  

INSERT INTO Patient (LastName, [Name], Patronymic, Birthday)  
VALUES  
('Сидоров', 'Иван', 'Михайлович', '1990-05-15'),  
('Петрова', 'Анна', 'Сергеевна', '1985-12-03'),  
('Кузнецов', 'Максим', NULL, '2000-07-22'),  
('Васильева', 'Елена', 'Дмитриевна', '1978-03-30'),  
('Николаев', 'Андрей', 'Иванович', '1995-09-10');  

INSERT INTO ServiceType ([Name], Cost)  
VALUES  
('Консультация', 1500.00),  
('УЗИ', 3000.00),  
('Анализ крови', 800.00),  
('Рентген', 2000.00),  
('Физиотерапия', 1200.00);  

INSERT INTO Appeal (PatientId, DoctorId, Diagnos, [Date])  
VALUES  
(1, 1, 'Грипп', '2023-10-01'),  
(2, 2, 'Аппендицит', '2023-10-02'),  
(3, 3, 'Близорукость', '2023-10-03'),  
(4, 4, 'Аритмия', '2023-10-04'),  
(5, 5, 'Мигрень', '2023-10-05');  

INSERT INTO Treatment (AppealId, ServiceTypeId, Quantity)  
VALUES  
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(3, 1, 1),
(4, 4, 1),
(5, 5, 3);

GO

-- Id обращения, ФИО пациента, ФИО врача, диагноз, дата обращения  
SELECT  
    A.Id AS AppealId,  
    P.LastName + ' ' + P.Name + ' ' + ISNULL(P.Patronymic, '') AS PatientFullName,  
    D.LastName + ' ' + D.Name + ' ' + ISNULL(D.Patronymic, '') AS DoctorFullName,  
    A.Diagnos,  
    A.Date  
FROM Appeal A  
INNER JOIN Patient P ON A.PatientId = P.Id  
INNER JOIN Doctor D ON A.DoctorId = D.Id;

-- Id обращения, Общая сумма (стоимость услуг * количество)  
SELECT  
    A.Id AS AppealId,  
    SUM(ST.Cost * T.Quantity) AS TotalCost  
FROM Appeal A  
INNER JOIN Treatment T ON A.Id = T.AppealId  
INNER JOIN ServiceType ST ON T.ServiceTypeId = ST.Id  
GROUP BY A.Id;  

-- ФИО врача, Специальность, Квалификация  
SELECT  
    D.LastName + ' ' + D.Name AS DoctorName,  
    S.Name AS Specialty,  
    Q.Name AS Qualification  
FROM Doctor D  
INNER JOIN Specialty S ON D.SpecialtyId = S.Id  
INNER JOIN Qualification Q ON D.QualificationId = Q.Id;  

-- Название услуги, Общее количество выполненных раз  
SELECT  
    ST.Name AS Service,  
    SUM(T.Quantity) AS TotalUsage  
FROM Treatment T  
INNER JOIN ServiceType ST ON T.ServiceTypeId = ST.Id  
GROUP BY ST.Name;  

-- ФИО пациента, Количество обращений  
SELECT  
    P.LastName + ' ' + P.Name AS PatientName,  
    COUNT(A.Id) AS TotalAppeals  
FROM Patient P  
LEFT JOIN Appeal A ON P.Id = A.PatientId  
GROUP BY P.LastName, P.Name; 