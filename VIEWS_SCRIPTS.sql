
create view ViewAllActivities
as
select [ID], [Name], [Description]
from [dbo].[Activity];

CREATE VIEW ViewAllBranches AS
SELECT 
   b.[ID], b.[Name], b.[Province], b.[Country], 
    (COUNT(m.BranchID)) AS Total_Members
FROM 
    [dbo].[Branches] AS b 
LEFT JOIN
    [dbo].[Members] AS m ON b.ID = m.BranchID
GROUP BY 
    b.[Name], b.[Province], b.[Country], b.[ID];

CREATE VIEW ViewAllEmployee 
AS
SELECT [ID], [Employment], [Description]
FROM [dbo].[EmployeeStatus];

CREATE view ViewAllRoles as
	select [ID], [Name] , [Description]
from [dbo].[Roles];

CREATE VIEW [ViewAllStatus]
AS 
SELECT [ID], [Name], [Description], [Criteria]
FROM [dbo].[Status];

create view InsertViewBranch
as 
select [Name], [Province], [Country]
from Branches;







