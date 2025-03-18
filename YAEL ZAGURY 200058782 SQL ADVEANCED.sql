--1

WITH YearlyIncome AS (
SELECT
	 YEAR (O.OrderDate) AS Year
	,SUM (IL.Quantity*IL.UnitPrice) AS IncomPerYear
FROM Sales.Orders O JOIN Sales.Invoices I
  ON O.OrderID = I.OrderID
JOIN Sales.InvoiceLines IL
  ON I.InvoiceID = IL.InvoiceID
GROUP BY YEAR (O.OrderDate)),
CountDistinctMonth AS (
SELECT DISTINCT
	 YEAR (O.OrderDate) AS Year	
	,COUNT (DISTINCT MONTH(O.OrderDate)) AS NumberOfDistinctMonth
FROM Sales.Orders O
GROUP BY YEAR (O.OrderDate)),
LinearIncome AS (
SELECT
	 Y.Year
	,Y.IncomPerYear
	,C.NumberOfDistinctMonth
	,Y.IncomPerYear / C.NumberOfDistinctMonth * 12 AS YearlyLinearIncome
FROM YearlyIncome Y JOIN CountDistinctMonth C
ON Y.Year = C.Year ),
LastYear AS (
SELECT 
	 L.Year
	,LAG (L.YearlyLinearIncome) OVER (ORDER BY  L.Year ) AS LastY
FROM LinearIncome L )
SELECT 
	 LY.Year
	,FORMAT (LI.IncomPerYear , '#,#.00') AS IncomPerYear
	,LI.NumberOfDistinctMonth
	,FORMAT (LI.YearlyLinearIncome , '#,#.00') AS YearlyLinearIncome
	,FORMAT ((LI.YearlyLinearIncome - LY.LastY) / LY.LastY * 100 , '0.##')  AS GrowthRate
FROM LastYear LY JOIN LinearIncome  LI
ON LY.Year = LI.Year

GO

--2

WITH CustomerPerQtr AS (
SELECT DISTINCT
	 YEAR (O.OrderDate) AS Year
	,DATEPART (QUARTER , O.OrderDate) AS TheQuarter
	,C.CustomerName
	,SUM (IL.Quantity * IL.UnitPrice) OVER (PARTITION BY C.CustomerID,YEAR (O.OrderDate),DATEPART (QUARTER , O.OrderDate) ) AS IncomePerYear
FROM Sales.InvoiceS I JOIN Sales.Customers C
  ON I.CustomerID = C.CustomerID
JOIN Sales.InvoiceLines IL 
  ON IL.InvoiceID = I.InvoiceID
JOIN Sales.Orders O 
  ON O.OrderID = I.OrderID ),
Rn AS (
SELECT *
	,ROW_NUMBER() OVER (PARTITION BY C.Year , C.TheQuarter ORDER BY IncomePerYear DESC) AS DRN
FROM CustomerPerQtr C )
SELECT *
FROM Rn
WHERE Rn.DRN <=5
ORDER BY Rn.Year , Rn.TheQuarter

GO

--3

WITH ProductSales AS (
SELECT DISTINCT
     IL.StockItemID
	,S.StockItemName
	,SUM (IL.Quantity * IL.UnitPrice) OVER (PARTITION BY IL.StockItemID ) AS SalesPerProduct
FROM Sales.InvoiceLines IL JOIN Warehouse.StockItems S
  ON IL.StockItemID = S.StockItemID )
SELECT TOP 10 *
FROM ProductSales PS
ORDER BY PS.SalesPerProduct DESC

GO

--4

WITH ItemPrice AS (
SELECT
	 S.StockItemID
	,S.StockItemName
	,S.UnitPrice
	,S.RecommendedRetailPrice
	,S.RecommendedRetailPrice - S.UnitPrice AS Profit
FROM Warehouse.StockItems S )
SELECT
	 ROW_NUMBER() OVER (ORDER BY I.Profit DESC) RN
	,*
	,DENSE_RANK() OVER (ORDER BY I.Profit DESC) DRNK
FROM ItemPrice I

GO

--5

WITH Sup AS (
SELECT
	 CONCAT ( S.SupplierID , ' - ' , S.SupplierName) SupplierDetails
	,(SELECT 
			CONCAT(' /, ' , SI.StockItemID , ' ' , SI.StockItemName) AS ProductDetails
		FROM Warehouse.StockItems SI
		WHERE S.SupplierID = SI.SupplierID
		FOR XML PATH('')) AS ProductDetails
FROM Purchasing.Suppliers S )
SELECT 
	 S.SupplierDetails
	,STUFF(REPLACE (REPLACE (S.ProductDetails , '</ProductDetails>' , '') , '<ProductDetails>' , '') , 1 , 3 ,'') AS ProductDetails
FROM Sup S
WHERE S.ProductDetails IS NOT NULL

GO

--6

WITH TotalPerCustomer AS(
SELECT DISTINCT
	 C.CustomerID
	,Ct.CityName
	,Co.CountryName
	,Co.Continent
	,Co.Region
	,SUM (Il.ExtendedPrice) OVER (PARTITION BY C.CustomerID) AS TotalExtendedPrice
FROM Sales.Customers C JOIN Application.Cities Ct
  ON C.DeliveryCityID = Ct.CityID
JOIN Application.StateProvinces Sp
  ON SP.StateProvinceID = Ct.StateProvinceID
JOIN Application.Countries Co
  ON Co.CountryID = SP.CountryID
JOIN Sales.Invoices I
  ON I.CustomerID = C.CustomerID
JOIN Sales.InvoiceLines Il
  ON Il.InvoiceID = I.InvoiceID )
