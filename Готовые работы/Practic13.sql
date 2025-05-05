USE Productsdb_Shadiev_Abduvokhidov

SELECT Id, CAST(Createdate AS NVARCHAR) + '; total: ' + CAST(Price * ProductCount AS NVARCHAR)
FROM Orders

SELECT
	CONVERT(NVARCHAR, Createdate, 3),
	CONVERT(NVARCHAR, Price * ProductCount, 1)
FROM Orders

SELECT TRY_CONVERT(int, 'sql')
SELECT TRY_CONVERT(int, '22')

SELECT ProductName, Manufacturer,
	CASE ProductCount
		WHEN 1 THEN '����� �������������'
		WHEN 2 THEN '���� ������'
		WHEN 3 THEN '���� � �������'
		ELSE '����� ������'
	END AS EvaluateCount
FROM Products

SELECT ProductName, Manufacturer,
	CASE
		WHEN Price > 50000 THEN '��������� A'
		WHEN Price BETWEEN 40000 AND 50000 THEN '��������� B'
		WHEN Price BETWEEN 30000 AND 40000 THEN '��������� C'
		ELSE '��������� D'
	END AS Category
FROM Products

SELECT ProductName, Manufacturer,
	IIF(ProductCount > 3, '����� ������', '���� ������')
FROM Products

USE lecture_Primer_Shadiev_Abduvokhidov

CREATE TABLE #Movie
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100),
	Rating VARCHAR(10),
	Drama NVARCHAR(1),
	Comdey NVARCHAR(1),
	[Action] NVARCHAR(1),
	Gore NVARCHAR(1),
	Staff NVARCHAR(1),
	ForKids NVARCHAR(1),
	Cartoon NVARCHAR(1),
	Purchased DATE,
);
GO

INSERT INTO #Movie (Title, Rating, Drama, Comdey, [Action], Gore, Staff, ForKids, Cartoon, Purchased)
VALUES
('���������� ��������',   'G', '�', '�', '�', '�', '�', '�', '�', '2002-03-06'),
('�������� ����',          'R', '�', '�', '�', '�', '�', '�', '�', '2001-02-05'),
('��������� ������',       'G', '�', '�', '�', '�', '�', '�', '�', '1999-11-20'),
('������������ �����',     'R', '�', '�', '�', '�', '�', '�', '�', '2003-04-19'),
('������ �� ����� �����',  'R', '�', '�', '�', '�', '�', '�', '�', '2003-04-19'),
('����������',             'PG','�', '�', '�', '�', '�', '�', '�', '2001-02-05');

CREATE TABLE Rating
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(10),
);
GO

CREATE TABLE Purchased
(
	Id INT PRIMARY KEY IDENTITY,
	[Date] DATE,
);

CREATE TABLE Genre
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100),
);

CREATE TABLE Movie
(
	Id INT PRIMARY KEY IDENTITY,
	RatingId INT FOREIGN KEY REFERENCES Rating(Id),
	PurchasedId INT FOREIGN KEY REFERENCES Purchased(Id),
	Title NVARCHAR(100),
);
GO

CREATE TABLE GenreMovie
(
	GenreId INT FOREIGN KEY REFERENCES Genre(Id),
	MovieId INT FOREIGN KEY REFERENCES Movie(Id),
	PRIMARY KEY(MovieId,GenreId),
);

GO

INSERT INTO Purchased([Date])
SELECT Purchased FROM #Movie

INSERT INTO Rating(Title)
SELECT DISTINCT Rating FROM #Movie

INSERT INTO Genre(Title)
VALUES
('Drama'),
('Comdey'),
('Action'),
('Gore'),
('Staff'),
('ForKids'),
('Cartoon');

GO

INSERT INTO Movie(RatingId, Title, PurchasedId)
SELECT r.Id, m.Title, p.Id FROM #Movie AS m
JOIN Rating r ON r.Title = m.Rating
JOIN Purchased p ON p.[Date] = m.Purchased

