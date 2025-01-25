---User-Defined Functions
--Type_1: Scalar Functions
GO
Create Function SquareNumber(@num int)
Returns int
As
Begin 
    DECLARE @Square INT
    SET @Square =@num*@num
    RETURN @Square
END
GO
select dbo.SquareNumber(2)
go


---Type2:Inline Table-Valued Functions (iTVFs)
CREATE FUNCTION GetEmployeesByID (@ID INT)
RETURNS TABLE
AS
RETURN (
    SELECT ID
    FROM Employee
    WHERE ID = @ID
)
go
select* from dbo.GetEmployeesByID(2)


---Type3:
CREATE FUNCTION dbo.GetEmployeesBySalaryRange (@MinSalary DECIMAL(10,2), @MaxSalary DECIMAL(10,2))
RETURNS @EmployeeTable TABLE (
    EmployeeID INT,
    Name Varchar(50),
    Salary DECIMAL(10,2)
)
AS
BEGIN
    INSERT INTO @EmployeeTable (EmployeeID, Name,Salary)
    SELECT ID, Name,Salary
    FROM Employee
    WHERE Salary BETWEEN @MinSalary AND @MaxSalary
    RETURN
END

select * from dbo.GetEmployeesBySalaryRange (1000,50000)





