USE Gallery

GO

-- Adding the three new fields: customer_id, auth_code and reference.
ALTER TABLE Orders ADD CustomerID UNIQUEIDENTIFIER;
ALTER TABLE Orders ADD Status     INT DEFAULT 0;
ALTER TABLE Orders ADD AuthCode   VARCHAR(50);
ALTER TABLE Orders ADD Reference  VARCHAR(50);

GO

CREATE PROCEDURE CreateCustomerOrder 
(@CartID char(36),
 @CustomerID uniqueidentifier)
AS
/* Insert a new record into Orders */
DECLARE @OrderID int
INSERT INTO Orders (CustomerID) VALUES (@CustomerID)
/* Save the new Order ID */
SET @OrderID = @@IDENTITY
/* Add the order details to OrderDetail */
INSERT INTO OrderDetail 
     (OrderID, ProductID, ProductName, Quantity, UnitCost)
SELECT 
     @OrderID, Product.ProductID, Product.Name, 
     ShoppingCart.Quantity, Product.Price
FROM Product JOIN ShoppingCart
ON Product.ProductID = ShoppingCart.ProductID
WHERE ShoppingCart.CartID = @CartID
/* Clear the shopping cart */
DELETE FROM ShoppingCart
WHERE CartID = @CartID
/* Return the Order ID */
SELECT @OrderID

GO

CREATE PROCEDURE CommerceLibOrderGetInfo
(@OrderID int)
AS
SELECT OrderID, 
       DateCreated, 
       DateShipped, 
       Comments, 
       Status, 
       CustomerID, 
       AuthCode,
       Reference
FROM Orders
WHERE OrderID = @OrderID

GO

CREATE TABLE Tax (
  TaxID INT NOT NULL PRIMARY KEY,
  TaxType VARCHAR(100) NOT NULL,
  TaxPercentage FLOAT NOT NULL
) 


GO

INSERT INTO TAX (TaxID, TaxType, TaxPercentage) 
VALUES (1, 'Такса 8.5%', 8.5), 
       (2, 'Без такса', 0)

GO

CREATE TABLE Shipping (
  ShippingID INT NOT NULL PRIMARY KEY,
  ShippingType VARCHAR(100) NOT NULL,
  ShippingCost MONEY NOT NULL,
  ShippingRegionID INT
) 

GO

INSERT INTO Shipping (ShippingID, ShippingType, ShippingCost, ShippingRegionID) 
VALUES (1, 'Доставка на следващия ден (20 BGN)', 20, 2),
       (2, '3-4 дена (10 BGN)', 10, 2),
       (3, '7 дена (5 BGN)', 5, 2),
       (4, 'По въздух (7 дена, 25 BGN)', 25, 3),
       (5, 'По море (28 дена, 10 BGN)', 10, 3),
       (6, 'По въздух (10 дена, 35 BGN)', 35, 4),
       (7, 'По море (38 дена, 30 BGN)', 30, 4)

GO

ALTER TABLE Orders ADD TaxID INT;
ALTER TABLE Orders ADD ShippingID INT;

ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Tax 
FOREIGN KEY(TaxID) REFERENCES Tax (TaxID)

ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Shipping 
FOREIGN KEY(ShippingID) REFERENCES Shipping (ShippingID)

GO

ALTER PROCEDURE CommerceLibOrderGetInfo
(@OrderID int)
AS
SELECT OrderID, 
       DateCreated, 
       DateShipped, 
       Comments, 
       Status, 
       CustomerID, 
       AuthCode,
       Reference,
       Orders.ShippingID,
       ShippingType,
       ShippingCost,
       Orders.TaxID,
       TaxType,
       TaxPercentage
FROM Orders 
LEFT OUTER JOIN Tax ON Tax.TaxID = Orders.TaxID
LEFT OUTER JOIN Shipping ON Shipping.ShippingID = Orders.ShippingID
WHERE OrderID = @OrderID

GO

ALTER PROCEDURE CreateCustomerOrder 
(@CartID char(36),
 @CustomerID uniqueidentifier,
 @ShippingID int,
 @TaxID int)
AS
/* Insert a new record into Orders */
DECLARE @OrderID int
INSERT INTO Orders (CustomerID, ShippingID, TaxID) 
VALUES (@CustomerID, @ShippingID, @TaxID)
/* Save the new Order ID */
SET @OrderID = @@IDENTITY
/* Add the order details to OrderDetail */
INSERT INTO OrderDetail 
     (OrderID, ProductID, ProductName, Quantity, UnitCost)

SELECT 
     @OrderID, Product.ProductID, Product.Name, 
     ShoppingCart.Quantity, Product.Price
FROM Product JOIN ShoppingCart
ON Product.ProductID = ShoppingCart.ProductID
WHERE ShoppingCart.CartID = @CartID
/* Clear the shopping cart */
DELETE FROM ShoppingCart
WHERE CartID = @CartID
/* Return the Order ID */
SELECT @OrderID

GO

CREATE PROCEDURE CommerceLibShippingGetInfo
(@ShippingRegionID int)
AS
SELECT ShippingID,
       ShippingType,
       ShippingCost
FROM Shipping
WHERE ShippingRegionID = @ShippingRegionID
