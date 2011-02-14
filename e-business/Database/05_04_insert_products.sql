USE Gallery
GO

TRUNCATE TABLE Author
GO

SET IDENTITY_INSERT Author ON
GO

INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (1, 'Владимир', 'Димитров', 'Поппетров', 'Майстора')
GO


INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (2, 'Ян', 'Вацлав', 'Мърквичка', 'Мърквичка')
GO

INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (3, 'Димитър', 'Христов', 'Чорбаджийски', 'Чудомир')
GO


INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (4, 'Иван', 'Христов', 'Георгиев', 'Рембранда')
GO

INSERT INTO Author (AuthorID, Name, Surname, Family, Pseudonim)
VALUES (5, 'Румен', 'Денев', 'Скорчев', 'Скорчев')
GO

SET IDENTITY_INSERT Author OFF
GO

TRUNCATE TABLE Product
GO

SET IDENTITY_INSERT Product ON
GO

--живопис

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (1, 1, 'Портрет', '64 х 75 см', 8201.9900, 'portret_small.jpg', 'portret.jpg', 'маслени бои', NULL, 0, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (2, 1, 'Майка ми', 'платно,28 х 40 см. Творба от ранния период в творчеството на Майстора. Той обича да рисува свои близки и хората, които изпълваха неговият свят в кюстендилското село Шишковци. “Майка ми” е една от най–хубавите творби на Майстора, пресъздаваща образа на майка му. Тя е представена в момент на вглъбено майчинско преживяване. В очите и е отразен някакъв душевен трепет или смут. Произведението излиза извън рамките на личното претворяване и се извисява до художествено обобщение на вековната тема за майката. За разлика от по–късните портрети на Майстора, тук образът е проектиран върху тъмен, почти статичен фон, който дава възможност вниманието да се концентрира единствено върху лицето, като огледало на вътрешния свят на портретуваната.', 8021.9900, 'mother_small.jpg', 'mother.jpg', 'маслени бои', 1920, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (3, 1, 'Мома на фон ябълки', '145 х 90 см', 8012.9900, 'apples_small.jpg', 'apples.jpg', 'маслени бои', NULL, 0, 0)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (4, 2, 'Към пазара', 'платно,72 х 110 см. Творба, която изобразява обичаните от художника битови сцени от живота на българските селяни след Освобождението. Зимният пейзаж носи отпечатъка на романтичен битовизъм, характерен за творчеството на Мърквичка.Това се подсилва от нанасяните върху живописния слой малки бели петна на падащия сняг. Образът и фигурата на селянката са апликирани върху снежния фон с реалистична правдивост и точно следване на детайлите.', 12102.9900, 'to_the_market_small.jpg', 'to_the_market.jpg', 'маслени бои', 1891, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (5, 3, 'Клюкарка', '', 12120.9900, 'kliukarka_small.jpg', 'kliukarka.jpg', 'акварел', NULL, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (6, 3, 'Местен', '', 12120.9900, 'local_small.jpg', 'local.jpg', 'акварел', NULL, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (7, 3, 'Нашенец с лула', '', 12120.9900, 'local_with_pipe_small.jpg', 'local_with_pipe.jpg', 'акварел', NULL, 1, 1)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (8, 3, 'Приятели', '', 12120.9900, 'friends_small.jpg', 'friends.jpg', 'акварел', NULL, 1, 1)
GO


--графика

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (9, 2, 'Очакване', 'На уникална рисунка на Иван Мърквичка е попаднал експертът Камен Велков. Тя е открита случайно сред купища вехтории и му е била предоставена за експертиза. За свое удивление на листа тънък картон с размери 47 на 45 см той видял една изключителна творба, подписана от известния български художник от чешки произход и датирана от 1906 г', 18012.9900, 'expectation_small.jpg', 'expectation.jpg', 'Сангин', 1906, 1, 1)
GO


INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (10, 4, 'Копривщица', 'суха игла/хартия, 33/23 см, подписана', 820.9900, 'koprivshtica_small.jpg', 'koptivshtica.jpg', 'суха игла', NULL, 0, 0)
GO


INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (11, 4, 'Етюд', 'молив/хартия, 68/49 см, подписана', 820.9900, 'etiud_small.jpg', 'etiud.jpg', 'молив', NULL, 0, 0)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (12, 5, 'Жажда за полет', '', 710.9900, 'flight_small.jpg', 'flight.jpg', 'офорт/акватинта', NULL, 1, 0)
GO

INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (13, 5, 'Червеният кон', '', 720.9900, 'red_horse_small.jpg', 'red_horse.jpg', 'офорт/акватинта', NULL, 1, 0)
GO


INSERT INTO Product(ProductID, AuthorID, Name, Description, Price, Thumbnail, Image, Technique, Year, PromoFront, PromoDept )		
VALUES (14, 5, 'Алегория на деня и нощта', '', 720.9900, 'day_night_small.jpg', 'day_night.jpg', 'офорт/акватинта', NULL, 1, 0)
GO

--скулптура

--приложни изкуства



SET IDENTITY_INSERT Product OFF
GO

