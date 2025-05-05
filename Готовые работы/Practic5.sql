USE Productsdb_Shadiev_Abduvokhidov
SELECT
	*
FROM Products
WHERE Manufacturer = 'Samsung'

SELECT
	*
FROM Products
WHERE Price > 45000

SELECT
	*
FROM Products
WHERE Price * ProductCount > 200000

SELECT
	*
FROM Products
WHERE Manufacturer = 'Samsung' AND Price > 50000

SELECT
	*
FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 50000

SELECT
	*
FROM Products
WHERE Manufacturer != 'Samsung'

SELECT
	*
FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 30000 AND ProductCount > 2

SELECT
	*
FROM Products
WHERE ProductCount IS NULL

SELECT
	*
FROM Products
WHERE ProductCount IS NOT NULL

SELECT
	*
FROM Products
WHERE Manufacturer IN ('Samsung',' Xiaomi','Huawei')

SELECT
	*
FROM Products
WHERE Price BETWEEN 20000 AND 40000

SELECT
	*
FROM Products
WHERE Price NOT BETWEEN 20000 AND 40000

SELECT
	*
FROM Products
WHERE Price * ProductCount BETWEEN 100000 AND 200000

SELECT
	*
FROM Products
WHERE ProductName LIKE 'Iphone [6-8]%'

UPDATE Products
SET Price = Price + 5000

UPDATE Products
SET Manufacturer = 'Samsung Inc.'
WHERE Manufacturer = 'Samsung'

UPDATE Products
SET Manufacturer = 'Apple Inc.'
FROM
(
	SELECT TOP 2 * FROM Products WHERE Manufacturer = 'Apple'
) AS Selected
WHERE Products.Id = Selected.Id

DELETE Products
WHERE Id = 9

DELETE Products
WHERE Manufacturer = 'Xiaomi' AND Price < 15000

DELETE Products FROM
(
	SELECT TOP 2
		*
	FROM Products
	WHERE Manufacturer = 'Apple'
) AS s
WHERE Products.Id = s.Id
USE lecture_Primer_Shadiev_Abduvokhidov
CREATE TABLE Clown_Info
(
	[Name] NVARCHAR(50) NOT NULL,
	Last_Seen NVARCHAR(100),
	Appearance NVARCHAR(100) NOT NULL,
	Activities NVARCHAR(100)
);
GO
INSERT INTO Clown_Info
VALUES
('����', '��� ����������� ����� ����', '�, ����� ������, ������� ������, �������� �������', '������, �������'),
('�����', '��������� ����� �����', '�, ��������� ������, ����� ������, �������� �������', '���'),
('������', '�������', '�, ������ �������, ������� �����', '�����, ������'),
('������ ����', '���� BG', '�, ������, ������ ������, ��������� �����', '�������'),
('���������', '��� ����������� ��������', '�, ������� ������, ������� ������, ����� ������', '��������, �����'),
('������', '�������� ������', '�, ����� ������, ������� ������, ������� ���', '������'),
('�����', '�������� ����� ��������', '�, ��������� ������, �����', '�����'),
('����', '��������� ����','�, ������� ������ � ���������', '��������������, �������'),
('�����', NULL,'�, ������� ������ � �������', '�����, �����'),
('������', '��������� ������', '�, ������-���������� ������, ������� ���', NULL);

SELECT * FROM Clown_Info
WHERE Last_Seen IS NULL

DELETE FROM Clown_Info
WHERE [Name] != '������'

--���������� �������--
INSERT INTO Clown_Info
VALUES
('������','������� �����','�, ������-���������� ������, ������� ���',NULL),
('������','������� ���','�, ������-���������� ������, ������� ���',NULL)
GO

DECLARE @count INT
SELECT @count = COUNT(*)
FROM Clown_Info
WHERE [Name] = '������'

SELECT * FROM Clown_Info
WHERE [Name] = '������'
ORDER BY [Name]
OFFSET 0 ROWS
FETCH NEXT @count-1 ROWS ONLY
--��� ��� ����� ������� ��� ������ ����� ���������, �� ��� �� ��������� ��� �������� �� ��� � �� ��������)--

UPDATE Drink_Info
SET Carbs = 170
WHERE [Name] = '�������'

UPDATE Drink_Info
SET Color = '����������'
WHERE Color = 'Ƹ����'

UPDATE Drink_Info
SET Cost = 4.5
WHERE Cost = 3.5

UPDATE Drink_Info
SET Cost = 3.5
WHERE Cost = 2.5

UPDATE Clown_Info
SET Last_Seen = '��������� ������'
WHERE [Name] = '������ ����'
AND Last_Seen = '���� ������'

UPDATE Clown_Info
SET Activities = '�����'
WHERE [Name] = '�����'

UPDATE Clown_Info
SET Appearance = '�, ����� �������, ����� �����'
WHERE [Name] = 'Snuggles'

UPDATE Clown_Info
SET Activities = '���������� �� �������'
WHERE [Name] = '������'

USE PaidPolyclinic_Shadiev_Abduvohidov_47

SELECT
	Diagnos
	Cost
FROM Appeal
WHERE Cost > 1000

SELECT
	[Name],
	LastName
FROM Doctor
WHERE [Name] Like '�%'

SELECT
		[Name],
	LastName
FROM Patient
WHERE [Name] Like '%�%'

SELECT
	Cost
FROM Treatment
WHERE Cost > 1000
USE PaidPolyclinic_Shadiev_Abduvohidov_47

SELECT
	Diagnos,
	Cost
FROM Appeal
WHERE Cost IN (SELECT Cost FROM Appeal WHERE Cost < 5000)