INSERT INTO GenreMovie (MovieId, GenreId)
SELECT 
    m.Id AS MovieId,
    g.Id AS GenreId
FROM #Movie tmp
JOIN Movie m ON tmp.Title = m.Title
CROSS APPLY(
	VALUES
		('Drama',tmp.Drama),
		('Comedy', tmp.Comdey),
        ('Action', tmp.[Action]),
        ('Gore', tmp.Gore),
        ('Staff', tmp.Staff),
        ('ForKids', tmp.ForKids),
        ('Cartoon', tmp.Cartoon)
	) AS ct(GenreName, Flag)
	JOIN Genre g ON ct.GenreName = g.Title
WHERE 
    ct.Flag = '�';

USE Vasya_list_Shadiev_Abduvokhidov
ALTER TABLE VasyaList
ADD Age INT;
GO

UPDATE vl
SET vl.Age = DATEDIFF(YEAR, b.[Date], GETDATE())
FROM VasyaList vl
JOIN Birthday b ON b.[Id] = vl.BirthdayId

UPDATE Salaries
SET WorkExperience += DATEDIFF(YEAR, WorkStartDate, GETDATE());

ALTER TABLE Salaries
ADD Awards NVARCHAR(100);
GO

UPDATE Salaries
SET Awards = IIF(WorkExperience > 10, '�� ��������������� ����', NULL);

USE PaidPolyclinic_Shadiev_Abduvohidov_47

-- ��������� ������� "�������" � ������� Patient
ALTER TABLE Patient
ADD Age AS DATEDIFF(YEAR, Birthday, GETDATE());
GO
-- �������� �����������
SELECT 
    LastName AS �������,
    Name AS ���,
    Birthday AS [���� ��������],
    Age
FROM Patient;

ALTER TABLE Doctor
ADD WorkExperience INT;
GO

-- ��������� ���� �� ������ ������������ (�������� ������)
UPDATE Doctor
SET WorkExperience = CASE QualificationId
    WHEN 1 THEN 15
    WHEN 2 THEN 10
    WHEN 3 THEN 5
    WHEN 4 THEN 20
    WHEN 5 THEN 25
END;
Go

-- �������� �����������
SELECT 
    LastName AS �������,
    [Name] AS ���,
    WorkExperience
FROM Doctor;

-- ��������� ������� "�������"
ALTER TABLE Doctor
ADD Awards NVARCHAR(100);
GO

-- ��������� �������
UPDATE Doctor
SET Awards = IIF(WorkExperience > 10, '�� ��������������� ����', NULL);

-- �������� �����������
SELECT 
    LastName AS �������,
    Name AS ���,
    WorkExperience,
    Awards
FROM Doctor;

-- ����� ��������� ������� ��� ������� ��������
SELECT 
    p.LastName AS �������,
    p.Name AS ���,
    SUM(st.Cost * t.Quantity) AS [����� ���������]
FROM Patient p
JOIN Appeal a ON p.Id = a.PatientId
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY p.LastName, p.Name;

-- ����� �� �������������� ������
SELECT 
    s.Name AS �������������,
    SUM(st.Cost * t.Quantity) AS �����
FROM Doctor d
JOIN Specialty s ON d.SpecialtyId = s.Id
JOIN Appeal a ON d.Id = a.DoctorId
JOIN Treatment t ON a.Id = t.AppealId
JOIN ServiceType st ON t.ServiceTypeId = st.Id
GROUP BY s.Name;

-- �������������� ���� ���������
SELECT 
    Id AS [����� ���������],
    FORMAT(Date, 'dd-MM-yyyy') AS [����],
    Diagnos AS �������
FROM Appeal;

-- ������������� ��������� �����
SELECT 
    Name AS ������,
    Cost AS ���������,
    CASE 
        WHEN Cost > 2000 THEN '�������'
        WHEN Cost BETWEEN 1000 AND 2000 THEN '�������'
        ELSE '������'
    END AS ���������
FROM ServiceType;