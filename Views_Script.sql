-- =============================================
-- Core Reference Data Views
-- =============================================

-- vw_Activities (Updated to use Activity table)
CREATE OR ALTER VIEW [dbo].[vw_Activities]
AS
SELECT 
    ID,
    [Name],
    [Description],
    IsActive,
    CreatedDate,
    ModifiedDate
FROM Activity
WHERE IsActive = 1;
GO

-- vw_Branches
CREATE OR ALTER VIEW [dbo].[vw_Branches]
AS
SELECT 
    ID,
    [Name],
    Province,
    Country,
    IsActive,
    CreatedDate,
    ModifiedDate
FROM Branches
WHERE IsActive = 1;
GO

-- vw_BranchesForInsert
CREATE OR ALTER VIEW [dbo].[vw_BranchesForInsert]
AS
SELECT 
    [Name],
    Province,
    Country,
    IsActive,
    CreatedDate,
    ModifiedDate
FROM Branches;
GO

-- vw_Roles
CREATE OR ALTER VIEW [dbo].[vw_Roles]
AS
SELECT 
    ID,
    [Name],
    [Description],
    IsActive,
    CreatedDate,
    ModifiedDate
FROM Roles
WHERE IsActive = 1;
GO

-- vw_Status
CREATE OR ALTER VIEW [dbo].[vw_Status]
AS
SELECT 
    ID,
    [Name],
    [Description],
    Criteria,
    IsActive,
    CreatedDate,
    ModifiedDate
FROM [Status]
WHERE IsActive = 1;
GO

-- vw_Members (Updated for EmploymentStatusID)
CREATE OR ALTER VIEW [dbo].[vw_Members]
AS
SELECT 
    m.ID,
    m.FirstName,
    m.LastName,
    m.MaritalStatus,
    m.DateOfBirth,
    m.Gender,
    m.Email,
    m.Phone,
    m.[Password],
    m.JoinDate,
    b.[Name] AS BranchName,
    b.ID AS BranchID,
    s.[Name] AS StatusName,
    s.ID AS StatusID,
    r.[Name] AS RoleName,
    r.ID AS RoleID,
    e.Employment AS EmploymentStatus,
    e.ID AS EmploymentStatusID,
    DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) AS Age,
    CASE
        WHEN DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) < 13 THEN 'Sunday School'
        WHEN DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
        ELSE 'Adult'
    END AS MemberGroup,
    m.IsActive,
    m.CreatedDate,
    m.ModifiedDate
FROM Members m
INNER JOIN Branches b ON m.BranchID = b.ID
INNER JOIN [Status] s ON m.StatusID = s.ID
INNER JOIN Roles r ON m.RoleID = r.ID
INNER JOIN EmploymentStatus e ON m.EmploymentStatusID = e.ID
WHERE m.IsActive = 1;
GO

-- vw_MembersForInsert
CREATE OR ALTER VIEW [dbo].[vw_MembersForInsert]
AS
SELECT 
    FirstName,
    LastName,
    MaritalStatus,
    DateOfBirth,
    Gender,
    Email,
    Phone,
    [Password],
    JoinDate,
    BranchID,
    StatusID,
    RoleID,
    EmploymentStatusID,
    IsActive,
    CreatedDate,
    ModifiedDate
FROM Members;
GO

-- vw_MemberAgeGroups
CREATE OR ALTER VIEW [dbo].[vw_MemberAgeGroups]
AS
SELECT 
    m.FirstName,
    m.LastName,
    m.Gender,
    m.Phone,
    b.[Name] AS BranchName,
    CASE
        WHEN DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) < 13 THEN 'Sunday School'
        WHEN DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
        ELSE 'Adult'
    END AS MemberGroup
FROM Members m
INNER JOIN Branches b ON m.BranchID = b.ID
WHERE m.IsActive = 1 AND m.DateOfBirth IS NOT NULL;
GO

