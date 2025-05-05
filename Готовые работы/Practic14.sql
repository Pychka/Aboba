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
	ISNULL(Phone, '�� ����������') AS Phone,
	ISNULL(Email, '����������') AS Email
FROM Clients

SELECT FirstName, LastName,
	COALESCE(Phone, '�� ����������') AS Contacts
FROM Clients

USE Vasya_list_Shadiev_Abduvokhidov

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL([Date], '11/11/1111') AS [Date]
FROM Birthday

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, '����������') AS Title
FROM Interests

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, '����������') AS Title
FROM [Location]

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, '����������') AS Title
FROM Seeking

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, '����������') AS Title
FROM [Status]

SELECT
	ISNULL(Id, -1) AS Id,
	ISNULL(Title, '����������') AS Title,
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
	ISNULL(Awards, '�����������') AS Awards
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
	ISNULL(LastName, '����������') AS LastName,
	ISNULL(FirstName, '����������') AS FirstName,
	ISNULL(Email, '����������') AS Email,
	ISNULL(s.Title, '����������') AS StatusId,
	ISNULL(b.[Date], '11/11/1111') AS BirthdayId,
	ISNULL(vs.Phone, '����������') AS BirthdayId,
	ISNULL(l.Title, -11) AS LocationId,
	ISNULL(Age, -11) AS Age
FROM VasyaList AS vs
JOIN Birthday b ON b.Id = BirthdayId
JOIN [Status] s ON s.Id = StatusId
JOIN [Location] l ON l.Id = LocationId

SELECT FirstName, LastName,
	COALESCE(Phone, Email, '���������� ��������') AS Contacts
FROM VasyaList

SELECT FirstName, LastName,
	COALESCE(Phone, Email, '���������� ��������') AS Contacts
FROM VasyaList

ALTER TABLE VasyaList
ADD Gender NVARCHAR(10)

UPDATE VasyaList SET Gender = '�' WHERE LOWER(FirstName) = '�������1'
UPDATE VasyaList SET Gender = '�' WHERE LOWER(FirstName) = '�������3'

SELECT Id, FirstName, LastName,
	ISNULL(Gender, '�') AS Gender
FROM VasyaList WHERE Gender IS NULL

--��������
SELECT Id, FirstName, LastName,
	ISNULL(Gender, '����������') AS Gender
FROM VasyaList ORDER BY Gender

--�� ������ �������� �� '����������', ��� ��� ���� �� �������� ����� ������ MONEY
SELECT 
	ISNULL(Amount, -100) AS AMOUNT
FROM Salaries

USE PaidPolyclinic_Shadiev_Abduvohidov_47

-- ����� ��� ��������� � ������� NULL � ��������
SELECT 
    LastName AS �������,
    [Name] AS ���,
    ISNULL(Patronymic, '�� �������') AS ��������
FROM Patient;

-- ����� �������� ���������
SELECT 
    LastName AS �������,
    [Name] AS ���,
    DATEDIFF(YEAR, Birthday, GETDATE()) AS �������
FROM Patient;

-- ������ ����� ��������� �������
SELECT 
    p.LastName AS �������,
    p.[Name] AS ���,
    SUM(st.Cost * t.Quantity) AS [����� ���������]
FROM Patient p
JOIN Appeal a ON p.Id = a.PatientId
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY p.LastName, p.[Name];

-- ����� ��������� � ����� � ������� "����-�����-���"
SELECT 
    Id AS [����� ���������],
    FORMAT([Date], 'dd-MM-yyyy') AS [����],
    Diagnos AS �������
FROM Appeal;

-- ��� ������ �� ���������� ���������
SELECT 
    d.LastName AS �������,
    d.[Name] AS ���,
    COUNT(a.Id) AS [���������� ���������]
FROM Doctor d
JOIN Appeal a ON d.Id = a.DoctorId
GROUP BY d.LastName, d.[Name]
ORDER BY [���������� ���������] DESC;

ALTER TABLE Patient
ADD Phone NVARCHAR(20) NULL,
    Email NVARCHAR(50) NULL;
GO

UPDATE Patient SET Phone = '+79001234567' WHERE Id = 1;
UPDATE Patient SET Email = 'ivan@mail.com' WHERE Id = 1;
GO

-- ����� ��������� � �������������� COALESCE
SELECT 
    LastName AS �������,
    [Name] AS ���,
    COALESCE(Phone, Email, '�� �������') AS �������
FROM Patient;

