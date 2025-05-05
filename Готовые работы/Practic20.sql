CREATE DATABASE base_Shadiev_Abduvokhidov;
GO
USE base_Shadiev_Abduvokhidov;
CREATE TABLE base (
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);

INSERT INTO base (ProductName, Manufacturer, ProductCount, Price)
VALUES 
    ('Laptop', 'Dell', 10, 1500.00),
    ('Smartphone', 'Samsung', 20, 800.00),
    ('Tablet', 'Apple', 15, 1200.00),
    ('Monitor', 'LG', 5, 300.00),
    ('Keyboard', 'Logitech', 50, 50.00);


GO
CREATE TRIGGER base_INSERT_UPDATE
ON base
AFTER INSERT, UPDATE
AS
UPDATE base
SET Price = Price + Price * 0.38
WHERE Id = (SELECT Id FROM inserted)
GO

INSERT INTO base (ProductName, Manufacturer, ProductCount, Price)
VALUES ('Mouse', 'HP', 30, 25.00);

SELECT * FROM base WHERE ProductName = 'Mouse';


GO
CREATE TABLE Products (
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);
CREATE TABLE History (
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TRIGGER Products_INSERT
ON Products
AFTER INSERT
AS
INSERT INTO History (ProductId, Operation)
SELECT Id, 'Добавлен товар ' + ProductName + ' фирма ' + Manufacturer
FROM inserted;
GO

CREATE TRIGGER Products_DELETE
ON Products
AFTER DELETE
AS
INSERT INTO History (ProductId, Operation)
SELECT Id, 'Удален товар ' + ProductName + ' фирма ' + Manufacturer
FROM deleted;
GO

CREATE TRIGGER Products_UPDATE
ON Products
AFTER UPDATE
AS
INSERT INTO History (ProductId, Operation)
SELECT i.Id, 
    'Обновлен товар: Старое название "' + d.ProductName + 
    '", Новое название "' + i.ProductName + '"'
FROM inserted i
INNER JOIN deleted d ON i.Id = d.Id;
GO

INSERT INTO Products (ProductName, Manufacturer, Price)
VALUES ('Headphones', 'Sony', 200.00);

DELETE FROM Products WHERE ProductName = 'Headphones';

UPDATE Products SET ProductName = 'Wireless Mouse' WHERE Id = 1;

SELECT * FROM History;

CREATE TABLE Prods (
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    Price MONEY NOT NULL,
    IsDeleted BIT DEFAULT 0
);
GO

CREATE TRIGGER Prods_DELETE
ON Prods
INSTEAD OF DELETE
AS
UPDATE Prods
SET IsDeleted = 1
WHERE Id IN (SELECT Id FROM deleted);
GO

INSERT INTO Prods (ProductName, Manufacturer, Price)
VALUES ('iPhone X', 'Apple', 79000), ('Pixel 2', 'Google', 60000);
DELETE FROM Prods WHERE ProductName = 'Pixel 2';

SELECT * FROM Prods;

USE PaidPolyclinic_Shadiev_Abduvohidov_47
GO

ALTER TABLE Appeal
ADD TotalCost MONEY DEFAULT 0
GO

-- Автоматический расчет стоимости обращения при добавлении процедуры
CREATE TRIGGER trg_Treatment_Insert_UpdateTotalCost
ON Treatment
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE a
    SET a.TotalCost = ISNULL(a.TotalCost, 0) + (i.Quantity * st.Cost)
    FROM Appeal a
    INNER JOIN inserted i ON a.Id = i.AppealId
    INNER JOIN ServiceType st ON i.ServiceTypeId = st.Id;
    PRINT 'Общая стоимость обращения обновлена.';
END;
GO

-- Каскадное удаление процедур при удалении обращения
CREATE TRIGGER trg_Appeal_Delete_CascadeTreatment
ON Appeal
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM Treatment 
    WHERE AppealId IN (SELECT Id FROM deleted);
    DELETE FROM Appeal 
    WHERE Id IN (SELECT Id FROM deleted);
    PRINT 'Обращение и связанные процедуры удалены.';
END;
GO

-- Проверка даты обращения
CREATE TRIGGER trg_Appeal_Update_DateCheck
ON Appeal
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(Date)
    BEGIN
        IF EXISTS (
            SELECT * FROM inserted 
            WHERE [Date] > GETDATE()
        )
        BEGIN
            RAISERROR('Дата обращения не может быть в будущем!', 16, 1);
            ROLLBACK TRANSACTION;
        END
    END
END;
GO

INSERT INTO Treatment (AppealId, ServiceTypeId, Quantity)
VALUES (1, 2, 1);
SELECT * FROM Appeal WHERE Id = 1;

DELETE FROM Appeal WHERE Id = 5;
SELECT * FROM Treatment WHERE AppealId = 5;

UPDATE Appeal 
SET [Date] = '2035-01-01' 
WHERE Id = 1; 