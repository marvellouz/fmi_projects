USE BalloonShop
GO

TRUNCATE TABLE Category
GO

SET IDENTITY_INSERT Category ON
GO

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (1, 1, '�������', '������� �� ��������� �������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (2, 1, '�������', '������� �� ��������� �������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (3, 1, '���������', '���������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (4, 1, '�������� ��������', '�������� �������� - ����������, �������, ��������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (5, 2, '�������', '������� �� ��������� �������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (6, 2, '�������', '������� �� ��������� �������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (7, 2, '���������', '���������')

INSERT INTO Category (CategoryID, DepartmentID, Name, Description )		
VALUES (8, 2, '�������� ��������', '�������� �������� - ����������, �������, ��������')

GO

SET IDENTITY_INSERT Category OFF
GO