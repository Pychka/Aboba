USE Practic2_Shadiev_Abduvokhidov;

DROP TABLE Customers1
DROP TABLE Customers2

CREATE TABLE Customers1
(
	Id INT PRIMARY KEY,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20),
);
CREATE TABLE Customers2
(
	Id INT,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20),
	PRIMARY KEY(Id)
);

CREATE TABLE OrderLines
(
	OrderId INT,
	ProductId INT,
	Quantity INT,
	Price MONEY,
	PRIMARY KEY(OrderId, ProductId)
);

DROP TABLE Customers1

CREATE TABLE Customers1
(
	Id INT PRIMARY KEY IDENTITY,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20),
);

DROP TABLE Customers1

CREATE TABLE Customers1
(
	Id INT CONSTRAINT PK_Customer_Id PRIMARY KEY IDENTITY,
	Age INT
		CONSTRAINT DF_Customer_Age DEFAULT 18
		CONSTRAINT CK_Customer_Age CHECK(Age > 0 AND Age < 100),
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email VARCHAR(30) CONSTRAINT UQ_Customer_Email UNIQUE,
	Phone VARCHAR(20) CONSTRAINT UQ_Customer_Phone UNIQUE,
);

DROP TABLE Customers1

CREATE TABLE Student
(
	Id INT CONSTRAINT PK_AdditionalTest_Id PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Patronymic NVARCHAR(50),
);
CREATE TABLE Test
(
	Id INT CONSTRAINT PK_Test_Id PRIMARY KEY IDENTITY NOT NULL,
	StudentId INT CONSTRAINT FK_Test_StudentId FOREIGN KEY REFERENCES Student(Id) NOT NULL CONSTRAINT UQ_Test_StudentId UNIQUE,
	Score INT CONSTRAINT CK_Test_Score CHECK (Score >= 0 AND Score <= 5) CONSTRAINT DF_Test_Score DEFAULT 0 NOT NULL
);

USE Productsdb_Shadiev_Abduvokhidov

CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20),
);
GO
ALTER TABLE Customers
ADD [Address] NVARCHAR(50) NULL

ALTER TABLE Customers
DROP COLUMN [Address]

ALTER TABLE Customers
ALTER COLUMN FirstName NVARCHAR(200)

ALTER TABLE Customers
ADD CHECK (Age > 21)

ALTER TABLE Customers WITH NOCHECK
ADD CHECK (Age > 21)

CREATE DATABASE UserDb_Shadiev_Abduvokhidov
GO
USE UserDb_Shadiev_Abduvokhidov

CREATE TABLE Customers1
(
	Id INT PRIMARY KEY IDENTITY,
	Age INT DEFAULT 18,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email VARCHAR(30) UNIQUE,
	Phone VARCHAR(20) UNIQUE
);
CREATE TABLE Orders1
(
	Id INT IDENTITY,
	CustomerId INT,
	CreatedAt Date
);
GO

ALTER TABLE Orders1
ADD FOREIGN KEY(CustomerId) REFERENCES Customers1(Id)

ALTER TABLE Orders1
ADD PRIMARY KEY (Id)

ALTER TABLE Order1
ADD CONSTRAINT PK_Orders1_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Orders1_To_Customers1 FOREIGN KEY(Customers1) REFERENCES Customres1(Id)
GO

ALTER TABLE Customers1
ADD CONSTRAINT CK_Age_Greater_Than_Zero CHECK (Age > 0)

ALTER TABLE Customers1
DROP CK_Age_Greater_Than_Zero

CREATE DATABASE InternetStore_Shadiev_Abduvohidov;
GO
Use InternetStore_Shadiev_Abduvohidov

CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	Age INT DEFAULT 18,
	FirstName VARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email VARCHAR(30) UNIQUE,
	Phone VARCHAR(20) UNIQUE
);

Create TABlE Orders
(
	Id INT PRIMARY KEY IDENTITY,
	CustomerId INT,
	CreatedAt DATE,
	FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
);

USE Productsdb_Shadiev_Abduvokhidov

SELECT *
FROM Products
ORDER BY ProductName

SELECT ProductName, ProductCount * Price AS TotalSum
FROM Products
ORDER BY TotalSum

SELECT ProductName, ProductCount * Price AS TotalSum
FROM Products
ORDER BY TotalSum DESC

SELECT ProductName, Price, Manufacturer
FROM Products
ORDER BY Manufacturer, ProductName

SELECT ProductName, Price, Manufacturer
FROM Products
ORDER BY Manufacturer, ProductName DESC

SELECT ProductName, Price, ProductCount
FROM Products
ORDER BY ProductCount * Price

