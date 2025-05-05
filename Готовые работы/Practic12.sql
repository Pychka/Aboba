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
--Перенос с использованием текстовых функций был реализован в 10 практической
SELECT 
    CONCAT(vl.LastName, ' ', vl.FirstName, ' (', s.Title, ')') AS СоискательСДолжностью
FROM 
    VasyaList vl
    JOIN VasyaListSeeking vls ON vl.Id = vls.VasyaListId
    JOIN Seeking s ON vls.SeekingId = s.Id;

-- 4.2. Средняя зарплата программистов (округление до тысяч)
SELECT 
    ROUND(AVG(s.Amount), -3) AS СредняяЗарплатаПрограммистов
FROM 
    Salaries s
    JOIN Proffesion p ON s.ProffesionId = p.Id
WHERE 
    p.Title = 'Программист';

-- 4.3. Люди с днем рождения в текущем месяце
SELECT 
    CONCAT(vl.LastName, ' ', vl.FirstName) AS ФИО,
    FORMAT(b.[Date], 'dd.MM.yyyy') AS ДатаРождения
FROM 
    VasyaList vl
    JOIN Birthday b ON vl.BirthdayId = b.Id
WHERE 
    MONTH(b.[Date]) = MONTH(GETDATE());

-- 4.4. Нашедшие работу в последние 2 недели (предположим, что IsWork = 1 и дата в Salaries)
SELECT 
    CONCAT(vl.LastName, ' ', vl.FirstName) AS ФИО,
    FORMAT(GETDATE(), 'dd.MM.yyyy') AS ДатаПроверки
FROM 
    VasyaList vl
    JOIN Salaries s ON vl.Id = s.VasyaListId
WHERE 
    s.IsWork = 1 
    AND DATEDIFF(day, s.WorkStartDate, GETDATE()) <= 14;


USE PaidPolyclinic_Shadiev_Abduvohidov_47
-- ФИО пациентов с диагнозами в формате "Фамилия И.О. (Диагноз)"
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
-- Ожидаемый результат: Таблица с инициалами пациентов и диагнозами в скобках.

-- Средняя стоимость лечения с округлением до сотен
SELECT 
    ROUND(AVG(t.Quantity * st.Cost), -2) AS AvgTreatmentCostRounded
FROM 
    Treatment t
    JOIN ServiceType st ON t.ServiceTypeId = st.Id;
-- Ожидаемый результат: Средняя стоимость лечения, округленная до ближайших сотен.

-- Пациенты с днями рождения в текущем месяце
SELECT 
    CONCAT(p.LastName, ' ', p.Name) AS PatientName,
    FORMAT(p.Birthday, 'dd.MM.yyyy') AS BirthDate
FROM 
    Patient p
WHERE 
    MONTH(p.Birthday) = MONTH(GETDATE());
-- Ожидаемый результат: Список пациентов, у которых день рождения в текущем месяце.

-- Обращения за последние 2 недели
SELECT 
    a.Id AS AppealId,
    FORMAT(a.Date, 'dd.MM.yyyy') AS AppealDate,
    p.LastName + ' ' + p.Name AS PatientName
FROM 
    Appeal a
    JOIN Patient p ON a.PatientId = p.Id
WHERE 
    DATEDIFF(week, a.Date, GETDATE()) <= 2;
-- Ожидаемый результат: Обращения, зарегистрированные за последние 14 дней.

-- Врачи с сокращенным названием специальности (первые 3 буквы)
SELECT 
    d.LastName + ' ' + d.Name AS DoctorName,
    LEFT(s.Name, 3) + '.' AS SpecialtyAbbreviation
FROM 
    Doctor d
    JOIN Specialty s ON d.SpecialtyId = s.Id;
-- Ожидаемый результат: Имена врачей с сокращенными названиями их специальностей.

-- Стоимость услуг в верхнем регистре с добавлением валюты
SELECT 
    UPPER(Name) AS ServiceName,
    CONCAT(CAST(Cost AS INT),'руб.') AS CostWithCurrency
FROM 
    ServiceType;
-- Ожидаемый результат: Названия услуг в верхнем регистре с указанием стоимости в рублях.

-- Количество дней с момента последнего обращения каждого пациента
SELECT 
    p.LastName + ' ' + p.Name AS PatientName,
    DATEDIFF(day, MAX(a.Date), GETDATE()) AS DaysSinceLastAppeal
FROM 
    Patient p
    LEFT JOIN Appeal a ON p.Id = a.PatientId
GROUP BY 
    p.Id, p.LastName, p.Name;
-- Ожидаемый результат: Количество дней, прошедших с последнего обращения каждого пациента.
