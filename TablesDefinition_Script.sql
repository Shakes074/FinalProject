CREATE DATABASE [InqolaYevangeli]
GO;

USE [InqolaYevangeli];
GO

-- 1. CREATE TABLES
-- =============================================

-- EmploymentStatus Table (was EmployeeStatus)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='EmploymentStatus' AND xtype='U')
CREATE TABLE EmploymentStatus (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Employment VARCHAR(150) NOT NULL UNIQUE,
    [Description] VARCHAR(250),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Branches Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Branches' AND xtype='U')
CREATE TABLE Branches (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(100) NOT NULL,
    Province VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Roles Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Roles' AND xtype='U')
CREATE TABLE Roles (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL UNIQUE,
    [Description] VARCHAR(150),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Status Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Status' AND xtype='U')
CREATE TABLE [Status] (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL UNIQUE,
    [Description] VARCHAR(150),
    Criteria VARCHAR(200),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Activity Table (was Activities)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Activity' AND xtype='U')
CREATE TABLE Activity (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL UNIQUE,
    [Description] VARCHAR(150),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Members Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Members' AND xtype='U')
CREATE TABLE Members (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    MaritalStatus VARCHAR(10) NOT NULL CHECK (MaritalStatus IN ('Single', 'Married', 'Divorced', 'Widowed')),
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    Email VARCHAR(50) NOT NULL UNIQUE,
    Phone VARCHAR(13),
    [Password] VARBINARY(256) NOT NULL,
    JoinDate DATE NOT NULL,
    BranchID INT NOT NULL FOREIGN KEY REFERENCES Branches(ID),
    StatusID INT NOT NULL FOREIGN KEY REFERENCES [Status](ID),
    RoleID INT NOT NULL FOREIGN KEY REFERENCES Roles(ID),
    EmploymentStatusID INT NOT NULL FOREIGN KEY REFERENCES EmploymentStatus(ID),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- MemberStatus Table (NEW - for status history)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MemberStatus' AND xtype='U')
CREATE TABLE MemberStatus (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL FOREIGN KEY REFERENCES Members(ID),
    StatusID INT NOT NULL FOREIGN KEY REFERENCES [Status](ID),
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Notes VARCHAR(500),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- MemberActivities Table (NEW - was ActivityMembers)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MemberActivities' AND xtype='U')
CREATE TABLE MemberActivities (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL FOREIGN KEY REFERENCES Members(ID),
    ActivityID INT NOT NULL FOREIGN KEY REFERENCES Activity(ID),
    ParticipationDate DATE NOT NULL,
    HoursParticipated DECIMAL(5,2) DEFAULT 0,
    Notes VARCHAR(500),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Attendance Table (NEW)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Attendance' AND xtype='U')
CREATE TABLE Attendance (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL FOREIGN KEY REFERENCES Members(ID),
    ActivityID INT NOT NULL FOREIGN KEY REFERENCES Activity(ID),
    AttendanceDate DATE NOT NULL,
    TimeIn TIME NULL,
    TimeOut TIME NULL,
    IsPresent BIT DEFAULT 1,
    Notes VARCHAR(500),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO
-- Contributions Table (NEW)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Contributions' AND xtype='U')
CREATE TABLE Contributions (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL FOREIGN KEY REFERENCES Members(ID),
    ContributionDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    ContributionType VARCHAR(50) NOT NULL CHECK (ContributionType IN ('Tithe', 'Offering', 'Donation', 'Building Fund', 'Other')),
    PaymentMethod VARCHAR(50) NOT NULL CHECK (PaymentMethod IN ('Cash', 'Bank Transfer', 'Credit Card', 'Debit Card', 'Mobile Money')),
    ReferenceNumber VARCHAR(100),
    Notes VARCHAR(500),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO


-- =============================================
-- Create Indexes for Better Performance
-- =============================================
CREATE INDEX IX_Members_Email ON Members(Email);
CREATE INDEX IX_Members_BranchID ON Members(BranchID);
CREATE INDEX IX_Members_StatusID ON Members(StatusID);
CREATE INDEX IX_Members_RoleID ON Members(RoleID);
CREATE INDEX IX_Members_EmploymentStatusID ON Members(EmploymentStatusID);
CREATE INDEX IX_MemberActivities_MemberID ON MemberActivities(MemberID);
CREATE INDEX IX_MemberActivities_ActivityID ON MemberActivities(ActivityID);
CREATE INDEX IX_MemberStatus_MemberID ON MemberStatus(MemberID);
CREATE INDEX IX_MemberStatus_StatusID ON MemberStatus(StatusID);
CREATE INDEX IX_Attendance_MemberID ON Attendance(MemberID);
CREATE INDEX IX_Attendance_Date ON Attendance(AttendanceDate);
CREATE INDEX IX_Contributions_MemberID ON Contributions(MemberID);
CREATE INDEX IX_Contributions_Date ON Contributions(ContributionDate);

-- Create a filtered unique index for active member activities
CREATE UNIQUE INDEX UQ_MemberActivity_Active 
ON MemberActivities(MemberID, ActivityID) 
WHERE IsActive = 1;
GO

-- Create unique constraint for attendance to prevent duplicate entries
CREATE UNIQUE INDEX UQ_Attendance_MemberDateActivity 
ON Attendance(MemberID, AttendanceDate, ActivityID) 
WHERE ActivityID IS NOT NULL;

CREATE UNIQUE INDEX UQ_Attendance_MemberDate 
ON Attendance(MemberID, AttendanceDate) 
WHERE ActivityID IS NULL;
GO

-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS Contributions;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS MemberStatus;
DROP TABLE IF EXISTS MemberActivities;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS EmploymentStatus;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS [Status];
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Branches;
GO