-- vw_MemberGroupsSummary
CREATE OR ALTER VIEW [dbo].[vw_MemberGroupsSummary]
AS
SELECT
    CASE
        WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) < 13 THEN 'Sunday School'
        WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
        ELSE 'Adult'
    END AS MemberGroup,
    COUNT(*) AS TotalMembers
FROM Members AS m
WHERE m.DateOfBirth IS NOT NULL AND m.IsActive = 1
GROUP BY
    CASE
        WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) < 13 THEN 'Sunday School'
        WHEN DATEDIFF(YEAR, m.[DateOfBirth], GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
        ELSE 'Adult'
    END;
GO

-- vw_MemberActivityDetails (Updated for MemberActivities)
CREATE OR ALTER VIEW [dbo].[vw_MemberActivityDetails]
AS
SELECT 
    m.FirstName,
    m.LastName,
    m.Gender,
    m.Phone,
    a.[Name] AS ActivityName,
    b.[Name] AS BranchName,
    ma.ParticipationDate,
    ma.HoursParticipated
FROM Members m
INNER JOIN Branches b ON m.BranchID = b.ID
INNER JOIN MemberActivities ma ON m.ID = ma.MemberID
INNER JOIN Activity a ON ma.ActivityID = a.ID
WHERE m.IsActive = 1 AND b.IsActive = 1 AND a.IsActive = 1 AND ma.IsActive = 1;
GO

-- vw_BranchStatistics
CREATE OR ALTER VIEW [dbo].[vw_BranchStatistics]
AS
SELECT
    b.[Name] AS BranchName,
    SUM(CASE WHEN mg.MemberGroup = 'Sunday School' THEN 1 ELSE 0 END) AS SundaySchool,
    SUM(CASE WHEN mg.MemberGroup = 'Youth' THEN 1 ELSE 0 END) AS Youth,
    SUM(CASE WHEN mg.MemberGroup = 'Adult' THEN 1 ELSE 0 END) AS Adults,
    COUNT(*) AS TotalMembers
FROM Members m
INNER JOIN Branches b ON m.BranchID = b.ID
CROSS APPLY (
    SELECT CASE
        WHEN DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) < 13 THEN 'Sunday School'
        WHEN DATEDIFF(YEAR, m.DateOfBirth, GETDATE()) BETWEEN 13 AND 19 THEN 'Youth'
        ELSE 'Adult'
    END AS MemberGroup
) mg
WHERE m.IsActive = 1 AND b.IsActive = 1
GROUP BY b.[Name];
GO

-- vw_Attendance (NEW View)
CREATE OR ALTER VIEW [dbo].[vw_Attendance]
AS
SELECT 
    a.ID,
    m.FirstName,
    m.LastName,
    m.Email,
    act.[Name] AS ActivityName,
    a.AttendanceDate,
    a.TimeIn,
    a.TimeOut,
    a.IsPresent,
    a.Notes,
    b.[Name] AS BranchName
FROM Attendance a
INNER JOIN Members m ON a.MemberID = m.ID
INNER JOIN Activity act ON a.ActivityID = act.ID
INNER JOIN Branches b ON m.BranchID = b.ID
WHERE a.IsActive = 1 AND m.IsActive = 1 AND act.IsActive = 1;
GO

-- vw_Contributions (NEW View)
CREATE OR ALTER VIEW [dbo].[vw_Contributions]
AS
SELECT 
    c.ID,
    m.FirstName,
    m.LastName,
    m.Email,
    c.ContributionDate,
    c.Amount,
    c.ContributionType,
    c.PaymentMethod,
    c.ReferenceNumber,
    c.Notes,
    b.[Name] AS BranchName
FROM Contributions c
INNER JOIN Members m ON c.MemberID = m.ID
INNER JOIN Branches b ON m.BranchID = b.ID
WHERE c.IsActive = 1 AND m.IsActive = 1;
GO




