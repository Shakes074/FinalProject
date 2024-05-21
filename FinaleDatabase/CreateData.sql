DROP TABLE [dbo].[Roles];
DROP TABLE [dbo].[Activity];
DROP TABLE [dbo].[Branches];
DROP TABLE [dbo].[Status];
DROP TABLE [dbo].[EmployeeStatus];
DROP TABLE [dbo].[Members];
DROP TABLE [dbo].[MemberActivities];

-- Populate Roles
INSERT INTO [dbo].[Roles] ([Name], [Description]) 
VALUES 
    ('Admin', 'Has full access to all resources'),
    ('Branch Manager', 'Full access to a specific branch'),
    ('User', 'Has limited access to resources');
    
-- Populate Activity
INSERT INTO [dbo].[Activity] ([Name], [Description]) 
VALUES  
    ('Sunday Service', 'Attendance at the weekly Sunday service'),
    ('Bible Study', 'Participation in a Bible study group'),
    ('Prayer Meeting', 'Attendance at a prayer meeting'),
    ('Outreach Event', 'Involvement in community outreach activities'),
    ('Youth Program', 'Participation in youth-specific programs and events'),
    ('Choir Practice', 'Attendance at choir practice sessions'),
    ('Volunteer Work', 'Volunteering for church-related tasks or events'),
    ('Retreat', 'Attendance at a spiritual retreat'),
    ('Baptism', 'Participation in a baptism ceremony'),
    ('Sealing Ceremony', 'Participation in a sealing ceremony');
   
-- Populate Branches
INSERT INTO Branches ([Name], Province, Country)
VALUES
    ('Johannesburg Central', 'Gauteng', 'South Africa'),
    ('Cape Town', 'Western Cape', 'South Africa'),
    ('Durban', 'KwaZulu-Natal', 'South Africa'),
    ('Pretoria', 'Gauteng', 'South Africa'),
    ('Bloemfontein', 'Free State', 'South Africa'),
    ('Lusaka', 'Lusaka', 'Zambia'),
    ('Nairobi', 'Nairobi', 'Kenya'),
    ('Gaborone', 'Gaborone', 'Botswana'),
    ('Harare', 'Harare', 'Zimbabwe'),
    ('Windhoek', 'Khomas', 'Namibia');
   
-- Populate Status
INSERT INTO [Status] ([Name], [Description], Criteria)
VALUES
    ('Welcomed', 'New members who have been welcomed into the church', 'Attended introduction sessions'),
    ('Waiting for Sealing', 'Members in the process of being sealed', 'Currently attending required courses'),
    ('Sealed', 'Members who have been officially sealed as part of the church', 'Completed required courses and ceremonies'),
    ('Baptized', 'Members who have been baptized', 'Completed baptism ceremony'),
    ('Testifier', 'Members who have given their testimony', 'Shared their personal story and experience'),    
    ('Inactive', 'Members who have not been active recently', 'No participation for a specified period'),
    ('Lapsed', 'Members who have left the church', 'Officially withdrawn or removed from membership'),
    ('Passed', 'Members who passed away', 'Member passed away as our members');
   
-- Populate EmployeeStatus
INSERT INTO [dbo].[EmployeeStatus] (Employment, [Description]) 
VALUES
    ('Employed', 'Full-time worker'),
    ('Student', 'Full-time Student'),
    ('Un-Employed', 'Not yet working');
    
-- Populate Members
-- Note: Adjust the dates and foreign key values to match your data
INSERT INTO [dbo].[Members] (FirstName, LastName, MaritalStatus, DateOfBirth, Gender, Email, Phone, [Password], JoinDate, BranchID, StatusID, RoleID, EmployeeID)
VALUES 
    ('John', 'Doe', 1, '1980-01-01', 'M', 'john.doe@example.com', '1234567890', 'password', '2000-05-20', 1, 3, 1, 1),
    ('Zodwa', 'Doe', 0, '1980-01-01', 'F', 'Zodwa.doe@example.com', '1234567890', 'password', '2015-05-20' , 2, 1, 3, 2),
    ('Londi', 'Doe', 0, '1980-01-01', 'M', 'Londi.doe@example.com', '1234567890', 'password', '2018-05-20', 3, 5, 2, 2),
    ('Xoli', 'Doe', 1, '1980-01-01', 'F', 'Xoli.doe@example.com', '1234567890', 'password', '1995-05-20', 1, 8, 3, 3),
    ('Sbonga', 'Doe', 0, '1980-01-01', 'M', 'Sbonga.doe@example.com', '1234567890', 'password', '2002-05-20', 2, 1, 3, 3),
    ('Zama', 'Doe', 1, '1980-01-01', 'F', 'Zama.doe@example.com', '1234567890', 'password', '2001-05-20', 1, 6, 3, 2),
    ('Zanele', 'Doe', 0, '1980-01-01', 'M', 'Zanele.doe@example.com', '1234567890', 'password', '1997-05-20', 3, 2, 2, 3);

-- Populate MemberActivities
-- Note: Adjust the foreign key values to match your data
INSERT INTO [dbo].[MemberActivities] (MemberID, ActivityID) 
VALUES 
    (1, 2),
    (3, 4),
    (1, 3),
    (2, 6),
    (1, 9),
    (4, 1),
    (1, 1),
    (7, 1);

-- Test Seclect
SELECT * FROM ROLES;
SELECT * FROM Activity;
SELECT * FROM BRANCHES;
SELECT * FROM [STATUS];
SELECT * FROM [EmployeeStatus];
SELECT * FROM [dbo].[Members];
SELECT * FROM [dbo].[MemberActivities];
