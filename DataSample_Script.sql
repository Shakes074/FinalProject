-- Insert EmploymentStatus
IF NOT EXISTS (SELECT 1 FROM EmploymentStatus)
INSERT INTO EmploymentStatus (Employment, [Description]) VALUES
('Un-Employed', 'Currently not employed'),
('Employed', 'Currently employed'),
('Self-Employed', 'Self-employed or business owner'),
('Student', 'Currently studying'),
('Retired', 'Retired from employment');
GO

-- Insert Branches
IF NOT EXISTS (SELECT 1 FROM Branches)
INSERT INTO Branches ([Name], Province, Country) VALUES
('Johannesburg Central', 'Gauteng', 'South Africa'),
('Cape Town Coastal', 'Western Cape', 'South Africa'),
('Durban Coastal', 'KwaZulu-Natal', 'South Africa'),
('Pretoria Capital', 'Gauteng', 'South Africa');
GO

-- Insert Roles
IF NOT EXISTS (SELECT 1 FROM Roles)
INSERT INTO Roles ([Name], [Description]) VALUES
('Admin', 'System administrator with full access'),
('Branch Manager', 'Manages branch operations and members'),
('User', 'Regular member with basic access'),
('Moderator', 'Can manage content and moderate discussions');
GO

-- Insert Status
IF NOT EXISTS (SELECT 1 FROM [Status])
INSERT INTO [Status] ([Name], [Description], Criteria) VALUES
('Welcomed', 'New member who has been welcomed', 'Completed welcome process'),
('Waiting for Sealing', 'Member waiting for sealing ceremony', 'Attended required sessions'),
('Sealed', 'Member has been sealed', 'Completed sealing ceremony'),
('Testifier', 'Active testifier in the church', 'Regularly testifies'),
('Inactive', 'Member currently inactive', 'No activity for 3+ months'),
('Passed', 'Member has passed away', 'Deceased member');
GO

-- Insert Activity
IF NOT EXISTS (SELECT 1 FROM Activity)
INSERT INTO Activity ([Name], [Description]) VALUES
('Sunday Service', 'Weekly Sunday worship service'),
('Bible Study', 'Weekly bible study groups'),
('Youth Meeting', 'Youth group meetings and activities'),
('Prayer Meeting', 'Weekly prayer sessions'),
('Community Outreach', 'Community service and outreach programs');
GO

-- Insert Members (Updated for EmploymentStatusID)
IF NOT EXISTS (SELECT 1 FROM Members)
INSERT INTO [dbo].[Members] (
    [FirstName], [LastName], [MaritalStatus], [DateOfBirth], [Gender],
    [Email], [Phone], [Password], [JoinDate], 
    [BranchID], [StatusID], [RoleID], [EmploymentStatusID], IsActive
) VALUES
-- Admin/Leadership
(N'John', N'Doe', 'Married', '1980-01-01', 'M', N'john.doe@example.com', N'1234567890', 
 CAST('password' AS VARBINARY(256)), '2000-05-20', 1, 3, 1, 2, 1),

(N'Zanele', N'Doe', 'Single', '1985-02-15', 'F', N'zanele.doe@example.com', N'1234567891', 
 CAST('password' AS VARBINARY(256)), '1997-05-20', 3, 2, 2, 3, 1),

(N'Londi', N'Doe', 'Single', '1978-03-20', 'M', N'londi.doe@example.com', N'1234567892', 
 CAST('password' AS VARBINARY(256)), '2018-05-20', 3, 5, 2, 2, 1),

-- Regular Members
(N'Xoli', N'Doe', 'Married', '1990-04-25', 'F', N'xoli.doe@example.com', N'1234567893', 
 CAST('password' AS VARBINARY(256)), '1995-05-20', 1, 6, 3, 1, 1),

(N'Zodwa', N'Doe', 'Single', '1995-05-30', 'F', N'zodwa.doe@example.com', N'1234567894', 
 CAST('password' AS VARBINARY(256)), '2015-05-20', 2, 1, 3, 4, 1),

