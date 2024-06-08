---------- DROPPING DATABASE TABLES
drop table [dbo].[MemberActivities];

drop table [dbo].[Members];

drop table [dbo].[Roles];

drop table [dbo].[Status];

drop table [dbo].[Activity];

drop table [dbo].[Branches];

drop table [dbo].[EmployeeStatus];

---------- CREATING DATABASE TABLES
CREATE TABLE [dbo].[Roles] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Status] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    [Criteria]    VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Activity] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Branches] (
    [ID]       INT           IDENTITY (1, 1) NOT NULL,
    [Country]  VARCHAR (50)  NOT NULL,
    [Province] VARCHAR (50)  NOT NULL,
    [Name]     VARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[EmployeeStatus] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Employment]  VARCHAR (50)  NULL,
    [Description] VARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Members] (
    [ID]            INT          IDENTITY (1, 1) NOT NULL,
    [FirstName]     VARCHAR (50) NOT NULL,
    [LastName]      VARCHAR (50) NOT NULL,
    [MaritalStatus] BIT          NOT NULL,
    [DateOfBirth]   DATETIME     DEFAULT (format(getdate(),'yyyy-MM-dd')) NOT NULL,
    [Gender]        CHAR (1)     NOT NULL,
    [Email]         VARCHAR (50) NOT NULL,
    [Phone]         VARCHAR (13) NULL,
    [Password]      VARCHAR (10) NULL,
    [JoinDate]      DATE         DEFAULT (format(getdate(),'yyyy-MM-dd')) NULL,
    [BranchID]      INT          NOT NULL,
    [StatusID]      INT          DEFAULT ((1)) NULL,
    [RoleID]        INT          DEFAULT ((3)) NULL,
    [EmployeeID]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC),
    FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([ID]),
    FOREIGN KEY ([StatusID]) REFERENCES [dbo].[Status] ([ID]),
    FOREIGN KEY ([BranchID]) REFERENCES [dbo].[Branches] ([ID]),
    FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[EmployeeStatus] ([ID])
);

CREATE TABLE [dbo].[MemberActivities] (
    [ID]         INT IDENTITY (1, 1) NOT NULL,
    [MemberID]   INT NOT NULL,
    [ActivityID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Members] ([ID]),
    FOREIGN KEY ([ActivityID]) REFERENCES [dbo].[Activity] ([ID])
);

--------- INSERTING INTO DATABASE
----- ROLES
INSERT INTO [dbo].[Roles] ( [Name], [Description]) VALUES (N'Admin', N'Has full access to all resources')
INSERT INTO [dbo].[Roles] ( [Name], [Description]) VALUES (N'Branch Manager', N'Full access to a specific branch')
INSERT INTO [dbo].[Roles] ( [Name], [Description]) VALUES (N'User', N'Has limited access to resources')

----- MEMBERS' STATUS
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES (N'Welcomed', N'New members who have been welcomed into the church', N'Attended introduction sessions')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES (N'Waiting for Sealing', N'Members in the process of being sealed', N'Currently attending required courses')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES (N'Sealed', N'Members who have been officially sealed as part of the church', N'Completed required courses and ceremonies')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES ( N'Baptized', N'Members who have been baptized', N'Completed baptism ceremony')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES ( N'Testifier', N'Members who have given their testimony', N'Shared their personal story and experience')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES ( N'Inactive', N'Members who have not been active recently', N'No participation for a specified period')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES ( N'Lapsed', N'Members who have left the church', N'Officially withdrawn or removed from membership')
INSERT INTO [dbo].[Status] ( [Name], [Description], [Criteria]) VALUES ( N'Passed', N'Members who passed away', N'Member passed away as our members')

----- ACTIVITIES
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Sunday Service', N'Attendance at the weekly Sunday service')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Bible Study', N'Participation in a Bible study group')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Prayer Meeting', N'Attendance at a prayer meeting')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Outreach Event', N'Involvement in community outreach activities')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Youth Program', N'Participation in youth-specific programs and events')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Choir Practice', N'Attendance at choir practice sessions')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Volunteer Work', N'Volunteering for church-related tasks or events')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Retreat', N'Attendance at a spiritual retreat')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Baptism', N'Participation in a baptism ceremony')
INSERT INTO [dbo].[Activity] ( [Name], [Description]) VALUES ( N'Sealing Ceremony', N'Participation in a sealing ceremony')

----- BRANCHES
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'South Africa', N'Gauteng', N'Johannesburg Central')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'South Africa', N'KwaZulu-Natal', N'Durban')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Zambia', N'Lusaka', N'Lusaka')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES (N'Kenya', N'Nairobi', N'Nairobi')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Botswana', N'Gaborone', N'Gaborone')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Zimbabwe', N'Harare', N'Harare')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Namibia', N'Khomas', N'Windhoek')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Albania', N'Durrës County', N'DC Church')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Zambia', N'Lusaka Province', N'Lusaka Church')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Zambia', N'Lusaka Province', N'Lusaka Church')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Albania', N'Dibër County', N'testing')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Vietnam', N'Bình Duong', N'Binh Duong Church')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'South Africa', N'Gauteng', N'Benoni Church')
INSERT INTO [dbo].[Branches] ( [Country], [Province], [Name]) VALUES ( N'Algeria', N'Batna Province', N'Batna Church')

