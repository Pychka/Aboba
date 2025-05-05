DECLARE @name NVARCHAR(20), @age INT;
SET @name = 'Tom';
SET @age = 18;
PRINT 'Name: ' + @name;
PRINT 'Age: ' + CONVERT(CHAR, @age);

SELECT @name, @age;

CREATE DATABASE New_Shadiev_Abduvokhidov;
GO

USE New_Shadiev_Abduvokhidov

CREATE TABLE Products
(
	Id INT IDENTITY PRIMARY KEY,
	ProductName NVARCHAR(30) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	ProductCount INT DEFAULT 0,
	Price MONEY NOT NULL
);
CREATE TABLE Customers
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
	Id INT IDENTITY PRIMARY KEY,
	ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE
	CASCADE,
	CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE
	CASCADE,
	CreatedAt DATE NOT NULL,
	ProductCount INT DEFAULT 1,
	Price MONEY NOT NULL
);

DECLARE @maxPrice MONEY,
	@minPrice MONEY,
	@dif MONEY,
	@count INT;

SET @count = ISNULL((SELECT SUM(ProductCount) FROM Orders), 0);

SELECT @minPrice = ISNULL(MIN(Price), 0), @maxPrice = ISNULL(MAX(Price), 0) FROM Products

SET @dif = @maxPrice - @minPrice;

PRINT '����� �������: ' + STR(@count, 5) + ' ������(��)';
PRINT '������� ����� ������������ � ����������� �����: ' + STR(@dif);

USE Productsdb_Shadiev_Abduvokhidov;

DECLARE @sum MONEY, @id INT, @prodid INT, @name NVARCHAR(20);

SET @id=2;

SELECT @sum = SUM(Orders.Price * Orders.ProductCount),

@name=Products.ProductName, @prodid=Products.Id

FROM Orders

INNER JOIN Products ON ProductId=Products.Id

GROUP BY Products.ProductName, Products. Id

HAVING Products.Id=@id

PRINT '����� ' + @name + ' g����� �� �����' + STR(@sum)

USE Vasya_list_Shadiev_Abduvokhidov

DECLARE
	@post NVARCHAR(50) = '���-�����������',
	@location NVARCHAR(50) = '�������1',
	@phone VARCHAR(20) = '8800555353',
	@birhdayDate DATE = '11/09/2001',
	@result1 MONEY,
	@result2 MONEY,
	@result3 NVARCHAR(20);

SELECT @result1 = AVG(s.Amount) FROM VasyaList AS vl
JOIN Salaries s ON s.VasyaListId = vl.Id
JOIN Proffesion p ON p.Id = s.ProffesionId
WHERE p.Title = @post

PRINT '������� �������� � ' + @post + ' ����� ' + CONVERT(NVARCHAR, @result1)

SELECT @result2 = AVG(s.Amount) FROM VasyaList AS vl
JOIN Salaries s ON s.VasyaListId = vl.Id
JOIN [Location] l ON l.Id = vl.LocationId
WHERE l.Title = @location

PRINT '������� �������� � ' + @location + ' ����� ' + CONVERT(NVARCHAR, @result2)

UPDATE VasyaList SET Phone = @phone WHERE Id = 1

SELECT TOP 1 @result3 = l.Title FROM VasyaList AS vl
JOIN [Location] l ON l.Id = vl.LocationId
WHERE vl.Phone = @phone

PRINT @result3 + ' - ����� �������� � ������� �������� ' + @phone

SELECT FirstName, LastName, b.[Date] FROM VasyaList AS vl
JOIN Birthday b ON b.Id = vl.BirthdayId
WHERE b.[Date] = @birhdayDate

USE PaidPolyclinic_Shadiev_Abduvohidov_47

-- ����� �������� �� ������� ����� ����������
DECLARE @searchLastName NVARCHAR(50) = '�������';

SELECT 
    Id AS [ID ��������],
    LastName AS �������,
    [Name] AS ���,
    Birthday AS [���� ��������]
FROM Patient
WHERE LastName = @searchLastName;

--������ ����� ��������� ������� ��� ����������� ��������
DECLARE @patientId INT = 1, @totalCost MONEY, @FirstSecondName NVARCHAR(50);
SELECT TOP 1 @FirstSecondName = LastName+' '+[Name] FROM Patient

SELECT @totalCost = SUM(st.Cost * t.Quantity)
FROM Treatment t
JOIN ServiceType st ON t.ServiceTypeId = st.Id
WHERE t.AppealId IN (SELECT Id FROM Appeal WHERE PatientId = @patientId);

PRINT '����� ��������� ������� ��� �������� ' + @FirstSecondName + ': ' + CAST(@totalCost AS NVARCHAR) + ' ���.';

--����������� ����� � ���������� ����������� ���������
DECLARE @maxAppeals INT;
DECLARE @doctorName NVARCHAR(100);

SELECT TOP 1 
    @doctorName = d.LastName + ' ' + d.[Name],
    @maxAppeals = COUNT(a.Id)
FROM Doctor d
JOIN Appeal a ON d.Id = a.DoctorId
GROUP BY d.LastName, d.[Name]
ORDER BY COUNT(a.Id) DESC;

PRINT '���� � ���������� ����������� ���������: ' + @doctorName + ' (' + CAST(@maxAppeals AS NVARCHAR) + ' ���������)';

--�������� ������� ����� ������ ����������� �����
DECLARE @threshold MONEY = 2500.00;

IF EXISTS(SELECT * FROM ServiceType WHERE Cost > @threshold)
    PRINT '���� ������ ������ ' + CAST(@threshold AS NVARCHAR) + ' ���.';
ELSE
    PRINT '����� ������ ' + CAST(@threshold AS NVARCHAR) + ' ���. ���.';