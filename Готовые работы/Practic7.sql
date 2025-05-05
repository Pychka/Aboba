CREATE DATABASE DataBasePrimer_Shadiev_Abduvokhidov
GO
USE DataBasePrimer_Shadiev_Abduvokhidov

CREATE TABLE Products
(
	Id INT IDENTITY PRIMARY KEY,
	ProductName NVARCHAR(30) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	ProductCount INT DEFAULT 0,
	Price MONEY NOT NULL
)
GO

INSERT INTO Products
VALUES
('iPhone 6','Apple', 3, 36000),
('iPhone 6S','Apple', 2, 41000),
('iPhone 7','Apple', 5, 52000),
('Galaxy S8','Samsung', 2, 46000),
('Galaxy S8 Plus','Samsung', 1, 56000),
('Mi6','Xiaomi', 5, 28000),
('OnePlus 5','OnePlus', 6, 38000)
GO

SELECT AVG(Price)
AS Average_Price
FROM Products

SELECT AVG(Price)
AS Average_Price
FROM Products
WHERE Manufacturer='Apple'

SELECT AVG(Price * ProductCount)
AS Average_Price
FROM Products

SELECT COUNT(*) FROM Products

SELECT COUNT(Manufacturer) FROM Products

SELECT MIN(Price)
FROM Products

SELECT MAX(Price)
FROM Products

SELECT SUM(ProductCount)
FROM Products

SELECT SUM(Price * ProductCount)
FROM Products

SELECT COUNT(*) AS ProdCount,
		SUM(ProductCount) AS TotalCount,
		MIN(Price) AS MinPrice,
		MAX(Price) AS MaxPrice,
		AVG(Price) AS AvgPrice
FROM Products

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
GROUP BY Manufacturer

SELECT Manufacturer, ProductCount, COUNT(*) AS ModelsCount
FROM Products
GROUP BY Manufacturer, ProductCount

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
WHERE Price > 30000
GROUP BY Manufacturer
ORDER BY ModelsCount DESC

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
GROUP BY Manufacturer
HAVING COUNT(*) > 1

SELECT Manufacturer, COUNT(*) AS ModelsCount
FROM Products
WHERE Price * ProductCount > 80000
GROUP BY Manufacturer
HAVING COUNT(*) > 1

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
WHERE Price * ProductCount > 80000
GROUP BY Manufacturer
HAVING SUM(ProductCount) > 2
ORDER BY Units DESC

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY Manufacturer WITH ROLLUP

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY ROLLUP(Manufacturer)

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY Manufacturer, ProductCount WITH ROLLUP

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY ROLLUP(Manufacturer)

SELECT Manufacturer, COUNT(*) AS Models, SUM(ProductCount) AS Units
FROM Products
GROUP BY Manufacturer, ProductCount WITH CUBE

SELECT Manufacturer, COUNT(*) AS Models, ProductCount
FROM Products
GROUP BY GROUPING SETS(Manufacturer, ProductCount)

SELECT Manufacturer, COUNT(*) AS Models,
	ProductCount, SUM(ProductCount) AS Units
FROM Products
GROUP BY GROUPING SETS(ROLLUP(Manufacturer), ProductCount)

SELECT Manufacturer, COUNT(*) AS Models,
	ProductCount, SUM(ProductCount) AS Units
FROM Products
GROUP BY GROUPING SETS((Manufacturer, ProductCount), ProductCount)

SELECT ProductName, Manufacturer, ProductCount,
	COUNT(*) OVER (PARTITION BY Manufacturer) AS Models,
	SUM(ProductCount) OVER (PARTITION BY Manufacturer) AS Units
FROM Products

CREATE TABLE Cookie_Sales
(
	Id INT PRIMARY KEY IDENTITY,
	First_Name NVARCHAR(100),
	Sales Decimal(8,5),
	Sale_Date DATE
);
GO
INSERT INTO Cookie_Sales(First_Name, Sales, Sale_Date)
VALUES
('������', 32.02, '06-03-2007'),
('�����', 26.53, '06-03-2007'),
('������', 11.25, '06-03-2007'),
('������', 18.96, '06-03-2007'),
('������', 9.16, '07-03-2007'),
('�����', 1.52, '07-03-2007'),
('������', 43.21, '07-03-2007'),
('������', 8.05, '07-03-2007'),
('������', 17.62, '08-03-2007'),
( '�����', 24.19, '08-03-2007'),
( '������', 3.40, '08-03-2007'),
( '������', 15.21, '08-03-2007'),
( '������', 0.00, '09-03-2007'),
( '�����', 31.99, '09-03-2007'),
( '������', 2.58, '09-03-2007'),
( '������', 0.00, '09-03-2007'),
( '������', 2.34, '10-03-2007'),
( '�����', 13.44, '10-03-2007'),
( '������', 8.78, '10-03-2007'),
( '������', 26.82, '10-03-2007'),
( '������', 3.71, '11-03-2007'),
( '�����', 0.56, '11-03-2007'),
( '������', 34.19, '11-03-2007'),
( '������', 7.77, '11-03-2007'),
( '������', 16.23, '12-03-2007'),
( '�����', 0.00, '12-03-2007'),
( '������', 4.50, '12-03-2007'),
( '������', 19.22, '12-03-2007');
GO

SELECT
	first_name AS Girl,
	SUM(sales) AS Sales
FROM Cookie_Sales
GROUP BY first_name
ORDER BY Sales DESC;

SELECT
	first_name AS Girl,
	SUM(Sales) /
	COUNT(Sale_Date) AS sales
FROM Cookie_Sales
GROUP BY first_name
ORDER BY Sales DESC;

SELECT
	first_name AS Girl,
	MAX(Sales) AS Maximum,
	MIN(Sales) AS Minimum
FROM Cookie_Sales
GROUP BY first_name;

SELECT
	first_name AS Girl,
	COUNT(DISTINCT Sale_Date) AS sales_days
FROM Cookie_Sales
WHERE sales > 0
GROUP BY first_name
ORDER BY sales_days DESC;

USE PaidPolyclinic_Shadiev_Abduvohidov_47
--����� ������� �� ���� �����
SELECT
	SUM(a.Cost) AS cost
FROM Appeal a
ORDER BY cost;
--����� ������� � ������� ���������� �� �����������
SELECT
	p.LastName AS �������,
	p.[Name] AS ���,
	p.Patronymic AS �������,
	SUM(a.Cost) AS cost
FROM Appeal a
JOIN Patient p ON a.PatientId = p.Id
GROUP BY  p.LastName, p.[Name], p.Patronymic
ORDER BY cost;
--������� ����� ����������� ����������
SELECT
	p.LastName AS �������,
	p.[Name] AS ���,
	p.Patronymic AS �������,
	SUM(a.Cost) / COUNT(a.Cost) AS cost
FROM Appeal a
JOIN Patient p ON a.PatientId = p.Id
GROUP BY  p.LastName, p.[Name], p.Patronymic
ORDER BY cost;
