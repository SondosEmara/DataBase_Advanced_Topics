---Recursive Query 
---First Go To Base base query returns number 1
---First Iteration will return 1+1=2
--Second iteration will return 2+1=3
--Third Iteration will return empty result --> stop here 

--A recursive query in SQL is a query that calls itself 
--continuously until no new result is found. 
--A recursive common table expression (CTE) in a query, 
--for example, repeatedly references a previous result until it returns an empty result.

--used to handle hierarchical data and help navigate hierarchical relationships in a database.

--https://builtin.com/data-science/recursive-sql
WITH Counter AS
(
  Select 1 AS N
  UNION ALL
  SELECT N+1 From Counter where N<3
)
SELECT * FROM Counter