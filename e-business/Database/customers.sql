DROP PROCEDURE CatalogGetProductReviews;
GO
-- Create CatalogGetProductReviews stored procedure
CREATE PROCEDURE CatalogGetProductReviews(@ProductID INT)
AS
SELECT u.UserName as CustomerName,
r.Review as ProductReview,
r.DateCreated as ReviewDate
FROM Review r
INNER JOIN aspnet_Users u ON u.UserID = r.CustomerID
WHERE r.ProductID = @ProductID
ORDER BY r.DateCreated DESC