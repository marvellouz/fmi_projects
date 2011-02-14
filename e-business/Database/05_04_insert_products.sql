USE Gallery
GO

TRUNCATE TABLE Author
GO

SET IDENTITY_INSERT Author ON
GO

INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (1, '��������', '��������', '���������', '��������')
GO


INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (2, '��', '������', '���������', '���������')
GO

INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (3, '�������', '�������', '������������', '�������')
GO


INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (4, '����', '�������', '��������', '���������')
GO

INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (5, '�����', '�����', '�������', '�������')
GO

SET IDENTITY_INSERT Author OFF
GO

TRUNCATE TABLE Product
GO

SET IDENTITY_INSERT Product ON
GO

--�������

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (1, 1, '�������', '64 � 75 ��', 8201.9900, 'portret_small.jpg', 'portret.jpg', '������� ���', NULL, 0, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (2, 1, '����� ��', '������,28 � 40 ��. ������ �� ������ ������ � ������������ �� ��������. ��� ����� �� ������ ���� ������ � ������, ����� ��������� �������� ���� � �������������� ���� ��������. ������ �� � ���� �� ����������� ������ �� ��������, ������������ ������ �� ����� ��. �� � ����������� � ������ �� �������� ��������� �����������. � ����� � � ������� ������� ������� ������ ��� ����. �������������� ������ ����� ������� �� ������� ������������ � �� �������� �� ������������ ��������� �� ��������� ���� �� �������. �� ������� �� ��������� �������� �� ��������, ��� ������� � ���������� ����� �����, ����� �������� ���, ����� ���� ���������� ���������� �� �� ����������� ���������� ����� ������, ���� �������� �� ��������� ���� �� ��������������.', 8021.9900, 'mother_small.jpg', 'mother.jpg', '������� ���', 1920, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (3, 1, '���� �� ��� ������', '145 � 90 ��', 8012.9900, 'apples_small.jpg', 'apples.jpg', '������� ���', NULL, 0, 0)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (4, 2, '��� ������', '������,72 � 110 ��. ������, ����� ���������� ��������� �� ��������� ������ ����� �� ������ �� ����������� ������ ���� ��������������. ������� ������ ���� ���������� �� ���������� ���������, ���������� �� ������������ �� ���������.���� �� �������� �� ���������� ����� ���������� ���� ����� ���� ����� �� ������� ����. ������� � �������� �� ��������� �� ���������� ����� ������� ��� � ����������� ���������� � ����� �������� �� ���������.', 12102.9900, 'to_the_market_small.jpg', 'to_the_market.jpg', '������� ���', 1891, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (5, 3, '��������', '', 12120.9900, 'kliukarka_small.jpg', 'kliukarka.jpg', '�������', NULL, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (6, 3, '������', '', 12120.9900, 'local_small.jpg', 'local.jpg', '�������', NULL, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (7, 3, '������� � ����', '', 12120.9900, 'local_with_pipe_small.jpg', 'local_with_pipe.jpg', '�������', NULL, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (8, 3, '��������', '', 12120.9900, 'friends_small.jpg', 'friends.jpg', '�������', NULL, 1, 1)
GO


--�������

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (9, 2, '��������', '�� �������� ������� �� ���� ��������� � �������� ��������� ����� ������. �� � ������� �������� ���� ������ �������� � �� � ���� ������������ �� ����������. �� ���� ��������� �� ����� ����� ������ � ������� 47 �� 45 �� ��� ����� ���� ������������ ������, ��������� �� ��������� ��������� �������� �� ����� �������� � �������� �� 1906 �', 18012.9900, 'expectation_small.jpg', 'expectation.jpg', '������', 1906, 1, 1)
GO


INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (10, 4, '����������', '���� ����/������, 33/23 ��, ���������', 820.9900, 'koprivshtica_small.jpg', 'koptivshtica.jpg', '���� ����', NULL, 0, 0)
GO


INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (11, 4, '����', '�����/������, 68/49 ��, ���������', 820.9900, 'etiud_small.jpg', 'etiud.jpg', '�����', NULL, 0, 0)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (12, 5, '����� �� �����', '', 710.9900, 'flight_small.jpg', 'flight.jpg', '�����/���������', NULL, 1, 0)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (13, 5, '��������� ���', '', 720.9900, 'red_horse_small.jpg', 'red_horse.jpg', '�����/���������', NULL, 1, 0)
GO


INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (14, 5, '�������� �� ���� � �����', '', 720.9900, 'day_night_small.jpg', 'day_night.jpg', '�����/���������', NULL, 1, 0)
GO

--���������

--�������� ��������



SET IDENTITY_INSERT Product OFF
GO

