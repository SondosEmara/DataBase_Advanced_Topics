
---DB/Table Creation
Create DataBase Sales_Test

Create Table Sales
(
  SalesId INT Primary KEY IDENTITY(1,1),
  ProductId INT NOT NULL,
  AmountSale Decimal(10,2) Not Null
);
Insert Into Sales values (1,10),(1,100),(2,20),(2,80)



----CTE Example
--CTE Get TotalSales Of Each Product
WITH TotalSales_Product AS
(
	 Select ProductId,Sum(AmountSale) AS TotalSales
	 from Sales
	 Group BY ProductId 
),
--CTE Get Total Sales Average
TotalSales_Average AS
(
  Select Avg(TotalSales) As AverageTotalSales
  From TotalSales_Product
)

--Main Query 
--Filter products with above-average total sales
Select Distinct ProductId
FROM Sales
Where AmountSale > (select AverageTotalSales from TotalSales_Average)




--Using SubQuery
Select Distinct ProductId
FROM Sales
Where AmountSale < (
  select AverageTotalSales 
  from  (
     Select Avg(res1.TotalSales) As AverageTotalSales
     From ( Select ProductId,Sum(AmountSale) AS TotalSales
	        from Sales
	        Group BY ProductId ) as res1) as res2)