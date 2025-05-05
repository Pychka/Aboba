USE New_Shadiev_Abduvokhidov
GO

CREATE VIEW OrdersProductsCustomers AS
SELECT Orders.CreatedAt AS OrderDate,
	Customers.FirstName AS Customer,
	Products.ProductName AS [Product]
FROM Orders
INNER JOIN Products ON Orders.ProductId = Products.Id
INNER JOIN Customers ON Orders.CustomerId = Customers.Id
GO

SELECT * FROM OrdersProductsCustomers
GO

CREATE VIEW OrdersProductsCustomers2 (OrderDate, Customer, Product)
AS SELECT Orders.CreatedAt,
		Customers.FirstName,
		Products.ProductName
FROM Orders INNER JOIN Products ON Orders.ProductId = Products.Id
INNER JOIN Customers ON Orders.CustomerId = Customers.Id
GO

ALTER VIEW OrdersProductsCustomers
AS SELECT Orders.CreatedAt AS OrderDate,
		Customers.FirstName AS Customer,
		Products.ProductName AS [Product],
		Products.Manufacturer AS Manufacturer
FROM Orders INNER JOIN Products ON Orders.ProductId = Products.Id
INNER JOIN Customers ON Orders.CustomerId = Customers.Id
GO

CREATE VIEW ProductView 
AS 
    SELECT ProductName AS Product, Manufacturer, Price 
    FROM Products;
GO

INSERT INTO ProductView (Product, Manufacturer, Price) 
VALUES ('Nokia 8', 'HDC Global', 18000);
GO

UPDATE ProductView 
SET Price = 15000 
WHERE Product = 'Nokia 8';

DELETE FROM ProductView 
WHERE Product = 'Nokia 8';
GO

CREATE VIEW ProductsWithCountMoreThanTwo 
AS 
    SELECT * 
    FROM Products 
    WHERE ProductCount > 2;
GO

INSERT INTO ProductView (Product, Manufacturer, Price) 
VALUES 
    ('Xiaomi Redmi Note 10', 'Xiaomi', 20000),
    ('Samsung A52', 'Samsung', 25000),
    ('iPhone 12', 'Apple', 70000);
GO

DECLARE @ProductPrice TABLE (
    ProductName NVARCHAR(30),
    Price MONEY
);

INSERT INTO @ProductPrice (ProductName, Price)
VALUES 
    ('iPhone 12', 70000),
    ('Galaxy S21', 80000);
GO

CREATE TABLE #ClientSummary (
    ClientId INT,
    TotalOrders INT
);
GO

INSERT INTO #ClientSummary
SELECT 
    CustomerId, 
    COUNT(Id) AS TotalOrders 
FROM Orders 
GROUP BY CustomerId;
GO

CREATE TABLE ##GlobalOrderDetails (
    ProductId INT,
    TotalSales MONEY
);
GO

INSERT INTO ##GlobalOrderDetails
SELECT 
    ProductId, 
    SUM(ProductCount * Price) 
FROM Orders 
GROUP BY ProductId;

USE Vasya_list_Shadiev_Abduvokhidov;
GO

CREATE VIEW WebAndWriter
AS SELECT
	vl.Id AS VasyaListId,
	vl.FirstName,
	vl.LastName,
	vl.Email,
	vl.Phone,
	vl.Age,
	b.[Date],
	vl.Gender,
	p.Title,
	s.Amount,
	s.WorkExperience,
	s.Awards,
	s.WorkStartDate
FROM VasyaList AS vl
JOIN Salaries s ON s.VasyaListId = vl.Id
JOIN Proffesion p ON p.Id = s.ProffesionId
JOIN Birthday b ON b.Id = vl.BirthdayId
WHERE p.Title IN ('Веб-дизайнер','Технический писатель')
GO

