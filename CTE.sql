
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

--------------------------------------------

---Update if Sales Amount <50 incraese to 10% Amount
WITH SalesAmountPercentage AS
(
   Select SalesId
   From Sales
   Where AmountSale<50
)

Update Sales
Set  AmountSale=AmountSale*1.1
Where SalesId = (select * from SalesAmountPercentage)

------------------------------------------

--Using CTE Recursion
Use Sales_Test
Create Table Employee
(
  ID  int  Primary Key IDENTITY(1,1),
  Name varchar(50),
  ManagerID int 
)
insert into Employee values ('Sondos',Null),('Salma',1),('Sarah',2),('Sherouk',3)

--Exmaple Simulation
--1.Select Top Manager is ID=1
--2.In Recursive Query:
----The recursive part processes the current result set.--> is only one row EmployeeId=1
---It looks for rows in the Employees table where the ManagerID matches = 1
---it adds the new rows to the hierarchy with the updated level.


WITH EmployeeHierarchy AS
(
    SELECT ID, Name, ManagerID, 1 AS Level
    FROM Employee
    WHERE ID = 1

	UNION ALL 
	SELECT e.ID, e.Name, e.ManagerID, eh.Level + 1
    FROM Employee e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.ID

)
SELECT ID, Name, Level
FROM EmployeeHierarchy;




