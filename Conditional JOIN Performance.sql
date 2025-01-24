
USE TESTDB;
GO
Create Table dbo.Orders
(
  ID INT IDENTITY PRIMARY KEY,
  TotalAmount decimal  NOT NULL 
);
GO

Create Table ShippingRules
(
 RuleID   INT IDENTITY PRIMARY KEY,
 Standard decimal  NOT NULL,
 Express  decimal  NOT NULL,
 Priority decimal  NOT NULL,
);

GO
Insert Into Orders(TotalAmount) Values(20),(30),(10);
Insert Into ShippingRules(Standard,Express,Priority) Values(25.00,50.00,100.00),(50.00,75.00,150.00);
GO

--Create Query To Get OrderId,Order Total Amount , Rule ID, RuleName 
--Case_1: If TotalAmount is From 1-15 is Standard.... 
--Case_2: If TotalAmount is From 20-30 is Express......

---Bad Solution
select o.Id,o.TotalAmount,r.RuleID, r.Standard, r.Express, r.Priority
FROM Orders [o] JOIN ShippingRules [r]
ON o.TotalAmount<=CASE 
                    WHEN  o.TotalAmount BETWEEN 1 AND 15 THEN r.Standard
					WHEN  o.TotalAmount BETWEEN 20 AND 25 THEN r.Express
					ELSE r.Priority
                    END;
/*
The CASE in the ON clause evaluates each condition row-by-row, which can be computationally expensive for large datasets.
This happens for every row in the left table, meaning that the condition is re-evaluated once per row.


Why This is Expensive??
Repeated Calculations: The same CASE logic is calculated many times, even if the conditions don’t change.

No Index Optimization: Indexes on the ShippingRules table can't be used efficiently because the result of the CASE isn't fixed—it depends on the value of TotalAmount in each row.

    How Indexes Work??
        Indexes help the database quickly locate rows in a table without scanning the entire table.
        They work best when the query has fixed, predictable conditions (e.g., Column = Value or Column BETWEEN X AND Y).
Cartesian Product: If the left table has many rows (e.g., millions), this evaluation can lead to a large number of comparisons.
*/

---Best Solution

----Filtering and Join:
----This query first filters the Orders table to include only those rows where o.TotalAmount is between 1 and 25.
----It then joins the ShippingRules table based on the condition that o.TotalAmount must equal s.Standard.



SELECT o.ID, o.TotalAmount, s.RuleID
FROM Orders o
JOIN ShippingRules s 
ON o.TotalAmount BETWEEN 1 AND 25 AND o.TotalAmount = s.Standard

UNION ALL

SELECT o.ID, o.TotalAmount, s.RuleID
FROM Orders o
JOIN ShippingRules s ON o.TotalAmount BETWEEN 26 AND 50 AND o.TotalAmount = s.Express

UNION ALL

SELECT o.ID, o.TotalAmount, s.RuleID
FROM Orders o
JOIN ShippingRules s ON o.TotalAmount BETWEEN 51 AND 100 AND o.TotalAmount = s.Priority




/*
How an Index Works?

1.When an index is created on a column (or combination of columns), the database creates a data structure (usually a B-tree) 

CREATE INDEX idx_email ON Customers (Email);
This creates an index on the Email column. The database engine will build a B-tree index to optimize the search.


A B-tree is a balanced search tree used in databases and file systems to store and retrieve data efficiently. 
It allows for fast searches, insertions, and deletions by organizing data into 



B-tree Structure: The B-tree will be constructed to store the email values in a sorted order, and each node in the B-tree will hold a value (the email) and a pointer to the corresponding row in the Customers table.

So, each node in the index would look something like this:

(email_value, pointer_to_row)
Example:

Email: "john@example.com", Pointer: RowID 101
Email: "alice@example.com", Pointer: RowID 102
Email: "bob@example.com", Pointer: RowID 103
The pointer in this case doesn't directly point to the email value itself; rather, it points to the location of the actual data (the row in the database) that holds the full information for that email.

*/












