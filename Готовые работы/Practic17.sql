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
	PRINT 'Данные успешно добавлены!'
END TRY
BEGIN CATCH
	PRINT 'Ошибка ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH

USE Vasya_list_Shadiev_Abduvokhidov

BEGIN TRY
	INSERT INTO Birthday VALUES('99/99/9999')
	PRINT 'Данные успешно добавлены!'
END TRY
BEGIN CATCH
	PRINT 'Ошибка ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH

DECLARE @countPeople INT, @date DATE = '29/11/2024';
SELECT @countPeople = COUNT(WorkStartDate) FROM Salaries WHERE WorkStartDate = @date

IF @countPeople > 0
	PRINT CONVERT(VARCHAR, @date) + ' на работу устроилось ' + CONVERT(VARCHAR, @countPeople) + ' человек(а)'
ELSE PRINT CONVERT(VARCHAR, @date) + ' никто не устроивался на работу'

IF EXISTS(SELECT * FROM VasyaList AS vs	JOIN Salaries s ON s.VasyaListId = vs.Id JOIN Proffesion p ON p.Id = s.ProffesionId WHERE vs.Gender = 'Ж' AND p.Title = 'Программист')
	SELECT vl.FirstName, vl.LastName, vl.Gender, s.Amount FROM VasyaList AS vl
	JOIN Salaries s ON s.VasyaListId = vl.Id
	JOIN Proffesion p ON p.Id = s.ProffesionId
	WHERE vl.Gender = 'Ж' AND p.Title = 'Программист'
ELSE SELECT 'Ничего не найдено' AS Result

IF EXISTS(	SELECT vl.FirstName, vl.LastName, s.Amount FROM VasyaList AS vl JOIN Salaries s ON s.VasyaListId = vl.Id WHERE s.Amount > 100000)
	SELECT vl.FirstName, vl.LastName, s.Amount FROM VasyaList AS vl
	JOIN Salaries s ON s.VasyaListId = vl.Id
	WHERE s.Amount > 100000
ELSE SELECT 'Ничего не найдено' AS Result

DECLARE @number INT = 0, @power INT = 0, @result INT = 1, @counter INT = 0;

IF @power < 0 OR (@power = 0 AND @number = 0)
BEGIN
	PRINT 'Неккоректные данные'
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
	@number AS Число,
	@power AS Степень,
	@result AS Итог

USE PaidPolyclinic_Shadiev_Abduvohidov_47

--Подсчет общего числа пациентов через переменную
DECLARE @TotalPatients INT;
SELECT @TotalPatients = COUNT(*) FROM Patient;
PRINT 'Общее количество пациентов: ' + CAST(@TotalPatients AS NVARCHAR);
--Ожидаемый результат: Вывод общего числа пациентов в базе

--Проверка наличия диагноза «Мигрень»
IF EXISTS (SELECT * FROM Appeal WHERE Diagnos = 'Мигрень')
    PRINT 'Найдены пациенты с диагнозом "Мигрень"';
ELSE
    PRINT 'Пациентов с диагнозом "Мигрень" нет';
--Ожидаемый результат: Сообщение о наличии/отсутствии записей

--Классификация обращений по дате
SELECT 
    p.LastName AS Фамилия,
    p.Name AS Имя,
    a.Diagnos AS Диагноз,
    CASE 
        WHEN a.Date > '2023-09-01' THEN 'Новое обращение'
        ELSE 'Ранее зарегистрированное'
    END AS Статус
FROM Appeal a
JOIN Patient p ON a.PatientId = p.Id;
--Ожидаемый результат: Классификация обращений по дате

--Обработка ошибки при вставке отрицательной стоимости услуги.
BEGIN TRY
    INSERT INTO ServiceType (Name, Cost) 
    VALUES ('Консультация', -500); -- Нарушение CHECK-ограничения
END TRY
BEGIN CATCH
    PRINT 'Ошибка: ' + ERROR_MESSAGE();
END CATCH;
-- Ожидаемый результат: Сообщение об ошибке нарушения ограничения