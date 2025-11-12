IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Purchasing'))
BEGIN
	EXEC ('CREATE SCHEMA [Purchasing] AUTHORIZATION [dbo]')
END--- DimEmployee
CREATE TABLE [Purchasing].[DimEmployee](
 [EmployeeKey] [int] IDENTITY(1,1) Primary Key,
 [BusinessEntityID] [int] ,
 [JobTitle] [nvarchar](50) ,
 [FirstName] [nvarchar](50) ,
 [MiddleName] [nvarchar](50) ,
 [LastName] [nvarchar](50) ,
 BirthDate date,
 HireDate date,
 [Gender] [nvarchar](1) ,
 [SalariedFlag] [bit] ,
 [ActiveFlag] [bit] ,
 [StartDate] [datetime] ,
 [EndDate] [datetime]
)


--- DimInventory
CREATE TABLE [Purchasing].[DimInventory]([InventoryKey] [int] IDENTITY(1,1) Primary Key,
 [ProductID] [int] ,
 [LocationID] [smallint] ,
 [Shelf] [nvarchar](10) ,
 [Bin] [tinyint] ,
 [Quantity] [smallint] ,
 [Availability] [numeric](8, 2) ,
 [StartDate] [datetime] ,
 [EndDate] [datetime]
)
--- DimProduct
CREATE TABLE [Purchasing].[DimProduct](
 [ProductKey] [int] IDENTITY(1,1) Primary Key ,
 [ProductID] [int] ,
 [ProductName] [nvarchar](50) ,
 [ProductNumber] [nvarchar](25) ,
 [MakeFlag] [bit] ,
 [FinishedGoodsFlag] [bit] ,
 [SafetyStockLevel] [smallint] ,
 [ReorderPoint] [smallint] ,
 [ProductCategoryName] [nvarchar](50) ,
 [ProductSubCategoryName] [nvarchar](50) ,
 [StartDate] [datetime] , [EndDate] [datetime]
)
---DimShipMethod
CREATE TABLE [Purchasing].[DimShipMethod](
 [ShipMethodKey] [int] IDENTITY(1,1) Primary Key,
 [ShipMethodID] [int] ,
 [ShipMethodName] [nvarchar](50) ,
 [ShipBase] [money] ,
 [ShipRate] [money]
)
--- DimVendor
CREATE TABLE [Purchasing].[DimVendor](
 [VendorKey] [int] IDENTITY(1,1) Primary Key,
 [BusinessEntityID] [int] ,
 [VendorName] [nvarchar](50) ,
 [CreditRating] [tinyint] ,
 [PreferredVendorStatus] [bit] ,
 [ActiveFlag] [bit] ,
 [AverageLeadTime] [int] ,
 [StandardPrice] [money] ,
 [LastReceiptCost] [money] ,
 [StartDate] [datetime] ,
 [EndDate] [datetime] )
--- DimTime
CREATE TABLE Purchasing.DimTime (
    DateKey   DATETIME PRIMARY KEY NOT NULL,      -- Ngày đầy đủ
    Day         TINYINT,            -- Ngày trong tháng (1–31)
    Week        TINYINT,            -- Tuần trong năm (1–53)
    Month       TINYINT,			-- Tháng (1–12)
    DayName     NVARCHAR(20),
    MonthName   NVARCHAR(20),       -- Tên tháng (January,...)
    Quarter     TINYINT,            -- Quý (1–4)
    Year        INT,                -- Năm (2010–2015)
    -- Tên ngày trong tuần (Monday,...)
);
GO

-- Insert dữ liệu từ 2010-01-01 đến 2014-12-31
DECLARE @Date DATE = '2010-01-01';

WHILE @Date <= '2014-12-31'
BEGIN
    INSERT INTO Purchasing.DimTime (
        DateKey, Day, Week, Month, MonthName, Quarter, Year, DayName
    )
    VALUES (
        @Date,                                   -- DateKey
        DAY(@Date),                              -- Day
        DATEPART(WEEK, @Date),                   -- Week
        DATEPART(MONTH, @Date),                  -- Month
        DATENAME(MONTH, @Date),                  -- MonthName
        DATEPART(QUARTER, @Date),                -- Quarter
        DATEPART(YEAR, @Date),                   -- Year
        DATENAME(WEEKDAY, @Date)                 -- DayName
    );

    SET @Date = DATEADD(DAY, 1, @Date);
END;
GO

--- FactPurchaseOrders
CREATE TABLE [Purchasing].[FactPurchasingOrders](
 [PurchaseOrderID] [int],
 [PurchaseOrderDetailID] [int],
 [InventoryKey] [int] ,
 [EmployeeKey] [int] ,
 [ProductKey] [int] ,
 [ShipMethodKey] [int] ,
 [VendorKey] [int] ,
 [RevisionNumber] [tinyint] ,
 [Status] [tinyint] ,
 [OrderDate] [datetime] ,
 [ShipDate] [datetime] ,
 [Freight] [money],
 [OrderQty] [smallint] ,
 [UnitPrice] [money] ,
 [LineTotal] [money] ,
 [ReceivedQty] [numeric](8, 2) ,
 [RejectedQty] [numeric](8, 2) ,
 [StockedQty] [numeric](9, 2),
 FOREIGN KEY (InventoryKey) REFERENCES Pur_Department.Purchasing.DimInventory(InventoryKey),
 FOREIGN KEY (EmployeeKey) REFERENCES Pur_Department.Purchasing.DimEmployee(EmployeeKey),
 FOREIGN KEY (ProductKey) REFERENCES Pur_Department.Purchasing.DimProduct(ProductKey),
 FOREIGN KEY (ShipMethodKey) REFERENCES Pur_Department.Purchasing.DimShipMethod(ShipMethodKey),
 FOREIGN KEY (VendorKey) REFERENCES Pur_Department.Purchasing.DimVendor(VendorKey),
 FOREIGN KEY (OrderDate) REFERENCES Pur_Department.Purchasing.DimTime([DateKey]))

 -- Tạo bảng log ETL_Load_Log
 CREATE TABLE Purchasing.ETL_Load_Log (
    LoadID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(100),
    StartTime DATETIME,
    EndTime DATETIME,
    ETLUser NVARCHAR(100) NULL,
	Row_Count int,
	Status NVARCHAR(10),
	ErrorMessage NVARCHAR(100)
);