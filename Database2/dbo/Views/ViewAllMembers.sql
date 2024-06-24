CREATE view ViewAllMembers
as
SELECT 
    m.ID, m.[FirstName], m.[LastName], 
	(CASE WHEN MaritalStatus = 1 THEN 'Married' ELSE 'Single' END) as [MaritalStatus], 
	FORMAT(m.[DateOfBirth], 'dd/MM/yyyy') as DateOfBirth,  m.[Gender], 
    m.[Email], m.[Phone], m.[Password], FORMAT(m.[JoinDate], 'dd/MM/yyyy') as JoinDate, 
    b.[Name] AS BranchName, b.[Province], b.[Country],
    s.[Name] AS StatusName,
    r.[Name] AS RoleName,
    e.[Employment] as employeeName
FROM 
    [dbo].[Members] AS m 
JOIN
    [dbo].[Branches] AS b ON m.BranchID = b.ID
JOIN
    [dbo].[Status] AS s ON m.StatusID = s.ID
JOIN
    [dbo].[Roles] AS r ON m.RoleID = r.ID
JOIN
    [dbo].[EmployeeStatus] AS e ON m.[EmployeeID] = e.ID
group by m.[FirstName], m.[LastName], m.[MaritalStatus], m.[DateOfBirth],  m.[Gender], 
    m.[Email], m.[Phone], m.[Password], m.[JoinDate], b.[Name], b.[Province], b.[Country],
    s.[Name],
    r.[Name],
    e.[Employment], m.ID;