SELECT TOP 4 ProductName
FROM Products

SELECT TOP 75 PERCENT ProductName
FROM Products

SELECT * FROM Products
ORDER BY Id
	OFFSET 2 ROWS

SELECT * FROM Products
ORDER BY Id
	OFFSET 2 ROWS
	FETCH NEXT 3 ROWS ONLY

USE lecture_Primer_Shadiev_Abduvokhidov

ALTER TABLE Vasya_list
ADD Id INT CONSTRAINT PK_Vasya_list_Id PRIMARY KEY IDENTITY NOT NULL

ALTER TABLE Jelly_Doughnuts
ADD Id INT CONSTRAINT PK_Jelly_Doughnuts_Id PRIMARY KEY IDENTITY NOT NULL

ALTER TABLE Easy_Drinks
ADD Id INT CONSTRAINT PK_Easy_Drinks_Id PRIMARY KEY IDENTITY NOT NULL

ALTER TABLE Drink_Info
ADD Id INT CONSTRAINT PK_Drink_Info_Id PRIMARY KEY IDENTITY NOT NULL

ALTER TABLE Doughnut_list
ADD Id INT CONSTRAINT PK_Doughnut_list_Id PRIMARY KEY IDENTITY NOT NULL

ALTER TABLE Clown_Info
ADD Id INT CONSTRAINT PK_Clown_Info_Id PRIMARY KEY IDENTITY NOT NULL

EXEC sp_rename 'Easy_Drinks.Drink_Name','Name'

EXEC sp_rename 'Doughnut_list.doughnut_name', 'Name'
EXEC sp_rename 'Doughnut_list.doughnut_type', 'Type'

EXEC sp_rename 'Drink_Info.Drink_Name','Name'

EXEC sp_rename 'Vasya_list.last_name', 'LastName'
EXEC sp_rename 'Vasya_list.first_name', 'FirstName'
EXEC sp_rename 'Vasya_list.email', 'Email'
EXEC sp_rename 'Vasya_list.birthday', 'Birthday'
EXEC sp_rename 'Vasya_list.profession', 'Profession'
EXEC sp_rename 'Vasya_list.location', 'Location'
EXEC sp_rename 'Vasya_list.status', 'Status'
EXEC sp_rename 'Vasya_list.interests', 'Interests'
EXEC sp_rename 'Vasya_list.seeking', 'Seeking'

USE lecture_Primer_Shadiev_Abduvokhidov
CREATE TABLE Fish_Info
(
	Common NVARCHAR(100) NOT NULL,
	Species VARCHAR(100) NOT NULL,
	[Location] NVARCHAR(100) NOT NULL,
	[Weight] NVARCHAR(100) NOT NULL,
)

CREATE TABLE Fish_Records
(
	First_Name NVARCHAR(100) NOT NULL,
	Last_Name NVARCHAR(100) NOT NULL,
	Common NVARCHAR(100) NOT NULL,
	[Location] NVARCHAR(100) NOT NULL,
	[State] VARCHAR(2) NOT NULL,
	[Weight] NVARCHAR(100) NOT NULL,
	[Date] DATETIME NOT NULL,
)
GO
INSERT INTO Fish_Info
VALUES
('����������� �����','M. salmoides','����������� ����, GA','22 �� 4 ���'),
('�����','S. vitreus','��� ������ ����, TN','25 �� 0 ���'),
('������ ������','O. Clarki','������� ����, NV','41 �� 0 ���'),
('����� �����','P. Flavescens','�����������, NJ','4 �� 3 ���'),
('������������','L. Macrochirus','������ ����, AL','4 �� 12 ���'),
('���������','L. Osseus','������� �����, TX','50 �� 5 ���'),
('����� ������','P. annularis','����� ����, MS','5 �� 3 ���'),
('����������� ����','E. americanus','������ ����, IN','1 �� 0 ���'),
('����������� ������','C. auratus','���� ������, CA','6 �� 10 ���'),
('������','O. Tshawytscha','����� �����, AK','97 �� 4 ���')

INSERT INTO Fish_Records
VALUES
('������','�����','����������� �����','����������� ����','GA','22 �� 4 ���','2/6/1932'),
('�����','������','�����','��� ������ ����','TN','25 �� 0 ���','2/8/1960'),
('����','�����������','������ ������','������� ����','NV','41 �� 0 ���','1/12/1925'),
('�.�.','�����','����� �����','�����������','NJ','4 �� 3 ���','1/5/1865'),
('�.�.','������','������������','������ ����','AL','4 �� 12 ���','9/4/1950'),
('��������','������','���������','������� �����','TX','50 �� 5 ���','30/7/1954'),
('����','�����','����� ������','����� ����','MS','5 �� 3 ���','31/7/1957'),
('����','����','����������� ����','������ ����','IN','1 �� 0 ���','9/6/1990'),
('����������','�����','����������� ������','���� ������','CA','6 �� 10 ���','17/4/1996'),
('���','��������','������','����� �����','AK','97 �� 4 ���','17/5/1985')
GO