ALTER TABLE Salaries
ADD NewSalary MONEY
GO
UPDATE Salaries SET NewSalary = Salaries.Amount + 1000 WHERE Salaries.Amount < 10000
UPDATE Salaries SET NewSalary = Salaries.Amount + 2000 WHERE Salaries.Amount > 10000 AND Salaries.Amount < 20000
UPDATE Salaries SET NewSalary = Salaries.Amount + 4000 WHERE Salaries.Amount > 20000
GO

CREATE VIEW DiffChangeWork
AS SELECT
	vl.FirstName,
	vl.LastName,
	vl.Age,
	vl.Gender,
	p.Title,
	s.Amount,
	s.NewSalary,
	diff = s.NewSalary - s.Amount,
	s.WorkExperience,
	s.Awards,
	s.WorkStartDate
FROM VasyaList AS vl
JOIN Salaries s ON s.VasyaListId = vl.Id
JOIN Proffesion p ON p.Id = s.ProffesionId
JOIN Birthday b ON b.Id = vl.BirthdayId
GO

USE PaidPolyclinic_Shadiev_Abduvohidov_47
GO
--Отобразит стоимость каждого обращения.
CREATE VIEW TreatmentCostPerAppeal AS
SELECT 
    A.Id AS AppealId,
    P.LastName + ' ' + P.Name AS PatientName,
    D.LastName + ' ' + D.Name AS DoctorName,
    SUM(T.Quantity * ST.Cost) AS TotalCost
FROM Appeal A
JOIN Patient P ON A.PatientId = P.Id
JOIN Doctor D ON A.DoctorId = D.Id
JOIN Treatment T ON A.Id = T.AppealId
JOIN ServiceType ST ON T.ServiceTypeId = ST.Id
GROUP BY A.Id, P.LastName, P.Name, D.LastName, D.Name;
GO
-- Ожидаемый результат: Список обращений с ФИО пациента, врача и общей стоимостью лечения.

-- Покажет врачей с их специализацией.
CREATE VIEW DoctorsWithSpecialty AS
SELECT 
    D.Id,
    D.LastName + ' ' + D.Name AS DoctorName,
    S.Name AS Specialty,
    Q.Name AS Qualification
FROM Doctor D
JOIN Specialty S ON D.SpecialtyId = S.Id
JOIN Qualification Q ON D.QualificationId = Q.Id;
GO
-- Ожидаемый результат: Таблица врачей с указанием их специализации и квалификации.

-- Выведет статистику по услугам за октябрь.
CREATE VIEW ServiceTypeStats AS
SELECT 
    ST.Name AS ServiceType,
    SUM(T.Quantity) AS TotalQuantity,
    SUM(T.Quantity * ST.Cost) AS TotalRevenue
FROM Treatment T
JOIN ServiceType ST ON T.ServiceTypeId = ST.Id
JOIN Appeal A ON T.AppealId = A.Id
WHERE A.Date BETWEEN '2023-10-01' AND '2023-10-31'
GROUP BY ST.Name;
GO
-- Ожидаемый результат: Статистика по количеству и доходу от каждой услуги за октябрь.

-- Отобразит доходы по месяцам.
CREATE VIEW MonthlyRevenue AS
SELECT 
    FORMAT(A.Date, 'yyyy-MM') AS Month,
    SUM(T.Quantity * ST.Cost) AS TotalRevenue
FROM Appeal A
JOIN Treatment T ON A.Id = T.AppealId
JOIN ServiceType ST ON T.ServiceTypeId = ST.Id
GROUP BY FORMAT(A.Date, 'yyyy-MM');
GO
-- Ожидаемый результат: Доход поликлиники по месяцам.

-- Определит самых активных пациентов.
CREATE VIEW TopPatientsByAppeals AS
SELECT TOP 3
    P.Id,
    P.LastName + ' ' + P.Name AS PatientName,
    COUNT(A.Id) AS TotalAppeals
FROM Patient P
JOIN Appeal A ON P.Id = A.PatientId
GROUP BY P.Id, P.LastName, P.Name
ORDER BY TotalAppeals DESC;
GO
-- Ожидаемый результат: Список пациентов с наибольшим числом обращений.