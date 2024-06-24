CREATE TABLE [dbo].[Members] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]     VARCHAR (50)  NULL,
    [LastName]      VARCHAR (50)  NULL,
    [MaritalStatus] BIT           NULL,
    [DateOfBirth]   DATE          DEFAULT (getdate()) NULL,
    [Gender]        CHAR (1)      NULL,
    [Email]         VARCHAR (50)  NULL,
    [Phone]         VARCHAR (13)  NULL,
    [Password]      VARCHAR (150) NULL,
    [JoinDate]      DATE          DEFAULT (getdate()) NULL,
    [BranchID]      INT           NULL,
    [StatusID]      INT           DEFAULT ((5)) NULL,
    [RoleID]        INT           DEFAULT ((3)) NULL,
    [EmployeeID]    INT           DEFAULT ((3)) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([BranchID]) REFERENCES [dbo].[Branches] ([ID]),
    FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[EmployeeStatus] ([ID]),
    FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([ID]),
    FOREIGN KEY ([StatusID]) REFERENCES [dbo].[Status] ([ID]),
    UNIQUE NONCLUSTERED ([Email] ASC)
);