----- MEMBER WORK STATUS
INSERT INTO [dbo].[EmployeeStatus] ( [Employment], [Description]) VALUES ( N'Employed', N'Full-time worker')
INSERT INTO [dbo].[EmployeeStatus] ( [Employment], [Description]) VALUES ( N'Student', N'Full-time Student')
INSERT INTO [dbo].[EmployeeStatus] ( [Employment], [Description]) VALUES ( N'Un-Employed', N'Not yet working')

----- MEMBERS
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'John', N'Doe', 1, N'1980-01-01 00:00:00', N'M', N'john.doe@example.com', N'1234567890', N'password', N'2000-05-20', 2, 3, 1, 1)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Zodwa', N'Doe', 0, N'1980-01-01 00:00:00', N'F', N'Zodwa.doe@example.com', N'1234567890', N'password', N'2015-05-20', 2, 1, 3, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Londi', N'Doe', 0, N'1980-01-01 00:00:00', N'M', N'Londi.doe@example.com', N'1234567890', N'password', N'2018-05-20', 3, 5, 2, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Xoli', N'Doe', 1, N'1980-01-01 00:00:00', N'F', N'Xoli.doe@example.com', N'1234567890', N'password', N'1995-05-20', 1, 8, 3, 3)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Sbonga', N'Doe', 0, N'1980-01-01 00:00:00', N'M', N'Sbonga.doe@example.com', N'1234567890', N'password', N'2002-05-20', 2, 1, 3, 3)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Zama', N'Doe', 1, N'1980-01-01 00:00:00', N'F', N'Zama.doe@example.com', N'1234567890', N'password', N'2001-05-20', 1, 6, 3, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES (N'Zanele', N'Doe', 0, N'1980-01-01 00:00:00', N'M', N'Zanele.doe@example.com', N'1234567890', N'password', N'1997-05-20', 3, 2, 2, 3)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Shakes', N'Chili', 1, N'2024-12-02 00:00:00', N'M', N'shakes@me.com', N'0733587521', N'Paswd123', N'2024-01-30', 3, 1, 3, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES (N'Shakes', N'Chili', 1, N'2024-12-02 00:00:00', N'M', N'shakes02@me.com', N'0733587521', N'Paswd123', N'2024-01-30', 6, 1, 3, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Bongi', N'Zwane', 1, N'2002-01-31 00:00:00', N'M', N'bongiz@gmail.com', N'031511856', N'123456', N'2024-05-26', 7, 2, 3, 1)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Zama', N'Zuke', 0, N'1995-06-16 00:00:00', N'M', N'zukes@gmail.com', N'0315542365', N'123456987', N'2024-02-01', 2, 1, 3, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Mandla', N'Zondi', 0, N'1996-06-14 00:00:00', N'F', N'mzondi@gmail.com', N'0316251478', N'147895', N'2024-10-02', 6, 1, 3, 1)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES (N'Zulelihle', N'Mbambo', 0, N'1998-06-15 00:00:00', N'M', N'zulumb@gmail.com', N'0312547896', N'123456', N'2024-04-20', 6, 1, 3, 2)
INSERT INTO [dbo].[Members] ( [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) VALUES ( N'Zakwe', N'Zungu', 0, N'1999-06-01 00:00:00', N'M', N'zakwezungu@gmail.com', N'0747103690', N'123456', N'2024-06-01', 6, 1, 3, 3)

----- MEMBERS' ACTIVITIES
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (8, 2)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (3, 4)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (2, 3)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (2, 7)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (1, 6)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (4, 5)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (1, 1)
INSERT INTO [dbo].[MemberActivities] ( [MemberID], [ActivityID]) VALUES (7, 10)



----- CREATING DATABASE VIEWS
CREATE view InsertViewBranch as 
select  
    [Country], [Province], [Name]
from Branches;

CREATE view InsertViewMember as
select 
	[FirstName], [LastName], [MaritalStatus],
	[DateOfBirth], [Gender], [Email], [Phone],
	[Password], 
	[BranchID], [EmployeeID]
from members;

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

create view ViewAllActivities as
select 
    [ID], [Name], [Description]
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

CREATE VIEW ViewAllEmployee AS
SELECT 
    [ID], [Employment], [Description]
FROM [dbo].[EmployeeStatus];

CREATE view ViewAllMembers as
SELECT 
    m.ID, m.[FirstName], m.[LastName], 
	(CASE WHEN MaritalStatus = 1 THEN 'Married' ELSE 'Single' END) as [MaritalStatus], 
	FORMAT(m.[DateOfBirth], 'dd/MM/yyyy') as DateOfBirth,  m.[Gender], 
    m.[Email], m.[Phone], m.[Password], FORMAT(m.[JoinDate], 'dd/MM/yyyy') as JoinDate, 
    b.[Name] AS BranchName, b.[Province], b.[Country],
    s.[Name] AS StatusName,
    r.[Name] AS RoleName,
    e.[Employment]
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

CREATE view ViewAllRoles as
select 
    [ID], [Name] , [Description]
from [dbo].[Roles];

CREATE VIEW [ViewAllStatus] AS 
SELECT 
    [ID], [Name], [Description], [Criteria]
FROM [dbo].[Status];



----- CREATING STORED PROCEDURES



