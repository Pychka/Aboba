CREATE DATABASE practic3_Shadiev_Abduvokhidov
GO
USE practic3_Shadiev_Abduvokhidov

CREATE TABLE Products
(
	Id INT IDENTITY,
	ProductName NVARCHAR(30) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	ProductCount INT DEFAULT 0,
	Price MONEY NOT NULL
);

INSERT Products VALUES('iPhone', 'Apple', 5 , 52000)

USE lecture_Primer_Shadiev_Abduvokhidov;

CREATE TABLE Easy_Drinks
(
	Drink_Name NVARCHAR(50) NOT NULL,
	Main NVARCHAR(50) NOT NULL,
	Amount DECIMAL(5,2) NOT NULL,
	[Second] NVARCHAR(50) NOT NULL,
	Amount2 DECIMAL(5,2) NOT NULL,
	Directions NVARCHAR(200) NOT NULL,
);

INSERT INTO Doughnut_list
VALUES
('��� 1','��� 1'),
('��� 2','��� 2'),
('��� 3','��� 3'),
('��� 4','��� 4'),
('��� 5','��� 5');

INSERT INTO Jelly_Doughnuts
VALUES
('�������1','11:11','11.09.2001',1,'�������1'),
('�������2','11:11','11.09.2001',2,'�������2'),
('�������3','11:11','11.09.2001',3,'�������3'),
('�������4','11:11','11.09.2001',4,'�������4'),
('�������5','11:11','11.09.2001',5,'�������5');

INSERT INTO Vasya_list
VALUES
('���1','�������1','�����1','11.09.2001','���������1','�������1','������1','�������1','seeking1'),
('���2','�������2','�����2','11.09.2001','���������2','�������2','������2','�������2','seeking2'),
('���3','�������3','�����3','11.09.2001','���������3','�������3','������3','�������3','seeking3'),
('���4','�������4','�����4','11.09.2001','���������4','�������4','������4','�������4','seeking4'),
('���5','�������5','�����5','11.09.2001','���������5','�������5','������5','�������5','seeking5');

INSERT INTO Easy_Drinks
VALUES
('��������1',',main1',1.1,'second1',1.1,'directions1'),
('��������2',',main2',2.2,'second2',2.2,'directions2'),
('��������3',',main3',3.3,'second3',3.3,'directions3'),
('��������4',',main4',4.4,'second4',4.4,'directions4'),
('��������5',',main5',5.5,'second5',5.5,'directions5');

USE PaidPolyclinic_Shadiev_Abduvohidov_47;

INSERT INTO Patient
VALUES
('���1','�������1','��������1','11.09.2001'),
('���2','�������2','��������2','11.09.2001'),
('���3','�������3','��������3','11.09.2001'),
('���4','�������4','��������4','11.09.2001'),
('���5','�������5','��������5','11.09.2001');

INSERT INTO Doctor
VALUES
('���1','�������1','��������1','�������������1','������������1'),
('���2','�������2','��������2','�������������2','������������2'),
('���3','�������3','��������3','�������������3','������������3'),
('���4','�������4','��������4','�������������4','������������4'),
('���5','�������5','��������5','�������������5','������������5');

INSERT INTO Treatment
VALUES
(1000),
(2000),
(3000),
(4000),
(5000);

INSERT INTO Appeal
VALUES
(1,1,1,'Diagnos1',1000,'11.09.2001'),
(2,2,2,'Diagnos2',2000,'11.09.2001'),
(3,3,3,'Diagnos3',3000,'11.09.2001'),
(4,4,4,'Diagnos4',4000,'11.09.2001'),
(5,5,5,'Diagnos5',5000,'11.09.2001');