USE AdventureWorksDW2019;
GO
-- Q1: Active products with prices
SELECT ProductKey, EnglishProductName, Color, ListPrice, StandardCost
FROM dbo.DimProduct
WHERE EndDate IS NULL AND ListPrice > 0
ORDER BY ListPrice DESC;
--Q2: Product profit estimate
SELECT ProductKey, EnglishProductName, ListPrice, StandardCost,
       ListPrice - StandardCost AS EstimatedProfit
FROM dbo.DimProduct
WHERE ListPrice > 0 AND StandardCost > 0
ORDER BY EstimatedProfit DESC;
--Q3: Customer income bands
SELECT CustomerKey, FirstName, LastName, YearlyIncome,
       CASE
         WHEN YearlyIncome < 40000 THEN 'Low Income'
         WHEN YearlyIncome BETWEEN 40000 AND 79999 THEN 'Middle Income'
         ELSE 'High Income'
       END AS IncomeBand
FROM dbo.DimCustomer
ORDER BY YearlyIncome DESC;
--Q4: Sales by product
SELECT ProductKey,
       SUM(OrderQuantity) AS TotalQuantity,
       SUM(SalesAmount)   AS TotalSales,
       AVG(SalesAmount)   AS AverageSaleAmount
FROM dbo.FactInternetSales
GROUP BY ProductKey
ORDER BY TotalSales DESC;
--Q5: High performing products
SELECT ProductKey,
       SUM(SalesAmount)   AS TotalSales,
       SUM(OrderQuantity) AS TotalQuantity
FROM dbo.FactInternetSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) > 100000
ORDER BY TotalSales DESC;
--Q6: Sales order size categories
SELECT SalesOrderNumber, ProductKey, OrderQuantity, SalesAmount,
       CASE
         WHEN OrderQuantity = 1 THEN 'Single Item'
         WHEN OrderQuantity BETWEEN 2 AND 3 THEN 'Small Order'
         ELSE 'Large Order'
       END AS OrderSize
FROM dbo.FactInternetSales
ORDER BY OrderQuantity DESC;

--Q7: Customers above average income
SELECT CustomerKey, FirstName, LastName, YearlyIncome
FROM dbo.DimCustomer
WHERE YearlyIncome > (SELECT AVG(YearlyIncome) FROM dbo.DimCustomer)
ORDER BY YearlyIncome DESC;

--Q8: Rank products by list price within color
SELECT ProductKey, EnglishProductName, Color, ListPrice,
       RANK() OVER (PARTITION BY Color ORDER BY ListPrice DESC) AS PriceRankWithinColor
FROM dbo.DimProduct
WHERE Color IS NOT NULL AND ListPrice > 0
ORDER BY Color, PriceRankWithinColor;
--Q9:Monthly sales using OrderDateKey
SELECT OrderDateKey,
       SUM(SalesAmount)   AS TotalSales,
       SUM(OrderQuantity) AS TotalQuantity
FROM dbo.FactInternetSales
WHERE SalesAmount > 0
GROUP BY OrderDateKey
ORDER BY OrderDateKey;
--Q10: Top 10 customers by internet sales
SELECT TOP 10 CustomerKey,
       SUM(SalesAmount)   AS TotalSales,
       SUM(OrderQuantity) AS TotalQuantity,
       COUNT(*)           AS NumberOfSalesRows
FROM dbo.FactInternetSales
GROUP BY CustomerKey
ORDER BY TotalSales DESC;