SELECT TOP (5) 
	 T.CustomerID , T.CityName , T.CountryName , T.Continent , T.Region
	,FORMAT (T.TotalExtendedPrice , '#,#.00') AS TotalExtendedPrice
FROM TotalPerCustomer T
ORDER BY T.TotalExtendedPrice DESC

GO

--7

WITH TotalPerMonth AS(
SELECT DISTINCT
	 YEAR (O.OrderDate) AS OrderYear
 	,CAST (MONTH (O.OrderDate) AS VARCHAR) AS OrderMonth
	,SUM (Il.Quantity * Il.UnitPrice) OVER (PARTITION BY YEAR (O.OrderDate) , MONTH (O.OrderDate)) AS MonthlyTotal
	,SUM (Il.Quantity * Il.UnitPrice) OVER (PARTITION BY YEAR (O.OrderDate) ORDER BY MONTH (O.OrderDate )) AS CumulativeTotal
FROM Sales.Invoices I JOIN Sales.InvoiceLines Il
  ON I.InvoiceID = Il.InvoiceID
JOIN Sales.Orders O 
  ON O.OrderID = I.OrderID ),
GrandTotal AS (
SELECT *
	,ROW_NUMBER() OVER (PARTITION BY Tp.OrderYear ORDER BY Tp.CumulativeTotal) RN
FROM TotalPerMonth Tp
UNION 
SELECT
	 T.OrderYear
	,'Grand Total'
	,SUM (T.MonthlyTotal) AS MonthlyTotal
	,SUM (T.MonthlyTotal) AS CumulativeTotal
	,13
FROM TotalPerMonth T
GROUP BY T.OrderYear )
SELECT
	 G.OrderYear
	,G.OrderMonth
	,FORMAT (G.MonthlyTotal ,'#,#.00') AS MonthlyTotal
	,FORMAT (G.CumulativeTotal ,'#,#.00') AS CumulativeTotal
FROM GrandTotal G
ORDER BY G.OrderYear , G.RN

GO

--8

DECLARE @years VARCHAR(50),
		@query NVARCHAR(MAX)

SET @years =(SELECT DISTINCT
			 STUFF ((SELECT
			 			',' + QUOTENAME( YEAR(O.OrderDate))
			 		 FROM Sales.Orders O
			 		 GROUP BY YEAR(O.OrderDate)
			 		 ORDER BY YEAR(O.OrderDate)
			 		 FOR XML PATH('')),1,1,'')
			 FROM Sales.Orders O )

SET @query = ('
WITH OrdersPerMonth
AS(
SELECT 
	 YEAR (O.OrderDate) AS OrderYear
	,MONTH (O.OrderDate) AS OrderMonth
	,O.OrderID
FROM Sales.Orders O)
SELECT *
FROM OrdersPerMonth O
PIVOT (COUNT (O.OrderID) FOR O.OrderYear IN (' + @years+ ')) AS PVT
ORDER BY PVT.OrderMonth')

EXECUTE (@query)

GO


--9


WITH Od AS (
SELECT
	 C.CustomerID
	,C.CustomerName
	,O.OrderDate
	,LAG (O.OrderDate) OVER (PARTITION BY C.CustomerID ORDER BY O.OrderDate) AS PreviousOrderDate
	,DATEDIFF (DAY , LAG (O.OrderDate) OVER (PARTITION BY C.CustomerID ORDER BY O.OrderDate) , O.OrderDate ) DaysBetweenOrders
	,ROW_NUMBER() OVER (PARTITION BY C.CustomerID ORDER BY O.OrderDate DESC) RN
FROM Sales.Customers C
JOIN Sales.Orders O
  ON C.CustomerID = O.CustomerID ),
LastOrder AS (
SELECT
	 Od.CustomerID
	,DATEDIFF (DAY , Od.OrderDate , '2016-05-31') AS DaysSinceLastOrder
FROM Od	
WHERE Od.RN = 1 ),
AvgDaysBetweenOrders AS (
SELECT 
	 Od.CustomerID , Od.CustomerName , Od.OrderDate , Od.PreviousOrderDate
	,L.DaysSinceLastOrder
	,AVG (DATEDIFF (DAY , Od.PreviousOrderDate , Od.OrderDate)) OVER (PARTITION BY Od.CustomerID) AvgDaysBetweenOrders
FROM Od LEFT JOIN LastOrder L
  ON L.CustomerID = Od.CustomerID )
SELECT *
	,IIF(A.DaysSinceLastOrder > A.AvgDaysBetweenOrders*2 , 'Potential Chum' ,'Active') AS CustomerStatus
FROM AvgDaysBetweenOrders A

GO

--10

WITH CusromersNames AS (
SELECT DISTINCT
 	 C.CustomerCategoryID
	,CASE WHEN C.CustomerName LIKE 'Wingtip%'
			THEN 'Wingtip'
		  WHEN C.CustomerName LIKE 'Tailspin%'
			THEN 'Tailspin'
	 ELSE C.CustomerName
	 END AS CustomerName
FROM Sales.Customers c ),
CountCustomers AS (
SELECT
	 CC.CustomerCategoryName
	,COUNT (C.CustomerName) CustomersCOUNT
FROM Sales.CustomerCategories CC
JOIN CusromersNames C
  ON C.CustomerCategoryID = CC.CustomerCategoryID
GROUP BY CC.CustomerCategoryName )
SELECT  *
	,(SELECT COUNT(*) FROM CusromersNames) AS TotalCustCount
	,CONCAT (FORMAT (C.CustomersCOUNT * 100.00 / (SELECT COUNT(*) FROM CusromersNames) , '0.00'),'%') AS DistributionFactor
 FROM CountCustomers C
 ORDER BY C.CustomerCategoryName

 GO