(N'Zama', N'Doe', 'Married', '1988-06-10', 'F', N'zama.doe@example.com', N'1234567895', 
 CAST('password' AS VARBINARY(256)), '2001-05-20', 1, 5, 3, 2, 1),

(N'Sbonga', N'Doe', 'Single', '1992-07-15', 'M', N'sbonga.doe@example.com', N'1234567896', 
 CAST('password' AS VARBINARY(256)), '2002-05-20', 2, 1, 3, 3, 1);
GO

-- Insert MemberActivities
IF NOT EXISTS (SELECT 1 FROM MemberActivities)
INSERT INTO MemberActivities (MemberID, ActivityID, ParticipationDate, HoursParticipated) VALUES
(1, 1, '2024-01-15', 2.5), (1, 2, '2024-01-16', 1.5), (1, 4, '2024-01-17', 1.0),
(2, 1, '2024-01-15', 2.5), (2, 3, '2024-01-18', 2.0),
(3, 1, '2024-01-15', 2.5), (3, 5, '2024-01-19', 3.0),
(4, 1, '2024-01-15', 2.5), (4, 2, '2024-01-16', 1.5),
(5, 1, '2024-01-15', 2.5), (5, 4, '2024-01-17', 1.0);
GO

-- Insert Attendance
IF NOT EXISTS (SELECT 1 FROM Attendance)
INSERT INTO Attendance (MemberID, ActivityID, AttendanceDate, TimeIn, TimeOut, IsPresent) VALUES
(1, 1, '2024-01-15', '09:00', '11:30', 1),
(2, 1, '2024-01-15', '09:15', '11:30', 1),
(3, 1, '2024-01-15', '09:05', '11:00', 1),
(4, 1, '2024-01-15', '09:10', '11:30', 1),
(5, 1, '2024-01-15', '09:20', '11:15', 1),
(1, 2, '2024-01-16', '18:00', '19:30', 1),
(4, 2, '2024-01-16', '18:05', '19:30', 1);
GO

-- Insert Contributions
IF NOT EXISTS (SELECT 1 FROM Contributions)
INSERT INTO Contributions (MemberID, ContributionDate, Amount, ContributionType, PaymentMethod, ReferenceNumber) VALUES
(1, '2024-01-15', 500.00, 'Tithe', 'Bank Transfer', 'TXN001234'),
(2, '2024-01-15', 300.00, 'Tithe', 'Cash', NULL),
(3, '2024-01-15', 450.00, 'Tithe', 'Bank Transfer', 'TXN001235'),
(4, '2024-01-15', 200.00, 'Offering', 'Cash', NULL),
(5, '2024-01-15', 150.00, 'Offering', 'Mobile Money', 'MM001236'),
(1, '2024-01-22', 100.00, 'Building Fund', 'Bank Transfer', 'TXN001237'),
(2, '2024-01-22', 50.00, 'Donation', 'Cash', NULL);
GO

-- Insert MemberStatus (Status history)
IF NOT EXISTS (SELECT 1 FROM MemberStatus)
INSERT INTO MemberStatus (MemberID, StatusID, StartDate, EndDate, IsActive) VALUES
(1, 1, '2000-05-20', '2000-06-20', 0),
(1, 2, '2000-06-20', '2000-08-15', 0),
(1, 3, '2000-08-15', NULL, 1),
(2, 1, '1997-05-20', '1997-06-20', 0),
(2, 2, '1997-06-20', NULL, 1),
(3, 1, '2018-05-20', '2018-06-20', 0),
(3, 5, '2018-06-20', NULL, 1);
GO


DELETE FROM Contributions;
DELETE FROM Attendance;
DELETE FROM MemberActivities;
DELETE FROM MemberStatus;
DELETE FROM Members;
DELETE FROM Activity;
DELETE FROM Branches;
DELETE FROM Roles;
DELETE FROM [Status];
GO









