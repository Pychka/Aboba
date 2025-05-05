USE New_Shadiev_Abduvokhidov;
DECLARE @lastDate DATE, @count INT, @sum MONEY;

SELECT
	@lastDate = MAX(CreatedAt),
	@count = SUM(ProductCount),
	@sum = SUM(ProductCount * Price)
FROM Orders

IF DATEDIFF(DAY, ISNULL(@lastDate, '11/09/2001'), GETDATE()) > 10
	PRINT '�� ��������� ������ ���� �� ���� �������'
ELSE
	PRINT '�� ��������� ������ ���� ���� ������';

IF @count > 0
	BEGIN
		PRINT '���� ���������� ������: ' + CONVERT(NVARCHAR, @lastDate)
		PRINT '������� ' + CONVERT(NVARCHAR, @count) + ' ������(�)'
		PRINT '�� ����� ����� ' + CONVERT(NVARCHAR, @sum)
	END;
ELSE
	PRINT '������ � ���� ������ �����������'

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
		PRINT '����� ��������'
END;

USE New_Shadiev_Abduvokhidov

INSERT INTO Products(Price, ProductCount, ProductName, Manufacturer)
VALUES
(100, 20, '������', '������'),
(10, 200, '����', '������');

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
        WHEN 1 THEN '����'
        WHEN 2 THEN '���'
        WHEN 3 THEN '���'
        WHEN 4 THEN '������'
        WHEN 5 THEN '����'
        WHEN 6 THEN '�����'
        WHEN 7 THEN '����'
        WHEN 8 THEN '������'
        WHEN 9 THEN '������'
        WHEN 10 THEN '������'
		WHEN 11 THEN '����������'
		WHEN 12 THEN '����������'
		WHEN 13 THEN '����������'
		WHEN 14 THEN '������������'
		WHEN 15 THEN '����������'
		WHEN 16 THEN '�����������'
		WHEN 17 THEN '����������'
		WHEN 18 THEN '������������'
		WHEN 19 THEN '������������'
		WHEN 20 THEN '��������'
		ELSE '������ 20'
	END;
END;

GO

SELECT 
    ProductName, 
    Price, 
    dbo.NumberToWords(Price) AS PriceWords 
FROM Products;

USE PaidPolyclinic_Shadiev_Abduvohidov_47

--������ ����� ��������� ���� �������� ����� ����������
DECLARE @TotalCost MONEY;
SELECT @TotalCost = SUM(st.Cost * t.Quantity)
FROM Treatment t
JOIN ServiceType st ON t.ServiceTypeId = st.Id;

PRINT '����� ��������� ���� ����������� ��������: ' + CAST(@TotalCost AS NVARCHAR) + ' ���.';
-- ��������� ���������: ����� ����� ����� ������ �� ��� ���������

--�������� ������� �������� "�����"
IF EXISTS (SELECT * FROM Appeal WHERE Diagnos = '�����')
    PRINT '������� �������� � ��������� "�����"';
ELSE
    PRINT '��������� � ��������� "�����" ���';
-- ��������� ���������: ��������� � �������/���������� ��������� � �������

--����������� ��������� �� ���������� ���������
SELECT 
    a.Id AS AppealID,
    a.Diagnos,
    CASE 
        WHEN SUM(st.Cost * t.Quantity) > 2000 THEN '������� �������'
        WHEN SUM(st.Cost * t.Quantity) BETWEEN 1000 AND 2000 THEN '������� ���������'
        ELSE '��������� �������'
    END AS CostCategory
FROM Appeal a
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY a.Id, a.Diagnos;
-- ��������� ���������: ������������� ��������� �� ��������� �������

--���������� �������� ������ � �����
DECLARE @Counter INT = 1;
WHILE @Counter <= 5
BEGIN
    INSERT INTO ServiceType (Name, Cost)
    VALUES ('�������� ������ ' + CAST(@Counter AS NVARCHAR), @Counter * 500);
    SET @Counter += 1;
END;
PRINT '��������� 5 �������� �����';
-- ��������� ���������: ���������� 5 ������� � ������� ServiceType