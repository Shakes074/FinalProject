CREATE view [MembersActivtiesDetails] as
SELECT
	m.[FirstName] as FirstName, m.LastName,
    a.[Name] as ActivityName, 
    m.Phone, m.Email, 
    s.[Name], 
    e.[Employment], 
    b.[Name] as BranchName, b.Province
FROM 
    [dbo].[MemberActivities] AS ma
JOIN 
    [dbo].[Activity] AS a ON ma.ActivityID = a.ID
JOIN 
    [dbo].[Members] AS m ON ma.MemberID = m.ID
JOIN 
    [dbo].[Status] AS s ON m.StatusID = s.ID
JOIN 
    [dbo].[EmployeeStatus] AS e ON m.[EmployeeID] = e.ID
JOIN 
    [dbo].[Branches] AS b ON m.BranchID = b.ID;