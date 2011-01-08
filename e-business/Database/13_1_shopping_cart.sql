USE BalloonShop

GO

CREATE TABLE ShoppingCart (
  CartID CHAR(36) NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL,
  Attributes NVARCHAR(1000) NULL,
  DateAdded SMALLDATETIME NOT NULL,
  CONSTRAINT PK_ShoppingCart PRIMARY KEY CLUSTERED (CartID ASC, ProductID ASC) 
) 

GO

ALTER TABLE dbo.ShoppingCart WITH CHECK 
ADD CONSTRAINT FK_ShoppingCart_Product FOREIGN KEY(ProductID)
REFERENCES Product(ProductID)


