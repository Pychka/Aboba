USE Productsdb_Shadiev_Abduvokhidov;
GO

SELECT 
    UPPER(LEFT(Manufacturer, 2)) AS Abbreviation,
    CONCAT(ProductName, ' - ', Manufacturer) AS FullProdName
FROM Products
ORDER BY Abbreviation;
GO

SELECT DISTINCT 
    CONCAT(Manufacturer, ': ', ProductName) AS ManufacturerProduct
FROM Products;
GO

SELECT 
    ProductName,
    ROUND(Price * ProductCount, 2) AS TotalRounded
FROM Products;
GO

SELECT 
    ProductName,
    ROUND(Price * ProductCount * 0.25, 2) AS VAT
FROM Products;
GO

INSERT INTO Orders (ProductId, CustomerId, Createdate, ProductCount, Price)
VALUES 
(1, 1, '2023-10-15', 2, 50000),
(2, 2, '2023-11-05', 1, 60000);
GO

SELECT *
FROM Orders
WHERE 
    MONTH(Createdate) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
    AND YEAR(Createdate) = YEAR(DATEADD(MONTH, -1, GETDATE()));
GO

USE Vasya_list_Shadiev_Abduvokhidov
GO
--������� � �������������� ��������� ������� ��� ���������� � 10 ������������
SELECT 
    CONCAT(vl.LastName, ' ', vl.FirstName, ' (', s.Title, ')') AS ���������������������
FROM 
    VasyaList vl
    JOIN VasyaListSeeking vls ON vl.Id = vls.VasyaListId
    JOIN Seeking s ON vls.SeekingId = s.Id;

-- 4.2. ������� �������� ������������� (���������� �� �����)
SELECT 
    ROUND(AVG(s.Amount), -3) AS ����������������������������
FROM 
    Salaries s
    JOIN Proffesion p ON s.ProffesionId = p.Id
WHERE 
    p.Title = '�����������';

-- 4.3. ���� � ���� �������� � ������� ������
SELECT 
    CONCAT(vl.LastName, ' ', vl.FirstName) AS ���,
    FORMAT(b.[Date], 'dd.MM.yyyy') AS ������������
FROM 
    VasyaList vl
    JOIN Birthday b ON vl.BirthdayId = b.Id
WHERE 
    MONTH(b.[Date]) = MONTH(GETDATE());

-- 4.4. �������� ������ � ��������� 2 ������ (�����������, ��� IsWork = 1 � ���� � Salaries)
SELECT 
    CONCAT(vl.LastName, ' ', vl.FirstName) AS ���,
    FORMAT(GETDATE(), 'dd.MM.yyyy') AS ������������
FROM 
    VasyaList vl
    JOIN Salaries s ON vl.Id = s.VasyaListId
WHERE 
    s.IsWork = 1 
    AND DATEDIFF(day, s.WorkStartDate, GETDATE()) <= 14;


USE PaidPolyclinic_Shadiev_Abduvohidov_47
-- ��� ��������� � ���������� � ������� "������� �.�. (�������)"
SELECT 
    CONCAT(
        p.LastName, ' ', 
        LEFT(p.Name, 1), '. ', 
        LEFT(p.Patronymic, 1), '.'
    ) AS PatientInitials,
    CONCAT('(', a.Diagnos, ')') AS Diagnosis
FROM 
    Patient p
    JOIN Appeal a ON p.Id = a.PatientId;
-- ��������� ���������: ������� � ���������� ��������� � ���������� � �������.

-- ������� ��������� ������� � ����������� �� �����
SELECT 
    ROUND(AVG(t.Quantity * st.Cost), -2) AS AvgTreatmentCostRounded
FROM 
    Treatment t
    JOIN ServiceType st ON t.ServiceTypeId = st.Id;
-- ��������� ���������: ������� ��������� �������, ����������� �� ��������� �����.

-- �������� � ����� �������� � ������� ������
SELECT 
    CONCAT(p.LastName, ' ', p.Name) AS PatientName,
    FORMAT(p.Birthday, 'dd.MM.yyyy') AS BirthDate
FROM 
    Patient p
WHERE 
    MONTH(p.Birthday) = MONTH(GETDATE());
-- ��������� ���������: ������ ���������, � ������� ���� �������� � ������� ������.

-- ��������� �� ��������� 2 ������
SELECT 
    a.Id AS AppealId,
    FORMAT(a.Date, 'dd.MM.yyyy') AS AppealDate,
    p.LastName + ' ' + p.Name AS PatientName
FROM 
    Appeal a
    JOIN Patient p ON a.PatientId = p.Id
WHERE 
    DATEDIFF(week, a.Date, GETDATE()) <= 2;
-- ��������� ���������: ���������, ������������������ �� ��������� 14 ����.

-- ����� � ����������� ��������� ������������� (������ 3 �����)
SELECT 
    d.LastName + ' ' + d.Name AS DoctorName,
    LEFT(s.Name, 3) + '.' AS SpecialtyAbbreviation
FROM 
    Doctor d
    JOIN Specialty s ON d.SpecialtyId = s.Id;
-- ��������� ���������: ����� ������ � ������������ ���������� �� ��������������.

-- ��������� ����� � ������� �������� � ����������� ������
SELECT 
    UPPER(Name) AS ServiceName,
    CONCAT(CAST(Cost AS INT),'���.') AS CostWithCurrency
FROM 
    ServiceType;
-- ��������� ���������: �������� ����� � ������� �������� � ��������� ��������� � ������.

-- ���������� ���� � ������� ���������� ��������� ������� ��������
SELECT 
    p.LastName + ' ' + p.Name AS PatientName,
    DATEDIFF(day, MAX(a.Date), GETDATE()) AS DaysSinceLastAppeal
FROM 
    Patient p
    LEFT JOIN Appeal a ON p.Id = a.PatientId
GROUP BY 
    p.Id, p.LastName, p.Name;
-- ��������� ���������: ���������� ����, ��������� � ���������� ��������� ������� ��������.
