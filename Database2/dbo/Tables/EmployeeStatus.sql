CREATE TABLE [dbo].[EmployeeStatus] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Employment]  VARCHAR (50)  NULL,
    [Description] VARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

