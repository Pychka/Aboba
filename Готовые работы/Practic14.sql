CREATE DATABASE Practic14_Shadiev_Abduvokhidov
GO

USE Practic14_Shadiev_Abduvokhidov

CREATE TABLE Clients
(
	Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Phone NVARCHAR(20) NULL,
	Email NVARCHAR(20) NULL,
);
GO

INSERT INTO Clients(FirstName, LastName, Phone, Email)
VALUES
('Tom','Smith','+36436734',NULL),
('Bob','Simpson',NULL,NULL);
GO

SELECT FirstName, LastName,
	ISNULL(Phone, 'не определено') AS Phone,
	ISNULL(Email, 'неизвестно') AS Email
FROM Clients

SELECT FirstName, LastName,
	COALESCE(Phone, 'не определено') AS Contacts
FROM Clients

USE Vasya_list_Shadiev_Abduvokhidov

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL([Date], '11/11/1111') AS [Date]
FROM Birthday

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, 'Неизвестно') AS Title
FROM Interests

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, 'Неизвестно') AS Title
FROM [Location]

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, 'Неизвестно') AS Title
FROM Seeking

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, 'Неизвестно') AS Title
FROM [Status]

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, 'Неизвестно') AS Title,
	ISNULL(MinSalary, -1) AS MinSalary,
	ISNULL(MaxSalary, -1) AS MaxSalary
FROM Proffesion

SELECT 
	ISNULL(VasyaListId, -1) AS VasyaListId,
	ISNULL(ProffesionId, -1) AS ProffesionId,
	ISNULL(Amount, 0) AS Amount,
	ISNULL(IsWork, 0) AS IsWork,
	ISNULL(WorkExperience, 0) AS WorkExperience,
	ISNULL(WorkStartDate, '11/11/1111') AS WorkStartDate,
	ISNULL(Awards, 'Отсутствуют') AS Awards
FROM Salaries ORDER BY WorkStartDate DESC

SELECT
	ISNULL(VasyaListId, -1) AS VasyaListId,
	ISNULL(InterestsId, -1) AS InterestsId
FROM VasyaListInterests

SELECT
	ISNULL(VasyaListId, -1) AS VasyaListId,
	ISNULL(SeekingId, -1) AS SeekingId
FROM VasyaListSeeking

SELECT * FROM VasyaList

SELECT 
	ISNULL(vs.Id, -1) AS Id,
	ISNULL(LastName, 'Неизвестно') AS LastName,
	ISNULL(FirstName, 'Неизвестно') AS FirstName,
	ISNULL(Email, 'Неизвестно') AS Email,
	ISNULL(s.Title, 'Неизвестно') AS StatusId,
	ISNULL(b.[Date], '11/11/1111') AS BirthdayId,
	ISNULL(vs.Phone, 'Неизвестно') AS BirthdayId,
	ISNULL(l.Title, -11) AS LocationId,
	ISNULL(Age, -11) AS Age
FROM VasyaList AS vs
JOIN Birthday b ON b.Id = BirthdayId
JOIN [Status] s ON s.Id = StatusId
JOIN [Location] l ON l.Id = LocationId

SELECT FirstName, LastName,
	COALESCE(Phone, Email, 'необходимо уточнить') AS Contacts
FROM VasyaList

SELECT FirstName, LastName,
	COALESCE(Phone, Email, 'необходимо уточнить') AS Contacts
FROM VasyaList

ALTER TABLE VasyaList
ADD Gender NVARCHAR(10)

UPDATE VasyaList SET Gender = 'Ж' WHERE LOWER(FirstName) = 'фамилия1'
UPDATE VasyaList SET Gender = 'М' WHERE LOWER(FirstName) = 'фамилия3'

SELECT Id, FirstName, LastName,
	ISNULL(Gender, 'М') AS Gender
FROM VasyaList WHERE Gender IS NULL

--Проверка
SELECT Id, FirstName, LastName,
	ISNULL(Gender, 'Неизвестно') AS Gender
FROM VasyaList ORDER BY Gender

--ЗП нельзя заменить на 'договорная', так как поле ЗП является типом данных MONEY
SELECT 
	ISNULL(Amount, -100) AS AMOUNT
FROM Salaries

USE PaidPolyclinic_Shadiev_Abduvohidov_47

-- Вывод ФИО пациентов с заменой NULL в отчестве
SELECT 
    LastName AS Фамилия,
    [Name] AS Имя,
    ISNULL(Patronymic, 'Не указано') AS Отчество
FROM Patient;

-- Вывод возраста пациентов
SELECT 
    LastName AS Фамилия,
    [Name] AS Имя,
    DATEDIFF(YEAR, Birthday, GETDATE()) AS Возраст
FROM Patient;

-- Расчет общей стоимости лечения
SELECT 
    p.LastName AS Фамилия,
    p.[Name] AS Имя,
    SUM(st.Cost * t.Quantity) AS [Общая стоимость]
FROM Patient p
JOIN Appeal a ON p.Id = a.PatientId
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY p.LastName, p.[Name];

-- Вывод обращений с датой в формате "день-месяц-год"
SELECT 
    Id AS [Номер обращения],
    FORMAT([Date], 'dd-MM-yyyy') AS [Дата],
    Diagnos AS Диагноз
FROM Appeal;

-- Топ врачей по количеству обращений
SELECT 
    d.LastName AS Фамилия,
    d.[Name] AS Имя,
    COUNT(a.Id) AS [Количество обращений]
FROM Doctor d
JOIN Appeal a ON d.Id = a.DoctorId
GROUP BY d.LastName, d.[Name]
ORDER BY [Количество обращений] DESC;

ALTER TABLE Patient
ADD Phone NVARCHAR(20) NULL,
    Email NVARCHAR(50) NULL;
GO

UPDATE Patient SET Phone = '+79001234567' WHERE Id = 1;
UPDATE Patient SET Email = 'ivan@mail.com' WHERE Id = 1;
GO

-- Вывод контактов с использованием COALESCE
SELECT 
    LastName AS Фамилия,
    [Name] AS Имя,
    COALESCE(Phone, Email, 'Не указано') AS Контакт
FROM Patient;

