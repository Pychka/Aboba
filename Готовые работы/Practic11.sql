CREATE DATABASE New_Shadiev_Abduvokhidov;
USE New_Shadiev_Abduvokhidov;

CREATE TABLE Products (
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);

CREATE TABLE Customers (
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(30) NOT NULL
);

CREATE TABLE Orders (
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
    CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
    CreatedAt DATE NOT NULL,
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
VALUES ('Tom'), ('Bob'), ('Sam');

INSERT INTO Orders 
VALUES 
(
	(SELECT Id FROM Products WHERE ProductName='Galaxy S8'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'), 
    '2017-07-11', 2, 
    (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
(
	(SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'), 
    '2017-07-13', 1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
),
(
	(SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
    (SELECT Id FROM Customers WHERE FirstName='Bob'), 
    '2017-07-11', 1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
);
GO

SELECT * 
FROM Products 
WHERE Price = (SELECT MIN(Price) FROM Products);

SELECT * 
FROM Products 
WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT CreatedAt, Price, (SELECT ProductName FROM Products WHERE Products.Id = Orders.ProductId) AS Product
FROM Orders;

SELECT ProductName, Manufacturer, Price,
	(SELECT AVG(Price) FROM Products AS SubProds WHERE SubProds.Manufacturer = Prods.Manufacturer) AS AvgPrice
FROM Products AS Prods
WHERE Price >
(SELECT AVG(Price) FROM Products AS SubProds WHERE SubProds.Manufacturer = Prods.Manufacturer);

SELECT * 
FROM Products 
WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT * 
FROM Customers 
WHERE Id NOT IN (SELECT CustomerId FROM Orders);

SELECT * 
FROM Products 
WHERE Price < ALL (SELECT Price FROM Products WHERE Manufacturer = 'Apple');

SELECT * 
FROM Customers 
WHERE EXISTS (SELECT * FROM Orders WHERE Orders.CustomerId = Customers.Id);

SELECT * 
FROM Products 
WHERE NOT EXISTS (SELECT * FROM Orders WHERE Orders.ProductId = Products.Id);

CREATE DATABASE Shop_Shadiev_Abduvohidov;
GO

USE Shop_Shadiev_Abduvohidov;

CREATE TABLE Customers (
    Id INT NOT NULL IDENTITY PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
);

CREATE TABLE Vendors
(
    Id INT NOT NULL IDENTITY PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    [Address] NVARCHAR(100) NOT NULL
);

CREATE TABLE Sale (
    Id INT NOT NULL IDENTITY PRIMARY KEY,
    IdCustomer INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
    DateSale DATETIME NOT NULL,
);

CREATE TABLE Incoming
(
    Id INT PRIMARY KEY IDENTITY NOT NULL,
    IdVendor INT FOREIGN KEY REFERENCES Vendors(Id) NOT NULL,
    DateIncoming DATETIME NOT NULL,
);

CREATE TABLE Products (
    Id INT NOT NULL IDENTITY PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Author NVARCHAR(100) NOT NULL
);

CREATE TABLE Prices
(
    Id INT NOT NULL FOREIGN KEY REFERENCES Products(Id),
    DateChanges DATE NOT NULL,
    Price MONEY NOT NULL,
    PRIMARY KEY (Id, DateChanges),
);

CREATE TABLE MagazineSales (
    IdSale INT NOT NULL FOREIGN KEY REFERENCES Sale(Id),
    IdProduct INT NOT NULL FOREIGN KEY REFERENCES Products(Id),
    Quantity INT NOT NULL,
	PRIMARY KEY (IdSale, IdProduct),
);

CREATE TABLE MagazineIncoming (
    IdIncoming INT NOT NULL FOREIGN KEY REFERENCES Incoming(Id),
    IdProduct INT NOT NULL FOREIGN KEY REFERENCES Products(Id),
    Quantity INT NOT NULL,
    PRIMARY KEY (IdIncoming, IdProduct),
);
GO
INSERT INTO Vendors ([Name], City, [Address]) VALUES
('Вильямс', 'Москва', 'ул.Лесная, д.43'),
('Дом печати', 'Минск', 'пр.Ф.Скорины, д.18'),
('БХВ-Петербург', 'Санкт-Петербург', 'ул.Есенина, д.5');

INSERT INTO Customers ([Name], Email) VALUES 
('Иванов Сергей', 'sergo@mail.ru'),
('Ленская Катя', 'lenskay@yandex.ru'),
('Демидов Олег', 'demidov@gmail.ru'),
('Афанасьев Виктор', 'victor@mail.ru'),
('Пажская Вера', 'verap@rambler.ru');

INSERT INTO Products ([Name], Author) VALUES 
('Стихи о любви', 'Андрей Вознесенский'),
('Собрание сочинений, том 2', 'Андрей Вознесенский'),
('Собрание сочинений, том 3', 'Андрей Вознесенский'),
('Русская поэзия', 'Николай Заболоцкий'),
('Машенька', 'Владимир Набоков'),
('Доктор Живаго', 'Борис Пастернак'),
('Наши', 'Сергей Довлатов'),
('Приглашение на казнь', 'Владимир Набоков'),
('Лолита', 'Владимир Набоков'),
('Темные аллеи', 'Иван Бунин'),
('Дар', 'Владимир Набоков'),
('Сын вождя', 'Юлия Вознесенская'),
('Эмигранты', 'Алексей Толстой'),
('Горе от ума', 'Александр Грибоедов'),
('Анна Каренина', 'Лев Толстой'),
('Повести и рассказы', 'Николай Лесков'),
('Антоновские яблоки', 'Иван Бунин'),
('Мертвые души', 'Николай Гоголь'),
('Три сестры', 'Антон Чехов'),
('Беглянка', 'Владимир Даль'),
('Идиот', 'Федор Достоевский'),
('Братья Карамазовы', 'Федор Достоевский'),
('Ревизор', 'Николай Гоголь'),
('Гранатовый браслет', 'Александр Куприн');

INSERT INTO Incoming (IdVendor, DateIncoming) VALUES 
('1', '2011-04-10'),
('2', '2011-04-11'),
('3', '2011-04-12');

INSERT INTO MagazineIncoming(IdIncoming, IdProduct, Quantity) VALUES 
('1', '1', '10'),
('1', '2', '5'),
('1', '3', '7'),
('1', '4', '10'),
('1', '5', '10'),
('1', '6', '8'),
('1', '18', '8'),
('1', '19', '8'),
('1', '20', '8'),
('2', '7', '10'),
('2', '8', '10'),
('2', '9', '6'),
('2', '10', '10'),
('2', '11', '10'),
('2', '21', '10'),
('2', '22', '10'),
('2', '23', '10'),
('2', '24', '10'),
('3', '12', '10'),
('3', '13', '10'),
('3', '14', '10'),
('3', '15', '10'),
('3', '16', '10'),
('3', '17', '10');

INSERT INTO Prices (Id, DateChanges, Price) VALUES
('1', '2011-04-10', '100'),
('2', '2011-04-10', '130'),
('3', '2011-04-10', '90'),
('4', '2011-04-10', '100'),
('5', '2011-04-10', '110'),
('6', '2011-04-10', '85'),
('7', '2011-04-11', '95'),
('8', '2011-04-11', '100'),
('9', '2011-04-11', '79'),
('10', '2011-04-11', '49'),
('11', '2011-04-11', '105'),
('12', '2011-04-12', '85'),
('13', '2011-04-12', '135'),
('14', '2011-04-12', '100'),
('15', '2011-04-12', '90'),
('16', '2011-04-12', '75'),
('17', '2011-04-12', '90'),
('18', '2011-04-10', '150'),
('19', '2011-04-10', '140'),
('20', '2011-04-10', '85'),
('21', '2011-04-11', '105'),
('22', '2011-04-11', '70'),
('23', '2011-04-11', '65'),
('24', '2011-04-11', '130');

INSERT INTO Sale (IdCustomer, DateSale) VALUES 
('2', '2011-04-11'),
('3', '2011-04-11'),
('5', '2011-04-11');

INSERT INTO MagazineSales(IdSale, IdProduct, Quantity) VALUES 
('1', '1', '1'),
('1', '5', '1'),
('1', '7', '1'),
('2', '2', '1'),
('3', '1', '1'),
('3', '7', '1');

GO

SELECT 
    MIN(Price) AS Минимальная_цена,
    MAX(Price) AS Максимальная_цена,
    AVG(Price) AS Средняя_цена
FROM Prices;

SELECT SUM(mi.Quantity * p.Price) AS Общая_сумма
FROM MagazineIncoming mi
JOIN Prices p ON mi.IdProduct = p.Id
JOIN Incoming i ON mi.IdIncoming = i.Id
WHERE i.IdVendor = 2;

SELECT p.[Name], COUNT(ms.IdSale) AS Количество_продаж
FROM Products p
LEFT JOIN MagazineSales ms ON p.Id = ms.IdProduct
GROUP BY p.[Name]
HAVING COUNT(ms.IdSale) = (
    SELECT MIN(sales_count)
    FROM (
        SELECT COUNT(IdSale) AS sales_count
        FROM MagazineSales
        GROUP BY IdProduct
    ) AS subquery
);

SELECT p.[Name], pr.price
FROM Products p
JOIN Prices pr ON p.Id = pr.Id
WHERE pr.price > (SELECT AVG(price) FROM prices);

SELECT AVG(pr.price) AS Средняя_цена
FROM MagazineIncoming mi
JOIN prices pr ON mi.IdProduct = pr.Id
JOIN incoming i ON mi.IdIncoming = i.Id
WHERE i.IdVendor = 3;

SELECT TOP 1 c.[Name], MAX(pr.price) AS Максимальная_цена
FROM Customers c
JOIN sale s ON c.Id = s.IdCustomer
JOIN MagazineSales ms ON s.Id = ms.IdSale
JOIN Prices pr ON ms.IdProduct = pr.Id
GROUP BY c.[Name]
ORDER BY Максимальная_цена DESC;

USE Vasya_list_Shadiev_Abduvokhidov

--Так как в лекциях по БД на момент 12.03.2025 отсутствуют таблицы salaries, job_listings, то было
--предпринято придумать их самим

ALTER TABLE Proffesion
ADD MinSalary MONEY;

ALTER TABLE Proffesion
ADD MaxSalary MONEY;

ALTER TABLE VasyaList
DROP COLUMN ProffesionId

GO

CREATE TABLE Salaries
(
    VasyaListId INT FOREIGN KEY REFERENCES VasyaList(Id),
    ProffesionId INT FOREIGN KEY REFERENCES Proffesion(Id),
    Amount MONEY,
	IsWork BIT,
	WorkExperience INT,
	WorkStartDate DATE,
	PRIMARY KEY(VasyaListId, ProffesionId)
);
GO

UPDATE Proffesion SET Title = 'Веб-разработчик', MinSalary = 40000, MaxSalary = 150000 WHERE Title = 'профессия1'
UPDATE Proffesion SET Title = 'Веб-дизайнер', MinSalary = 35000, MaxSalary = 120000 WHERE Title = 'профессия2'
UPDATE Proffesion SET Title = 'Frontend-разработчик', MinSalary = 45000, MaxSalary = 160000 WHERE Title = 'профессия3'
UPDATE Proffesion SET Title = 'Backend-разработчик', MinSalary = 50000, MaxSalary = 170000 WHERE Title = 'профессия4'
UPDATE Proffesion SET Title = 'DevOps-инженер', MinSalary = 70000, MaxSalary = 200000 WHERE Title = 'профессия5'
UPDATE Proffesion SET Title = 'Мобильный разработчик', MinSalary = 50000, MaxSalary = 160000 WHERE Title = 'профессия6'
UPDATE Proffesion SET Title = 'UX/UI-дизайнер', MinSalary = 45000, MaxSalary = 130000 WHERE Title = 'профессия7'
UPDATE Proffesion SET Title = 'Тестировщик (QA)', MinSalary = 30000, MaxSalary = 100000 WHERE Title = 'профессия8'
UPDATE Proffesion SET Title = 'Системный администратор', MinSalary = 40000, MaxSalary = 110000 WHERE Title = 'профессия9'
UPDATE Proffesion SET Title = 'Аналитик данных', MinSalary = 50000, MaxSalary = 150000 WHERE Title = 'профессия10'

INSERT INTO Salaries (VasyaListId, ProffesionId, Amount, IsWork, WorkExperience, WorkStartDate)
VALUES
(1, 1, 48000, 1, 3, DATEADD(DAY, -3, GETDATE())),
(2, 1, 110000, 0, 7, NULL),
(3, 1, 85000, 1, 5, DATEADD(MONTH, -5, GETDATE())),
(4, 2, 42000, 0, 2, NULL),
(5, 2, 98000, 1, 9, DATEADD(YEAR, -9, GETDATE())),
(6, 3, 60000, 1, 4, DATEADD(MONTH, -4, GETDATE())),
(7, 3, 145000, 0, 8, NULL),
(8, 4, 75000, 1, 6, DATEADD(DAY, -6, GETDATE())),
(9, 4, 155000, 1, 10, DATEADD(MONTH, -10, GETDATE())),
(10, 5, 95000, 0, 1, NULL),
(11, 5, 185000, 1, 5, DATEADD(MONTH, -5, GETDATE())),
(12, 6, 65000, 1, 2, DATEADD(DAY, -2, GETDATE())),
(13, 6, 140000, 0, 7, NULL),
(14, 7, 55000, 1, 3, DATEADD(DAY, -3, GETDATE())),
(15, 7, 125000, 1, 8, DATEADD(MONTH, -8, GETDATE())),
(16, 8, 40000, 0, 4, NULL),
(17, 8, 90000, 1, 6, DATEADD(YEAR, -6, GETDATE())),
(18, 9, 60000, 0, 1, NULL),
(19, 9, 105000, 1, 9, DATEADD(DAY, -9, GETDATE())),
(20, 10, 70000, 1, 2, DATEADD(DAY, -2, GETDATE())),
(21, 10, 135000, 0, 5, NULL),
(22, 1, 132000, 1, 4, DATEADD(MONTH, -4, GETDATE())),
(23, 3, 88000, 0, 3, NULL),
(24, 5, 175000, 1, 7, DATEADD(YEAR, -7, GETDATE())),
(25, 7, 115000, 1, 6, DATEADD(DAY, -6, GETDATE()));

SELECT pf.Title, vl.LastName, pf.Id, s.Amount FROM VasyaList AS vl
INNER JOIN Salaries s ON s.VasyaListId = vl.Id
INNER JOIN Proffesion pf ON pf.Id = s.ProffesionId
WHERE s.Amount <= 10500 AND pf.Title = 'Веб-разработчик' AND s.ProffesionId <= 5

SELECT TOP 1 vl.LastName, s.Amount FROM VasyaList AS vl
INNER JOIN Salaries s ON s.VasyaListId = vl.Id AND s.IsWork = 1
ORDER BY s.Amount DESC

SELECT vl.FirstName, vl.LastName FROM VasyaList AS vl
INNER JOIN Salaries s ON s.VasyaListId = vl.Id AND s.IsWork = 1
INNER JOIN Proffesion pf ON pf.Id = s.ProffesionId
WHERE s.Amount = pf.MaxSalary
ORDER BY s.Amount DESC

SELECT vl.FirstName, vl.LastName FROM VasyaList AS vl
INNER JOIN Salaries s ON s.VasyaListId = vl.Id AND s.IsWork = 1
INNER JOIN Proffesion pf ON pf.Id = s.ProffesionId
WHERE s.Amount > pf.MinSalary + (pf.MaxSalary - pf.MinSalary) / 2 
ORDER BY s.Amount DESC

--Ничего не поняли про почтовые индексы, но мы бы их делали так же как и ЗП через JOIN :D

USE PaidPolyclinic_Shadiev_Abduvohidov_47
-- Общая стоимость лечения для каждого пациента
SELECT 
    p.LastName + ' ' + p.[Name] AS PatientName,
    SUM(t.Quantity * st.Cost) AS TotalCost
FROM 
    Patient p
    JOIN Appeal a ON p.Id = a.PatientId
    JOIN Treatment t ON a.Id = t.AppealId
    JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY p.LastName, p.[Name];
-- Ожидаемый результат: Таблица с ФИО пациентов и суммарной стоимостью их лечения

-- Врачи с высшей категорией квалификации
SELECT 
    d.LastName + ' ' + d.[Name] AS DoctorName,
    s.[Name] AS Specialty,
    q.[Name] AS Qualification
FROM 
    Doctor d
    JOIN Specialty s ON d.SpecialtyId = s.Id
    JOIN Qualification q ON d.QualificationId = q.Id
WHERE 
    q.[Name] = 'Высшая категория';
-- Ожидаемый результат: Список врачей с высшей категорией и их специальности

-- Средняя стоимость услуги в поликлинике
SELECT 
    AVG(Cost) AS AverageServiceCost 
FROM 
    ServiceType;
-- Ожидаемый результат: Среднее значение стоимости услуг

-- Обращения с диагнозом, содержащим слово "грипп" (без учета регистра)
SELECT 
    a.[Date],
    p.LastName + ' ' + p.[Name] AS PatientName,
    a.Diagnos
FROM 
    Appeal a
    JOIN Patient p ON a.PatientId = p.Id
WHERE 
    LOWER(a.Diagnos) LIKE '%грипп%';
-- Ожидаемый результат: Список обращений с диагнозом, связанным с гриппом

-- Пациенты, которые не проходили рентген
SELECT 
    p.LastName + ' ' + p.[Name] AS PatientName
FROM 
    Patient p
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM Appeal a 
        JOIN Treatment t ON a.Id = t.AppealId 
        JOIN ServiceType st ON t.ServiceTypeId = st.Id 
        WHERE a.PatientId = p.Id AND st.[Name] = 'Рентген'
    );
-- Ожидаемый результат: Пациенты, не делавшие рентген

-- Детализация лечения для обращения с ID=1
SELECT 
    st.[Name] AS [Service],
    t.Quantity,
    st.Cost AS UnitPrice,
    t.Quantity * st.Cost AS Total
FROM 
    Treatment t
    JOIN ServiceType st ON t.ServiceTypeId = st.Id
WHERE 
    t.AppealId = 1;
-- Ожидаемый результат: Подробная информация о лечении для первого обращения

-- Самый дорогой вид услуги
SELECT TOP 1 
    [Name], 
    Cost 
FROM 
    ServiceType 
ORDER BY 
    Cost DESC;
-- Ожидаемый результат: Название и стоимость самой дорогой услуги

-- Количество обращений по специальностям врачей
SELECT 
    s.[Name] AS Specialty,
    COUNT(a.Id) AS AppealCount
FROM 
    Doctor d
    JOIN Specialty s ON d.SpecialtyId = s.Id
    JOIN Appeal a ON d.Id = a.DoctorId
GROUP BY 
    s.Name;
-- Ожидаемый результат: Распределение обращений по специальностям

-- Пациенты старше 40 лет
SELECT 
    LastName + ' ' + [Name] AS PatientName,
    DATEDIFF(YEAR, Birthday, GETDATE()) AS Age
FROM 
    Patient
WHERE 
    DATEDIFF(YEAR, Birthday, GETDATE()) > 40;