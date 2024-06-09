SET IDENTITY_INSERT [dbo].[Activity] ON
INSERT INTO 
[dbo].[Activity] 
	([Name], [Description]) 
VALUES 
	(N'Sunday Service', N'Attendance at the weekly Sunday service'), 
	(N'Bible Study', N'Participation in a Bible study group'),
	(N'Prayer Meeting', N'Attendance at a prayer meeting'),
	(N'Outreach Event', N'Involvement in community outreach activities'),
	(N'Youth Program', N'Participation in youth-specific programs and events'),
	(N'Choir Practice', N'Attendance at choir practice sessions'),
	(N'Volunteer Work', N'Volunteering for church-related tasks or events'),
	(N'Retreat', N'Attendance at a spiritual retreat'),
	(N'Baptism', N'Participation in a baptism ceremony'),
	(N'Sealing Ceremony', N'Participation in a sealing ceremony');
SET IDENTITY_INSERT [dbo].[Activity] OFF

SET IDENTITY_INSERT [dbo].[Branches] ON
INSERT INTO [dbo].[Branches] 
	([Name], [Province], [Country]) 
VALUES 
	(N'Johannesburg Central', N'Gauteng', N'South Africa'),
	(N'Cape Town', N'Western Cape', N'South Africa'),
	(N'Durban', N'KwaZulu-Natal', N'South Africa'),
	(N'Pretoria', N'Gauteng', N'South Africa'),
	(N'Bloemfontein', N'Free State', N'South Africa'),
	(N'Lusaka', N'Lusaka', N'Zambia'),
	(N'Nairobi', N'Nairobi', N'Kenya'),
	(N'Gaborone', N'Gaborone', N'Botswana'),
	(N'Harare', N'Harare', N'Zimbabwe'),
	(N'Windhoek', N'Khomas', N'Namibia');
SET IDENTITY_INSERT [dbo].[Branches] OFF

SET IDENTITY_INSERT [dbo].[EmployeeStatus] ON
INSERT INTO [dbo].[EmployeeStatus] 
	([Employment], [Description]) 
VALUES 
	(N'Employed', N'Full-time worker'),
	(N'Student', N'Full-time Student'),
	(N'Un-Employed', N'Not yet working');
SET IDENTITY_INSERT [dbo].[EmployeeStatus] OFF

SET IDENTITY_INSERT [dbo].[MemberActivities] ON
INSERT INTO [dbo].[MemberActivities] 
	 ([MemberID], [ActivityID]) 
VALUES 
	 (1, 2),
	 (3, 4),
	 (1, 3),
	 (2, 6),
	 (1, 9),
	 (4, 1),
	 (1, 1),
	 (7, 1);
SET IDENTITY_INSERT [dbo].[MemberActivities] OFF

SET IDENTITY_INSERT [dbo].[Members] ON
INSERT INTO [dbo].[Members] 
	([FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender], [Email], [Phone], [Password], [JoinDate], [BranchID], [StatusID], [RoleID], [EmployeeID]) 
VALUES 
	(N'John', N'Doe', 1, N'1980-01-01', N'M', N'john.doe@example.com', N'1234567890', N'password', N'2000-05-20', 1, 3, 1, 1),
	(N'Zodwa', N'Doe', 0, N'1980-01-01', N'F', N'Zodwa.doe@example.com', N'1234567890', N'password', N'2015-05-20', 2, 1, 3, 2),
	(N'Londi', N'Doe', 0, N'1980-01-01', N'M', N'Londi.doe@example.com', N'1234567890', N'password', N'2018-05-20', 3, 5, 2, 2),
	(N'Xoli', N'Doe', 1, N'1980-01-01', N'F', N'Xoli.doe@example.com', N'1234567890', N'password', N'1995-05-20', 1, 8, 3, 3),
	(N'Sbonga', N'Doe', 0, N'1980-01-01', N'M', N'Sbonga.doe@example.com', N'1234567890', N'password', N'2002-05-20', 2, 1, 3, 3),
	(N'Zama', N'Doe', 1, N'1980-01-01', N'F', N'Zama.doe@example.com', N'1234567890', N'password', N'2001-05-20', 1, 6, 3, 2),
	(N'Zanele', N'Doe', 0, N'1980-01-01', N'M', N'Zanele.doe@example.com', N'1234567890', N'password', N'1997-05-20', 3, 2, 2, 3);
SET IDENTITY_INSERT [dbo].[Members] OFF

SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT INTO [dbo].[Roles] 
	([Name], [Description]) 
VALUES 
	(N'Admin', N'Has full access to all resources'),
	(N'Branch Manager', N'Full access to a specific branch'),
	(N'User', N'Has limited access to resources');
SET IDENTITY_INSERT [dbo].[Roles] OFF

SET IDENTITY_INSERT [dbo].[Status] ON
INSERT INTO [dbo].[Status] 
	([Name], [Description], [Criteria]) 
VALUES 
	(N'Welcomed', N'New members who have been welcomed into the church', N'Attended introduction sessions'),
	(N'Waiting for Sealing', N'Members in the process of being sealed', N'Currently attending required courses'),
	(N'Sealed', N'Members who have been officially sealed as part of the church', N'Completed required courses and ceremonies'),
	(N'Baptized', N'Members who have been baptized', N'Completed baptism ceremony'),
	(N'Testifier', N'Members who have given their testimony', N'Shared their personal story and experience'),
	(N'Inactive', N'Members who have not been active recently', N'No participation for a specified period'),
	(N'Lapsed', N'Members who have left the church', N'Officially withdrawn or removed from membership'),
	(N'Passed', N'Members who passed away', N'Member passed away as our members');
SET IDENTITY_INSERT [dbo].[Status] OFF

---- reseting auto ID
DBCC CHECKIDENT (Members, RESEED, 0);

BEGIN TRY
INSERT INTO [dbo].[Members]
(
    [FirstName], [LastName], 
    [MaritalStatus], [DateOfBirth], [Gender],
    [Email], [Phone], [Password], [JoinDate],
    [BranchID], [StatusID], [RoleID], [EmployeeID]
)
VALUES
(
    'Shakes', 'Chili', 
    (CASE WHEN 'YES' = 'YES' THEN 1 ELSE 0 END),
    '2024/12/02',
    (CASE WHEN 'MALE' = 'MALE' THEN 'M' ELSE 'F' END),
    'shakes02@me.com',
    '0733587521',
    'Paswd123',
    '2024/01/30',
    (SELECT ID FROM [dbo].[Branches] WHERE [Name] = 'Lusaka'),
    (SELECT ID FROM [dbo].[Status] WHERE [Name] = 'Welcomed'),
    (SELECT ID FROM Roles WHERE [Name] = 'User'),
    (SELECT ID FROM [dbo].[EmployeeStatus] WHERE [Employment] = 'Student')
);
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 2627
    BEGIN
        PRINT 'A record with this email already exists.'
    END
END CATCH








