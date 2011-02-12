USE BalloonShop
GO

TRUNCATE TABLE Category
GO

SET IDENTITY_INSERT Category ON
GO

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (1, 1, 'Графика', 'Картини от категория графика')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (2, 1, 'Живопис', 'Картини от категория живопис')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (3, 1, 'Скулптура', 'Скулптури')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (4, 1, 'Приложни изкуства', 'Приложни изкуства - дърворезба, текстил, керамика')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (5, 2, 'Графика', 'Картини от категория графика')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (6, 2, 'Живопис', 'Картини от категория живопис')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (7, 2, 'Скулптура', 'Скулптура')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (8, 2, 'Приложни изкуства', 'Приложни изкуства - дърворезба, текстил, керамика')

GO

SET IDENTITY_INSERT Category OFF
GO