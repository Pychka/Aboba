CREATE DATABASE Productsdb_Shadiev_Abduvokhidov
GO
USE Productsdb_Shadiev_Abduvokhidov

CREATE TABLE Products
(
	Id INT PRIMARY KEY IDENTITY,
	ProductName NVARCHAR(30) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	ProductCount INT,
	Price MONEY NOT NULL
);
GO
INSERT INTO Products VALUES
	('iPhone 6','Apple', 3, 36000),
	('iPhone 6S','Apple', 2, 41000),
	('iPhone 7','Apple', 5, 52000),
	('Galaxy S8','Samsung', 2, 46000),
	('Galaxy S8 Plus','Samsung', 1, 56000),
	('Mi6','Xiaomi', 5, 28000),
	('OnePlus 5','OnePlus', 6, 38000);

SELECT
	ProductName,
	Price
FROM Products

SELECT
	ProductName + ' (' + Manufacturer + ')',
	Price,
	Price * ProductCount
FROM Products

SELECT
	ProductName + ' (' + Manufacturer + ')' AS ModelName,
	Price,
	Price * ProductCount AS TotalSum
FROM Products

SELECT Manufacturer
FROM Products

SELECT
	ProductName + ' (' + Manufacturer + ')' AS ModelName,
	Price
	INTO ProductSummary
FROM Products

SELECT * FROM ProductSummary

INSERT INTO ProductSummary
SELECT
	ProductName + ' (' + Manufacturer + ')' AS ModelName,
	Price
FROM Products

--������� 2 ���������� �������--

USE lecture_Primer_Shadiev_Abduvokhidov

SELECT * FROM Doughnut_list
SELECT * FROM Drink_Info
SELECT * FROM Jelly_Doughnuts
SELECT * FROM Vasya_list
SELECT * FROM Easy_Drinks

--��� ��� � ��� ��� ������� ��� �� ���-���������, ������ ���7 �� �������7
SELECT * FROM Vasya_list
WHERE last_name = '���7' AND [location] = '�������7'

--��� ��� � ��� ��� �������������, �� ������� �� �� ���������7--
SELECT
	email
	profession
FROM Vasya_list
WHERE profession = '���������7'

SELECT
	last_name,
	first_name,
	birthday
FROM Vasya_list
WHERE birthday = '2007-09-20' OR birthday = '2008-03-17'
--������ :( --

SELECT TOP 1 * FROM Jelly_Doughnuts WHERE Rating = 10

USE lecture_Primer_Shadiev_Abduvokhidov

--� ��� ��� ������� ������� � ������� ������� ������� �� �� ��������3 � ��������5 �������������--
SELECT Drink_Name FROM Easy_Drinks
WHERE Main=',main5'

SELECT Drink_Name FROM Easy_Drinks
WHERE Amount = 5.5

SELECT Drink_Name FROM Easy_Drinks
WHERE [Second] = 'second5'

SELECT Drink_Name FROM Easy_Drinks
WHERE Amount2 = 5.5

SELECT Drink_Name FROM Easy_Drinks
WHERE Directions = 'directions5'

SELECT Drink_Name FROM Easy_Drinks
WHERE Amount = 3.3

SELECT Drink_Name FROM Easy_Drinks
WHERE Amount2 = 3.3

SELECT Drink_Name FROM Easy_Drinks
WHERE Directions = 'directions3'

SELECT Drink_Name FROM Easy_Drinks
WHERE Main = ',main1' AND Amount = 1.1

SELECT Drink_Name FROM Easy_Drinks
WHERE Main = ',main3' AND Amount = 3.3

SELECT Drink_Name FROM Easy_Drinks
WHERE Main = ',main2'

CREATE TABLE Drink_Info
(
	Drink_Name NVARCHAR(50) NOT NULL,
	Cost DECIMAL(8, 2) NOT NULL,
	Carbs DECIMAL(8, 2) NOT NULL,
	Color NVARCHAR(50) NOT NULL,
	Ice NVARCHAR(1) NOT NULL,
	Colories INT NOT NULL
)
GO
INSERT INTO Drink_Info
VALUES
('��������', 3.00, 8.40, 'Ƹ����', '�', 33),
('������� ����', 2.50, 3.20, '�����', '�', 12),
('��� ����', 3.50, 8.60, '���������', '�', 35),
('�������� ����', 2.50, 5.40, '������', '�', 24),
('�������', 5.50, 42.50, '����������', '�', 171),
('������� ������', 3.20, 32.10, '���������', '�', 135),
('�������� ������', 3.60, 4.20, '�������', '�', 17),
('������', 4.00, 14.00, 'Ƹ����', '�', 50),
('����� ����', 2.80, 7.20, '����������', '�', 30),
('�������', 2.60, 21.50, '���������', '�', 80),
('���� ����', 3.80, 4.70, '�������', '�', 19);

SELECT
	Cost
FROM Drink_Info
WHERE Color = 'Ƹ����' AND Colories > 33

SELECT
	Drink_Name,
	Color
FROM Drink_Info
WHERE Carbs < 4 AND Ice = '�'

SELECT
	Cost
FROM Drink_Info
WHERE Color = 'Ƹ����' AND Colories >= 80

SELECT
	Color,
	Ice
FROM Drink_Info
WHERE Drink_Name = '������' OR Drink_Name = '�������'

USE PaidPolyclinic_Shadiev_Abduvohidov_47
SELECT * FROM Appeal
SELECT * FROM Doctor
SELECT * FROM Patient
SELECT * FROM Treatment
--������� ��� ���������, ��� ���� ������ 1000 �����, � ��� �� ������� ����� JOIN--
SELECT
	a.PatientId,
	p.[Name],
	p.LastName,
    a.DoctorId,
    a.TreatmentId,
    a.Diagnos,
    a.Cost,
    a.[Date]
FROM Appeal a
JOIN Patient p ON a.PatientId = p.Id
WHERE Cost > 1000

--������� ���� �������� � ���� � ����� ���� ����� '�'--
SELECT
	[Name],
	LastName
FROM Doctor
WHERE [Name] LIKE '%�%'

--������ ���� ��������� � ���� ���� �������� � 2001 ����--
SELECT
	[Name],
	LastName
FROM Patient
WHERE YEAR(Birthday) = 2001
--������ ���� ��������� � ���� ���� �������� � ��������--
SELECT
	[Name],
	LastName
FROM Patient
WHERE MONTH(Birthday) = 09
--������ ���� ��������� � ���� ���� �������� 11 �����--
SELECT
	[Name],
	LastName
FROM Patient
WHERE DAY(Birthday) = 11

--���� ������ �� ��� �� ������ ��������� ����� ����� ���� ������� Treatment, �� �����. ������� ��� ������ ��� ���� ���� 5000 � ���� 1000 �����--
SELECT
	*
FROM Treatment
WHERE Cost > 1000 AND Cost < 5000