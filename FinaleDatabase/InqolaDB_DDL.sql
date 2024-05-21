DROP TABLE [dbo].[Roles];
DROP TABLE [dbo].[Activity];
DROP TABLE [dbo].[Branches];
DROP TABLE [dbo].[Status];
DROP TABLE [dbo].[EmployeeStatus];
DROP TABLE [dbo].[Members];
DROP TABLE [dbo].[MemberActivities];

USE [InqolaYevangeli];

CREATE TABLE [dbo].[Roles] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
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
    [Name]     VARCHAR (100) NOT NULL,
    [Province] VARCHAR (50)  NOT NULL,
    [Country]  VARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Status] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    [Criteria]    VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[EmployeeStatus] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Employment]   VARCHAR (50)  NULL,
    [Description] VARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Members] (
    [ID]            INT          IDENTITY (1, 1) NOT NULL,
    [FirstName]     VARCHAR (50) NOT NULL,
    [LastName]      VARCHAR (50) NOT NULL,
    [MaritalStatus] BIT          NOT NULL,
    [DateOfBirth]   DATE         DEFAULT (format(getdate(),'yyyy-MM-dd')) NOT NULL,
    [Gender]        CHAR (1)     NOT NULL,
    [Email]         VARCHAR (50) NULL,
    [Phone]         VARCHAR (13) NULL,
    [Password]      VARCHAR (10) NULL,
    [JoinDate]      DATE         DEFAULT (format(getdate(),'yyyy-MM-dd')) NOT NULL,
    [BranchID]      INT          NOT NULL,
    [StatusID]      INT          NOT NULL,
    [RoleID]        INT          NOT NULL,
    [EmployeeID]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC),
    FOREIGN KEY ([BranchID]) REFERENCES [dbo].[Branches] ([ID]),
    FOREIGN KEY ([StatusID]) REFERENCES [dbo].[Status] ([ID]),
    FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([ID]),
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

