USE New_Shadiev_Abduvokhidov;
DECLARE @lastDate DATE, @count INT, @sum MONEY;

SELECT
	@lastDate = MAX(CreatedAt),
	@count = SUM(ProductCount),
	@sum = SUM(ProductCount * Price)
FROM Orders

IF DATEDIFF(DAY, ISNULL(@lastDate, '11/09/2001'), GETDATE()) > 10
	PRINT 'За последние десять дней не было заказов'
ELSE
	PRINT 'За последние десять дней были заказы';

IF @count > 0
	BEGIN
		PRINT 'Дата последнего заказа: ' + CONVERT(NVARCHAR, @lastDate)
		PRINT 'Продано ' + CONVERT(NVARCHAR, @count) + ' едениц(ы)'
		PRINT 'На общую сумму ' + CONVERT(NVARCHAR, @sum)
	END;
ELSE
	PRINT 'Заказы в базе данных отсутствуют'

DECLARE @number INT = 5, @factorial INT = 1;

WHILE @number > 0
	BEGIN
		SET @factorial = @factorial * @number
		SET @number = @number - 1
	END
PRINT @factorial

CREATE DATABASE Score_Shadiev_Abduvokhidov;
GO

USE Score_Shadiev_Abduvokhidov;

CREATE TABLE #Accounts
(
	CreatedAt DATE,
	Balance MONEY
)
GO

DECLARE 
	@rate FLOAT = 0.065,
	@period INT = 5,
	@sum MONEY = 10000,
	@date DATE = GETDATE()
WHILE @period > 0
	BEGIN
		INSERT INTO #Accounts VALUES(@date, @sum)
		SET @period = @period - 1
		SET @date = DATEADD(year, 1, @date)
		SET @sum = @sum + @sum * @rate
	END;
SELECT * FROM #Accounts

DECLARE @number INT = 1

WHILE @number < 10
	BEGIN
		PRINT CONVERT(VARCHAR, @number)
		SET @number = @number + 1
		IF @number = 7
			BREAK;
		IF @number = 4
			CONTINUE;
		PRINT 'Конец итерации'
END;

USE New_Shadiev_Abduvokhidov

INSERT INTO Products(Price, ProductCount, ProductName, Manufacturer)
VALUES
(100, 20, 'Бананы', 'Африка'),
(10, 200, 'Люди', 'Африка');

DECLARE @InflationRate FLOAT = 0.08;
DECLARE @Years INT = 5;

SELECT 
    ProductName, 
    Price,
	@Years AS Years,
    ROUND(Price * POWER(1 + @InflationRate, @Years), 2) AS FuturePrice
FROM Products;
GO

CREATE FUNCTION dbo.NumberToWords(@num INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN CASE @num
        WHEN 1 THEN 'Один'
        WHEN 2 THEN 'Два'
        WHEN 3 THEN 'Три'
        WHEN 4 THEN 'Четыре'
        WHEN 5 THEN 'Пять'
        WHEN 6 THEN 'Шесть'
        WHEN 7 THEN 'Семь'
        WHEN 8 THEN 'Восемь'
        WHEN 9 THEN 'Девять'
        WHEN 10 THEN 'Десять'
		WHEN 11 THEN 'Одинадцать'
		WHEN 12 THEN 'Двенадцать'
		WHEN 13 THEN 'Тринадцать'
		WHEN 14 THEN 'Четырнадцать'
		WHEN 15 THEN 'Пятнадцать'
		WHEN 16 THEN 'Шестнадцать'
		WHEN 17 THEN 'Семнадцать'
		WHEN 18 THEN 'Восемнадцать'
		WHEN 19 THEN 'Девятнадцать'
		WHEN 20 THEN 'Двадцать'
		ELSE 'Больше 20'
	END;
END;

GO

SELECT 
    ProductName, 
    Price, 
    dbo.NumberToWords(Price) AS PriceWords 
FROM Products;

USE PaidPolyclinic_Shadiev_Abduvohidov_47

--Расчет общей стоимости всех процедур через переменную
DECLARE @TotalCost MONEY;
SELECT @TotalCost = SUM(st.Cost * t.Quantity)
FROM Treatment t
JOIN ServiceType st ON t.ServiceTypeId = st.Id;

PRINT 'Общая стоимость всех проведенных процедур: ' + CAST(@TotalCost AS NVARCHAR) + ' руб.';
-- Ожидаемый результат: Вывод общей суммы затрат на все процедуры

--Проверка наличия диагноза "Грипп"
IF EXISTS (SELECT * FROM Appeal WHERE Diagnos = 'Грипп')
    PRINT 'Найдены пациенты с диагнозом "Грипп"';
ELSE
    PRINT 'Пациентов с диагнозом "Грипп" нет';
-- Ожидаемый результат: Сообщение о наличии/отсутствии пациентов с гриппом

--Группировка обращений по категориям стоимости
SELECT 
    a.Id AS AppealID,
    a.Diagnos,
    CASE 
        WHEN SUM(st.Cost * t.Quantity) > 2000 THEN 'Дорогое лечение'
        WHEN SUM(st.Cost * t.Quantity) BETWEEN 1000 AND 2000 THEN 'Средняя стоимость'
        ELSE 'Бюджетное лечение'
    END AS CostCategory
FROM Appeal a
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY a.Id, a.Diagnos;
-- Ожидаемый результат: Классификация обращений по стоимости лечения

--Добавление тестовых данных в цикле
DECLARE @Counter INT = 1;
WHILE @Counter <= 5
BEGIN
    INSERT INTO ServiceType (Name, Cost)
    VALUES ('Тестовая услуга ' + CAST(@Counter AS NVARCHAR), @Counter * 500);
    SET @Counter += 1;
END;
PRINT 'Добавлено 5 тестовых услуг';
-- Ожидаемый результат: Добавление 5 записей в таблицу ServiceType