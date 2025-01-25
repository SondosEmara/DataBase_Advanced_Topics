Create DataBase Test
Create Table Employee
(
  ID  int  Primary Key IDENTITY(1,1),
  Name varchar(50),
  Salary decimal(10,2)
)
insert into Employee values ('Sondos',1000),('Salma',2000),('Sarah',4000),('Sherouk',2000)


--------------
--Rank Window Functions
--ROW_NUMBER Is Function
--Over decide what window (a set of rows) that will applied in function
--First Order By Salary after order thw window has the data with ordered by salary and then start with apply Function RowNumber
USE Test
Select Name,Salary,ROW_NUMBER() Over (Order By Salary Desc) AS Rank
From Employee

--Rank
Select Name,Salary,Rank() Over (Order By Salary Desc) AS Rank
From Employee


--Agreegate Window Function
--Window Date is Employee Table With Order By Salary Desc
-- computes a cumulative total of salaries, sorted in descending order.
-- When Salary is the same, their cumulative sums are identical because they are considered together in the summation.
Select Name,Salary,Sum(Salary) Over (Order By Salary Desc) AS Summation
From Employee

--That Previous Solve Problem 
Select Name,Salary,Sum(Salary) Over (Order By Salary Desc,Name ASC) AS Summation
From Employee



--Value Window Function
--make Partion By Id an in each partion order by salary
--Assume we have a  3 Partions
 -- 3 Partions --> 3Window --> First_Value Function--> applied  three times
 --https://drill.apache.org/docs/value-window-functions/
----Select Name,Salary,FIRST_VALUE(Salary) Over (partition by ID Order By Salary Desc) AS FirstValue
----From Employee
--Lag(Before)/Lead(After)/First_Value()/Last_Value()












