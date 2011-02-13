USE BalloonShop

GO

CREATE TABLE ShippingRegion(
	ShippingRegionID INT IDENTITY(1,1) NOT NULL,
	ShippingRegion NVARCHAR(100) NULL,
 CONSTRAINT PK_ShippingRegion_1 PRIMARY KEY CLUSTERED (ShippingRegionID ASC)
)

GO


TRUNCATE TABLE ShippingRegion
GO

SET IDENTITY_INSERT ShippingRegion ON
GO

insert into ShippingRegion(ShippingRegionID, ShippingRegion)
values (1, '�����')


insert into ShippingRegion(ShippingRegionID, ShippingRegion)
values(2, '�������')


insert into ShippingRegion(ShippingRegionID, ShippingRegion)
values(3, '����� ������')


SET IDENTITY_INSERT ShippingRegion OFF
GO

select * from ShippingRegion