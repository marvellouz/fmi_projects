USE Gallery

GO

---
--- PRODUCT 
---

GO

CREATE TABLE Author (
	AuthorID INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NULL,
	Family NVARCHAR(50) NOT NULL,
	Pseudonim NVARCHAR(50) NULL,
 CONSTRAINT PK_Author PRIMARY KEY CLUSTERED (AuthorID ASC)
)

CREATE TABLE Product(
	ProductID INT IDENTITY(1,1) NOT NULL,
	AuthorID INT NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(MAX) NOT NULL,
	Price MONEY NOT NULL,
	Thumbnail NVARCHAR(50) NULL,
	Image NVARCHAR(50) NULL,
	Technique NVARCHAR(50) NULL,
	Year INT NULL,
	PromoFront BIT NOT NULL,
	PromoDept BIT NOT NULL
 CONSTRAINT PK_Product PRIMARY KEY CLUSTERED (ProductID ASC)
) 