ALTER TABLE Fish_Info
ADD City NVARCHAR(100) NOT NULL DEFAULT '',
	[State] NVARCHAR(100) NOT NULL DEFAULT ''

USE lecture_Primer_Shadiev_Abduvokhidov

UPDATE Fish_Info
SET City = CASE
			WHEN [Location] = '����������� ����, GA' THEN '����������� ����'
			WHEN [Location] = '��� ������ ����, TN' THEN '��� ������ ����'
			WHEN [Location] = '������� ����, NV' THEN '������� ����'
			WHEN [Location] = '�����������, NJ' THEN '�����������'
			WHEN [Location] = '������ ����, AL' THEN '������ ����'
			WHEN [Location] = '������� �����, TX' THEN '������� �����'
			WHEN [Location] = '����� ����, MS' THEN '����� ����'
			WHEN [Location] = '������ ����, IN' THEN '������ ����'
			WHEN [Location] = '���� ������, CA' THEN '���� ������'
			WHEN [Location] = '���� ������, CA' THEN '���� ������'
			WHEN [Location] = '����� �����, AK' THEN '����� �����'
		END,
	[State] = CASE
				WHEN [Location] = '����������� ����, GA' THEN 'GA'
				WHEN [Location] = '��� ������ ����, TN' THEN 'TN'
				WHEN [Location] = '������� ����, NV' THEN 'NV'
				WHEN [Location] = '�����������, NJ' THEN 'NJ'
				WHEN [Location] = '������ ����, AL' THEN 'AL'
				WHEN [Location] = '������� �����, TX' THEN 'TX'
				WHEN [Location] = '����� ����, MS' THEN 'MS'
				WHEN [Location] = '������ ����, IN' THEN 'IN'
				WHEN [Location] = '���� ������, CA' THEN 'CA'
				WHEN [Location] = '���� ������, CA' THEN 'CA'
				WHEN [Location] = '����� �����, AK' THEN 'AK'
			END
ALTER TABLE Fish_Info
DROP COLUMN [Location]

INSERT INTO Clown_Info
VALUES
('������','������� �����','�, ������-���������� ������, ������� ���',NULL),
('������','������� ���','�, ������-���������� ������, ������� ���',NULL)
GO

DECLARE @name NVARCHAR(50) = '������'

DELETE FROM Clown_Info
WHERE [Name] = @name AND Id IN
(
	SELECT Id 
	FROM Clown_Info
	WHERE [Name] = @name
	ORDER BY Id DESC
	OFFSET 1 ROWS
)

USE PaidPolyclinic_Shadiev_Abduvohidov_47
--����������� �� � ����� � ��� ��� ���� ��� ��� ��� �� ��������� :D--
--������� ������� ���������: ��� ��� � ��� 4 �������, �� ������ ��� ������ ����� ������/������/�������/��������� 25%,--
DECLARE @count INT
--������ 25%
SELECT @count = COUNT(*) FROM Appeal

DELETE FROM Appeal
WHERE Id IN
(
	SELECT Id 
	FROM Appeal
	ORDER BY Id
	OFFSET 0 ROWS
	FETCH FIRST @count/4 ROWS ONLY
)
--������ 25%
SELECT @count = COUNT(*) FROM Doctor

DELETE FROM Doctor
WHERE Id IN
(
	SELECT Id 
	FROM Doctor
	ORDER BY Id
	OFFSET @count/4 ROWS
	FETCH NEXT @count/4 ROWS ONLY
)
--������ 25%
SELECT @count = COUNT(*) FROM Patient

DELETE FROM Patient
WHERE Id IN
(
	SELECT Id 
	FROM Patient
	ORDER BY Id
	OFFSET @count/2 ROWS
	FETCH NEXT @count/4 ROWS ONLY
)
--��������� 25%
SELECT @count = COUNT(*) FROM Treatment

DELETE FROM Treatment
WHERE Id IN
(
	SELECT Id 
	FROM Treatment
	ORDER BY Id
	OFFSET @count - @count/4 ROWS
	FETCH NEXT @count/4 ROWS ONLY
)
--������ ������ ������ ������ �� ������� ���� ��� �� �� ��������� ��������� �������� � ������� Appeal :D--