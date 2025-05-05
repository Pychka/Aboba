CREATE DATABASE Practic17_Shadiev_Abduvokhidov
GO
USE Practic17_Shadiev_Abduvokhidov

CREATE TABLE Accounts
(
	FirstName NVARCHAR NOT NULL,
	Age INT NOT NULL
)

GO

BEGIN TRY
	INSERT INTO Accounts VALUES(NULL, NULL)
	PRINT '������ ������� ���������!'
END TRY
BEGIN CATCH
	PRINT '������ ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH

USE Vasya_list_Shadiev_Abduvokhidov

BEGIN TRY
	INSERT INTO Birthday VALUES('99/99/9999')
	PRINT '������ ������� ���������!'
END TRY
BEGIN CATCH
	PRINT '������ ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH

DECLARE @countPeople INT, @date DATE = '29/11/2024';
SELECT @countPeople = COUNT(WorkStartDate) FROM Salaries WHERE WorkStartDate = @date

IF @countPeople > 0
	PRINT CONVERT(VARCHAR, @date) + ' �� ������ ���������� ' + CONVERT(VARCHAR, @countPeople) + ' �������(�)'
ELSE PRINT CONVERT(VARCHAR, @date) + ' ����� �� ����������� �� ������'

IF EXISTS(SELECT * FROM VasyaList AS vs	JOIN Salaries s ON s.VasyaListId = vs.Id JOIN Proffesion p ON p.Id = s.ProffesionId WHERE vs.Gender = '�' AND p.Title = '�����������')
	SELECT vl.FirstName, vl.LastName, vl.Gender, s.Amount FROM VasyaList AS vl
	JOIN Salaries s ON s.VasyaListId = vl.Id
	JOIN Proffesion p ON p.Id = s.ProffesionId
	WHERE vl.Gender = '�' AND p.Title = '�����������'
ELSE SELECT '������ �� �������' AS Result

IF EXISTS(	SELECT vl.FirstName, vl.LastName, s.Amount FROM VasyaList AS vl JOIN Salaries s ON s.VasyaListId = vl.Id WHERE s.Amount > 100000)
	SELECT vl.FirstName, vl.LastName, s.Amount FROM VasyaList AS vl
	JOIN Salaries s ON s.VasyaListId = vl.Id
	WHERE s.Amount > 100000
ELSE SELECT '������ �� �������' AS Result

DECLARE @number INT = 0, @power INT = 0, @result INT = 1, @counter INT = 0;

IF @power < 0 OR (@power = 0 AND @number = 0)
BEGIN
	PRINT '������������ ������'
	SET @result = NULL;
END

ELSE IF @power = 0
	SET @result = 1

WHILE(@counter < @power)
BEGIN
	SET @result = @result * @number;
	SET @counter += 1;
END

SELECT
	@number AS �����,
	@power AS �������,
	@result AS ����

USE PaidPolyclinic_Shadiev_Abduvohidov_47

--������� ������ ����� ��������� ����� ����������
DECLARE @TotalPatients INT;
SELECT @TotalPatients = COUNT(*) FROM Patient;
PRINT '����� ���������� ���������: ' + CAST(@TotalPatients AS NVARCHAR);
--��������� ���������: ����� ������ ����� ��������� � ����

--�������� ������� �������� ���������
IF EXISTS (SELECT * FROM Appeal WHERE Diagnos = '�������')
    PRINT '������� �������� � ��������� "�������"';
ELSE
    PRINT '��������� � ��������� "�������" ���';
--��������� ���������: ��������� � �������/���������� �������

--������������� ��������� �� ����
SELECT 
    p.LastName AS �������,
    p.Name AS ���,
    a.Diagnos AS �������,
    CASE 
        WHEN a.Date > '2023-09-01' THEN '����� ���������'
        ELSE '����� ������������������'
    END AS ������
FROM Appeal a
JOIN Patient p ON a.PatientId = p.Id;
--��������� ���������: ������������� ��������� �� ����

--��������� ������ ��� ������� ������������� ��������� ������.
BEGIN TRY
    INSERT INTO ServiceType (Name, Cost) 
    VALUES ('������������', -500); -- ��������� CHECK-�����������
END TRY
BEGIN CATCH
    PRINT '������: ' + ERROR_MESSAGE();
END CATCH;
-- ��������� ���������: ��������� �� ������ ��������� �����������