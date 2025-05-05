CREATE DATABASE Sales_Shadiev_Abduvokhidov_Pr1;
GO

USE Sales_Shadiev_Abduvokhidov_Pr1;

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY NOT NULL,
	CustomerName NVARCHAR(40) NOT NULL,
	YTDOrders INT NOT NULL,
	YTDSales INT NOT NULL,
);

CREATE TABLE Orders(
	CustomerID INT NOT NULL,
	OrderID INT PRIMARY KEY NOT NULL,
	OrderDate DATETIME NOT NULL,
	FilledDate DATETIME,
	[Status] CHAR(1) NOT NULL,
	Amount INT NOT NULL,
);
GO
INSERT INTO Customer (CustomerID, CustomerName, YTDOrders, YTDSales)
VALUES
(1, '�������� 1', 1, 200),
(2, '�������� 2', 2, 200),
(3, '�������� 3', 3, 200),
(4, '�������� 4', 4, 200),
(5, '�������� 5', 5, 200),
(6, '�������� 6', 6, 200),
(7, '�������� 7', 7, 200),
(8, '�������� 8', 8, 200),
(9, '�������� 9', 9, 200),
(10, '�������� 10', 10, 200);

INSERT INTO Orders (CustomerID, OrderID, OrderDate, FilledDate, [Status], Amount)
VALUES
(1, 1, '11/09/2001', NULL, '�', 1),
(2, 2, '11/09/2001', NULL, '�', 1),
(3, 3, '11/09/2001', NULL, '�', 1),
(4, 4, '11/09/2001', NULL, '�', 1),
(5, 5, '11/09/2001', NULL, '�', 1),
(6, 6, '11/09/2001', NULL, '�', 1),
(7, 7, '11/09/2001', NULL, '�', 1),
(8, 8, '11/09/2001', NULL, '�', 1),
(9, 9, '11/09/2001', NULL, '�', 1),
(10, 10, '11/09/2001', NULL, '�', 1);

CREATE DATABASE lecture_Primer_Shadiev_Abduvokhidov;
GO

USE lecture_Primer_Shadiev_Abduvokhidov;

CREATE TABLE Doughnut_list(
	doughnut_name VARCHAR(10),
	doughnut_type VARCHAR(6)
);

CREATE TABLE Jelly_Doughnuts(
	Shop VARCHAR(50),
	[Time] Time,
	[Date] DATE,
	Rating INT,
	Comments NVARCHAR(100)
);

CREATE TABLE Vasya_list(
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	email VARCHAR(50),
	birthday DATE,
	profession VARCHAR(50),
	[location] VARCHAR(50),
	[status] VARCHAR(50),
	interests VARCHAR(100),
	seeking VARCHAR(50),
);
GO
INSERT INTO Doughnut_list(doughnut_name, doughnut_type)
VALUES
('������1','1'),
('������2','2'),
('������3','3'),
('������4','4'),
('������5','5'),
('������6','6'),
('������7','7'),
('������8','8'),
('������9','9'),
('������10','10');

INSERT INTO Jelly_Doughnuts (Shop, [Time], [Date], Rating, Comments)
VALUES
('��� ��������1','8:46','11/09/2001', 1 ,'������1'),
('��� ��������2','8:46','11/09/2001', 2 ,'������2'),
('��� ��������3','8:46','11/09/2001', 3 ,'������3'),
('��� ��������4','8:46','11/09/2001', 4 ,'������4'),
('��� ��������5','8:46','11/09/2001', 5 ,'������5'),
('��� ��������6','8:46','11/09/2001', 6 ,'������6'),
('��� ��������7','8:46','11/09/2001', 7 ,'������7'),
('��� ��������8','8:46','11/09/2001', 8 ,'������8'),
('��� ��������9','8:46','11/09/2001', 9 ,'������9'),
('��� ��������10','8:46','11/09/2001', 10 ,'������10');

INSERT INTO Vasya_list (last_name, first_name, email, birthday, profession, [location], [status], interests, seeking)
VALUES
('���1','�������1','�����1@�����.�����','11/09/2001','���������1','�������1','������1','�������1','��������1'),
('���2','�������2','�����2@�����.�����','11/09/2001','���������2','�������2','������2','�������2','��������2'),
('���3','�������3','�����3@�����.�����','11/09/2001','���������3','�������3','������3','�������3','��������3'),
('���4','�������4','�����4@�����.�����','11/09/2001','���������4','�������4','������4','�������4','��������4'),
('���5','�������5','�����5@�����.�����','11/09/2001','���������5','�������5','������5','�������5','��������5'),
('���6','�������6','�����6@�����.�����','11/09/2001','���������6','�������6','������6','�������6','��������6'),
('���7','�������7','�����7@�����.�����','11/09/2001','���������7','�������7','������7','�������7','��������7'),
('���8','�������8','�����8@�����.�����','11/09/2001','���������8','�������8','������8','�������8','��������8'),
('���9','�������9','�����9@�����.�����','11/09/2001','���������9','�������9','������9','�������9','��������9'),
('���10','�������10','�����10@�����.�����','11/09/2001','���������10','�������10','������10','�������10','��������10');

CREATE DATABASE PaidPolyclinic_Shadiev_Abduvohidov_47;
GO
USE PaidPolyclinic_Shadiev_Abduvohidov_47;

CREATE TABLE Patient
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Patronymic NVARCHAR(50),
	Birthday DATE NOT NULL
);

CREATE TABLE Doctor
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Patronymic NVARCHAR(50),
	Specialty NVARCHAR(50) NOT NULL,
	Qualification NVARCHAR(50) NOT NULL,
	UNIQUE (Specialty, Qualification) 
);

CREATE TABLE Treatment
(
	Id INT PRIMARY KEY IDENTITY,
	Cost MONEY NOT NULL
);

CREATE TABLE Appeal
(
	Id INT PRIMARY KEY IDENTITY,
	PatientId INT FOREIGN KEY REFERENCES Patient(Id),
	DoctorId INT FOREIGN KEY REFERENCES Doctor(Id),
	TreatmentId INT FOREIGN KEY REFERENCES Treatment(Id),
	Diagnos NVARCHAR(400),
	Cost MONEY NOT NULL,
	[Date] DATE NOT NULL
);